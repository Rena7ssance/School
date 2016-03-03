-- Name: Riley Gibson
-- UT EID: Rdg766

data Geometry = Point Int Int -- x, y
			  | Circle Int Int Int -- x, y, radius
			  | Rectangle Int Int Int Int -- x1, y1, x2, y2
			  | Triangle Int Int Int Int Int Int -- x1, y1, x2, y2, x3, y3
			  | Group [Geometry] 	

area :: Geometry -> Float
area (Point _ _) = 0.0
area (Circle _ _ r) = pi * (fromIntegral r) ^ 2
area (Rectangle w x y z) = (abs $ (fromIntegral w) - (fromIntegral y)) * (abs $ (fromIntegral x) - (fromIntegral z))
area (Triangle ax ay bx by cx cy) = abs $ ((((fromIntegral ax * (fromIntegral by - fromIntegral cy)) + (fromIntegral bx * (fromIntegral cy - fromIntegral ay)) + (fromIntegral cx * (fromIntegral ay - fromIntegral by))) / 2))
area (Group []) = 0.0
area (Group (g:gs)) = area g + area (Group gs)


boundingBox :: Geometry -> (Float, Float, Float, Float)
boundingBox (Point _ _) = (0.0, 0.0, 0.0, 0.0)
boundingBox (Circle x y r) = ((fromIntegral x) - (fromIntegral r), (fromIntegral y) - (fromIntegral r), (fromIntegral x) + (fromIntegral r), (fromIntegral y) + (fromIntegral r))
boundingBox (Rectangle w x y z) = (fromIntegral w, fromIntegral x, fromIntegral y, fromIntegral z)
boundingBox (Triangle ax ay bx by cx cy) =  (fromIntegral (min (min ax bx) cx), fromIntegral (min (min ay by) cy), fromIntegral (max (max ax bx) cx), fromIntegral (max (max ay by) cy))
boundingBox (Group []) = (0.0, 0.0, 0.0, 0.0)
boundingBox (Group (g:gs)) = result (boundingBox g) (boundingBox (Group gs))

result :: (Float, Float, Float, Float) -> (Float, Float, Float, Float) -> (Float, Float, Float, Float)
result (a,b,c,d) (w,x,y,z) = (min a w, min b x, max c y, max d z)