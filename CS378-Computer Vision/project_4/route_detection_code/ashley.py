# reference site: http://codegenerater.blogspot.com/2013/07/opencv-python-simple-trackbar-code-for.html

import cv2
import numpy as np
import json

def main():
    img = cv2.imread("../images/smallPano_small.png")
    thresh_img = threshold_gui(img)
    contours_img, bounding_boxes = contours_gui(thresh_img, img)
    mask = make_mask(img, bounding_boxes)

    boundingbox_values = open("../accuracyCheck/calculated.txt", 'w')
    json.dump([dict(topleft_x=x,
                    topleft_y=y,
                    bottomright_x=x+w,
                    bottomright_y=y+h)
               for (x, y, w, h) in bounding_boxes], boundingbox_values)

# for the create trackbar onChange param
def nothing(x):
    None


def threshold_gui(img):
    """
    produces a GUI that allows you to fine tune
    the lower bounds of the threshold function
    :param img: image we'll be using
    :return: the threshold image with the fine tuned variable applied
    """
    hsl = cv2.cvtColor(img, cv2.cv.CV_BGR2HLS)
    cv2.namedWindow("window")

    # Loop for get trackbar pos and process it
    # Apply threshold
    retval, threshold = cv2.threshold(hsl[:, :, 2],
                                      84, 255,
                                      cv2.THRESH_BINARY)
    # Show in window
    cv2.imshow("window", threshold)

    # cv2.imwrite("../images/routeDetection/threshold_gui_image.png", threshold)
    cv2.destroyAllWindows()
    return threshold


def contours_gui(thresh, img):
    """
    produces a GUI to fine tune the minimum area allowed to be drawn
    primarily gets rid of the contours of the bolt holes
    :param thresh: the threshold image used to produce the contours
    :param img: the original image that will be drawn on
    :return: image that has the contours drawn on it with the
        fine tuned min area variable
            array of bounding boxes generated from contours

    """
    bounding_boxes = []
    cv2.namedWindow("window")


    # get all the contours from the thresh image
    contours, heirarchy = cv2.findContours(thresh,
                                           cv2.RETR_EXTERNAL,
                                           cv2.CHAIN_APPROX_NONE)

    # make copy of image b/c rect and draw overwrite original
    img_copy = np.copy(img)

    # Apply contour min area
    for contour in contours:
        area = cv2.contourArea(contour)
        if area > 62:
            # draw bounding rectangle
            x, y, w, h = cv2.boundingRect(contour)
            bounding_boxes.append((x, y, w, h))
            cv2.rectangle(img_copy, (x, y), (x+w, y+h), (0, 255, 0), 2)

            # draw contours
            # cv2.drawContours(img_copy, contour, -1, (0, 255, 0), 3)

    # Show in window
    cv2.imshow("window", img_copy)
    # cv2.imwrite("../images/routeDetection/contour_gui_image.png", img_copy)
    return img_copy, bounding_boxes


def make_mask(img, bounding_boxes):
    """
    generates a mask of the bounding boxes on top of img
    :param img: the original color image
    :param bounding_boxes: a list of (x, y, w, h) variables of the bounding boxes
    :return: the image mask
    """
    mask = np.zeros(img.shape, np.uint8)
    for (x, y, w, h) in bounding_boxes:
        mask[y:y+h, x:x+w] = img[y:y+h, x:x+w]
    # cv2.imwrite("../images/routeDetection/mask_gui_image.png", mask)
    return mask

if __name__ == "__main__":
    main()





