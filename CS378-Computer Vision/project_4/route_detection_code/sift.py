import cv2

img = cv2.imread("../images/smallPano_small.png")

sift = cv2.SIFT(nfeatures=0,
                nOctaveLayers=1,
                contrastThreshold=.09,
                edgeThreshold=25,
                sigma=1.)
keypoints, des = sift.detectAndCompute(img, None)

img = cv2.drawKeypoints(img, keypoints, flags=cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)
# cv2.imwrite("../images/routeDetection/sift.png", img)
# cv2.imshow("keypoints", img)
# cv2.waitKey(0)
# cv2.destroyAllWindows()

