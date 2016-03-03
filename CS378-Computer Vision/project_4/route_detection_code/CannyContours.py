__author__ = 'ashleyng'
import cv2
import numpy as np
MIN_AREA = 136

img = cv2.imread("../images/smallPano_small.png")
hsv = cv2.cvtColor(img, cv2.cv.CV_BGR2HSV)
ret, thresh = cv2.threshold(hsv[:, :, 1], 100, 255, 0)
boundingBoxes = []

contours, hierarchy = cv2.findContours(thresh, cv2.RETR_LIST, cv2.CHAIN_APPROX_SIMPLE)

for index, contour in enumerate(contours):
    area = cv2.contourArea(contour)
    if area > MIN_AREA:
        x, y, w, h = cv2.boundingRect(contour)
        boundingBoxes.append((x, y, w, h))
        cv2.rectangle(img, (x, y), (x+w, y+h), (0, 255, 0), 2)
        # cv2.drawContours(img, contour, -1, (0, 255, 0), 3)

# generate mask from bounding box
mask = np.zeros(img.shape, np.uint8)
for (x, y, w, h) in boundingBoxes:
    bit_mask = np.zeros(img.shape, np.uint8)

    # make mask on color image
    mask[y:y+h, x:x+w] = img[y:y+h, x:x+w]

    # 8 bit mask
    bit_mask[y:y+h, x:x+w] = 255

    # # find mean color in bounding box
    mean_color = cv2.mean(img, bit_mask)
    print mean_color

cv2.imshow("mask", bit_mask)
cv2.waitKey(0)
cv2.destroyAllWindows()