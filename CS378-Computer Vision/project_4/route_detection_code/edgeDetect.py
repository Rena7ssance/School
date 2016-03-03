import cv2

img = cv2.imread("../images/smallPano.png", 0)
edge = cv2.Canny(img, 180, 300)

# clahe = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(8,8))
# cl1 = clahe.apply(img)
cv2.imshow("edge", edge)
cv2.waitKey(0)
cv2.destroyAllWindows()

# cv2.imwrite("../images/routeDetection/canny.png", edge)