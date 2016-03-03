"""Project 0: Image Manipulation with OpenCV.

In this assignment, you will implement a few basic image
manipulation tasks using the OpenCV library.

Use the unit tests is image_manipulation_test.py to guide
your implementation, adding functions as needed until all
unit tests pass.
"""

# TODO: Implement!

import cv2
import numpy
import image_manipulation


def flip_image(image, horizontal, vertical):
    if horizontal is True and vertical is True:
        return cv2.flip(image, -1)
    elif vertical is True and horizontal is False:
        return cv2.flip(image, 0)
    elif horizontal is True and vertical is False:
        return cv2.flip(image, 1)
    else:
        return image


def negate_image(image):
    b, g, r = cv2.split(image)
    image = cv2.merge((255 - b, 255 - g, 255 - r))
    return image


def swap_blue_and_green(image):
    b, g, r = cv2.split(image)
    image = cv2.merge((g, b, r))
    return image
