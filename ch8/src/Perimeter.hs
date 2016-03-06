module Perimeter (perimeter, ellipsePerim, module Shape) where
import Shape

perimeter :: Shape -> Float

perimeter (Rectangle s1 s2) = 2 * (s1 + s2)
perimeter (RtTriangle s1 s2) = s1 + s2 + sqrt(s1^2 + s2^2)
perimeter (Polygon vs) = sum (sides vs)
perimeter (Ellipse r1 r2)
    | r1 > r2 = ellipsePerim r1 r2
    | otherwise = ellipsePerim r2 r1


sides :: [Vertex] -> [Side]
sides vs = zipWith distBetween vs (tail vs ++ [head vs])

epsilon = 0.0000001 :: Float

nextEl :: Float -> Float -> Float -> Float
nextEl e s i = s * (2*i - 1) * (2*i - 3) * (e^2)/(4 * i^2)

genS :: Float -> [Float]
genS e = takeWhile (> epsilon) (scanl (nextEl e) s1 [2..])
    where s1 = 0.25 * (e^2)

ellipsePerim r1 r2 =
    2 * r1 * pi * (1 - sum (genS e))
    where e = sqrt(r1^2 - r2^2) / r1


