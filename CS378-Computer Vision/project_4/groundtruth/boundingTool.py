# reference link: http://docs.opencv.org/trunk/doc/py_tutorials/py_gui/py_mouse_handling/py_mouse_handling.html#mouse-handling
# reference link: http://stackoverflow.com/questions/16195190/python-cv2-how-do-i-draw-a-line-on-an-image-with-mouse-then-return-line-coord

import cv2
import json
import numpy as np

top_left_points = []
bottom_right_points = []
initial_x, initial_y = -1, -1
drawing = False  # set to true when mouse is clicked
originalImage = []  # to restore image when a square is deleted
img = []


def main():
    img = cv2.imread("../images/smallPano_small.png")
    originalImage = np.copy(img)  # so we can reset the image when we delete a square

    cv2.namedWindow("window")
    cv2.setMouseCallback("window", draw)

    while True:
        cv2.imshow("window", img)
        k = cv2.waitKey(1) & 0xFF
        if k == 27:
            break

    file = open('groundtruth.txt', 'w')
    # gotten all bounding boxes of tape
    assert len(top_left_points) == len(bottom_right_points)

    json.dump([dict(topleft_x=topleft[0],
                    topleft_y=topleft[1],
                    bottomright_x=bottomright[0],
                    bottomright_y=bottomright[1])
               for topleft, bottomright in zip(top_left_points, bottom_right_points)], file)

    cv2.destroyAllWindows()


def draw(event, x, y, flags, param):
    """
    gets mouse/keyboard events and does different actions based on events
    :param event: the actual event
    :param x: x position of the mouse at the time event was performed
    :param y: x position of the mouse at the time event was performed
    :param flags:
    :param param:
    :return:
    """

    global initial_x, initial_y, drawing, originalImage

    # start drawing square when left button is pushed down
    if event == cv2.EVENT_LBUTTONDOWN:
        top_left_points.append((x, y))
        initial_x, initial_y = x, y
        drawing = True

    # draw square when mouse moves, and left button is clicked
    elif event == cv2.EVENT_MOUSEMOVE:
        if drawing:
            # -1 in last param is a filled square
            # not a bounding box b/c draws successive boxes
            cv2.rectangle(img, (initial_x, initial_y), (x, y), (0, 255, 0), -1)

    # stop drawing square when left button is release and turn drawing off
    elif event == cv2.EVENT_LBUTTONUP:
        bottom_right_points.append((x, y))
        drawing = False

    # deletes ONLY the last square drawn when right mouse button is pushed down
    elif event == cv2.EVENT_RBUTTONDOWN:
        bottomright_del = bottom_right_points.pop()
        topleft_del = top_left_points.pop()
        img[topleft_del[1]:bottomright_del[1], topleft_del[0]: bottomright_del[0]] \
            = originalImage[topleft_del[1]:bottomright_del[1], topleft_del[0]: bottomright_del[0]]

if __name__ == "__main__":
    main()