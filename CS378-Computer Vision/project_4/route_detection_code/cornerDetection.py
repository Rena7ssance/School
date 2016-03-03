import cv2

img = cv2.imread("../images/smallPano_small.png", 0)

corner = cv2.cornerHarris(img, 5, 7, 0.1)
dilate = cv2.dilate(corner, None)

cv2.imshow("corner", dilate)
cv2.waitKey(0)
cv2.destroyAllWindows()
