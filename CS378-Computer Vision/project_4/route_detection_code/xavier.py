import cv2
import numpy as np
img = cv2.imread("../images/smallpano.png")
hsv = cv2.cvtColor(img, cv2.cv.CV_BGR2HLS)
retval, threshold = cv2.threshold(hsv[:, :, 2],84, 255,cv2.THRESH_BINARY)

# get all the contours from the thresh image
mask = np.zeros(img.shape,np.uint8)
contours, heirarchy = cv2.findContours(threshold,cv2.RETR_LIST,cv2.CHAIN_APPROX_NONE)

#print(len(contours))
for index, contour in enumerate(contours):
    area = cv2.contourArea(contour)
    if area > 20:
        cv2.drawContours(mask, contours, index, 255,-1)
        #cv2.drawContours(img, contours, index, 255,-1)
pixelpoints = np.transpose(np.nonzero(mask))
npixelpoints = set()
for x,y,z in pixelpoints :
    npixelpoints.add((x,y))

for index, contour, in enumerate(contours) :
    area = cv2.contourArea(contour)
    if area > 20:
        x, y, w, h = cv2.boundingRect(contour)
        avg = 0
        cnt = 0
        for i in range(x,x+w) :
            for j in range(y,y+h) :
                if (j,i) in npixelpoints :
                    avg += hsv[j][i][0]
                    cnt+=1
        avg/=cnt
        cv2.putText(img,str(avg)+"*",(x,y),cv2.FONT_HERSHEY_SIMPLEX,1,255)



#print(len(pixelpoints))


cv2.imwrite("labeled.jpg",img)
cv2.waitKey(0)