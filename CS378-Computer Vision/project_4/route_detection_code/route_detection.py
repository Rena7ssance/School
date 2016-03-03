import cv2
import numpy as np

img = cv2.imread("../images/smallPano_small.png")
#img = cv2.medianBlur(img,5)

#th3 = cv2.adaptiveThreshold(img,255,cv2.ADAPTIVE_THRESH_GAUSSIAN_C,\
#            cv2.THRESH_BINARY,11,2)

hsv = cv2.cvtColor(img, cv2.cv.CV_BGR2HSV)
#cv2.imshow('hsv', hsv[:,:,1])
(thresh, im_bw) = cv2.threshold(hsv[:,:,1], 100, 255, cv2.THRESH_BINARY)
cv2.imshow('im_bw', im_bw)
# edges = cv2.Canny(im_bw,50,150,apertureSize = 3)
# cv2.imshow('edges', edges)

# img = cv2.imread("images/smallPano.png")
# gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
# edges = cv2.Canny(gray,50,150,apertureSize = 3)
# lines = cv2.HoughLines(im_bw,1,np.pi/180,30)
# for rho,theta in lines[0]:
#     a = np.cos(theta)
#     b = np.sin(theta)
#     x0 = a*rho
#     y0 = b*rho
#     x1 = int(x0 + 10*(-b))
#     y1 = int(y0 + 10*(a))
#     x2 = int(x0 - 10*(-b))
#     y2 = int(y0 - 10*(a))
#     print (x1,y1),(x2,y2)
#     cv2.line(img,(x1,y1),(x2,y2),(0,0,255),2)


# cv2.imshow("img", img)
cv2.waitKey(0)
cv2.destroyAllWindows()