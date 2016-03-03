__author__ = 'ashleyng'

import json
import cv2
import numpy as np

"""
both json files are in the format of
[{ 'bottomright_y': ___, 'bottomright_x': __, 'topleft_x': ___, 'topleft_y': ____}, ...]

Overlapping rectangles:
http://tech-read.com/2009/02/06/program-to-check-rectangle-overlapping/
The left edge of groundtruth is to the left of right edge of calculated.
The top edge of groundtruth is above the calculated bottom edge.
The right edge of groundtruth is to the right of left edge of calculated.
The bottom edge of groundtruth is below the calculated upper edge.
"""

# minimum % area the calculated box has to overlap the groundtruth box
MIN_AREA_ACCURACY = .10


def main():
    file = open('../groundtruth/groundtruth.txt', 'r')
    groundtruth = json.load(file)

    file = open('calculated.txt', 'r')
    data = json.load(file)

    img = cv2.imread("../images/smallpano_small.png")
    img_copy = np.copy(img)

    true_positives = []
    for groundtruth_corner in reversed(groundtruth):
        # go backwards so you can delete along the way
        for i in xrange(len(data)-1, -1, -1):
            calculated_corner = data[i]
            is_overlap = rectangle_overlap(calculated_corner, groundtruth_corner)
            # if the boxes overlap draw the calculated rectangle on the image
            if is_overlap:
                true_positives.append(calculated_corner)
                # draw rectangle on image
                cv2.rectangle(img_copy, (calculated_corner['topleft_x'], calculated_corner['topleft_y']),
                              (calculated_corner['bottomright_x'], calculated_corner['bottomright_y']),
                              (0, 255, 0), 2)
                # remove the square you used
                del data[i]


    cv2.imshow("window", img_copy)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
    cv2.imwrite("../images/routeDetection/true_positives.png", img_copy)
    ratio = float(len(true_positives))/float(len(groundtruth)) * 100
    print "Accuracy of calculated boxes to groundtruth boxes: " + str(ratio) + "%"


def rectangle_overlap(calucated, groundtruth):
    """
    See if groundtruth box and calculated box overloat
    :param calucated: dictionary of topleft and bottom right points
    :param groundtruth: dictionary of topleft and bottom right points
    :return: if boxes over lap, return true, else return false
    """
    # see if boxes overlap
    if (groundtruth['topleft_x'] < calucated['bottomright_x'] and
        groundtruth['topleft_y'] < calucated['bottomright_y'] and
        groundtruth['bottomright_x'] > calucated['topleft_x'] and
        groundtruth['bottomright_y'] > calucated['topleft_y']):

        # get the points of the area they overlap
        final_area_tl_y = max(groundtruth['topleft_y'], calucated['topleft_y'])
        final_area_tl_x = max(groundtruth['topleft_x'], calucated['topleft_x'])
        final_area_br_y = min(groundtruth['bottomright_y'], calucated['bottomright_y'])
        final_area_br_x = min(groundtruth['bottomright_x'], calucated['bottomright_x'])

        # calculate the area of the overlap
        final_area = abs(final_area_br_x - final_area_tl_x) * abs(final_area_br_y - final_area_tl_y)
        # calculate area of groundtruth box
        groundtruth_area = abs(groundtruth['bottomright_x'] - groundtruth['topleft_x']) * \
                           abs(groundtruth['bottomright_y'] - groundtruth['topleft_y'])
        # compare overlap to groundtruth area
        area = float(final_area)/float(groundtruth_area)
        if area > MIN_AREA_ACCURACY:
            return True
    return False

if __name__ == "__main__":
    main()