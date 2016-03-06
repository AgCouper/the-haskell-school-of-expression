module Region (Region (Shape, Translate, Scale, Complement, Union, Intersect, Empty),
               Coordinate, containsS, containsR,
               module Shape) where
import Shape

infixr 5 `Union`
infixr 6 `Intersect`

type Coordinate = (Float, Float)
type Vector = (Float, Float)
type Ray = (Coordinate, Coordinate)

data Region = Shape Shape                   -- primitive shape
            | Translate Vector Region       -- translated region
            | Scale Vector Region           -- scaled region
            | Complement Region             -- inverse of region
            | Region `Union` Region         -- union of regions
            | Region `Intersect` Region     -- intersection of regions
            | Empty                         -- empty region
    deriving Show

containsS :: Shape -> Coordinate -> Bool

(Rectangle s1 s2) `containsS` (x, y) =
    -t1 <= x && x <= t1 && -t2 <= y && y <= t2
    where t1 = s1/2
          t2 = s2/2

(Ellipse r1 r2) `containsS` (x, y) =
    (x/r1)^2 + (y/r2)^2 <= 1

(Polygon pts) `containsS` p = and leftOfList
    where leftOfList = map (isLeftOf p)
                           (zip pts (tail pts ++ [head pts]))

(RtTriangle s1 s2) `containsS` p =
    Polygon [(0, 0), (s1, 0), (0, s2)] `containsS` p

(px, py) `isLeftOf` ((ax, ay), (bx, by)) = s * v >= t * u
    where (s, t) = (px - ax, py - ay)
          (u, v) = (px - bx, py - by)


containsR :: Region -> Coordinate -> Bool

Empty `containsR` p = False

(Shape s) `containsR` p =
    s `containsS` p

(Translate (u, v) r) `containsR` (x, y) =
    r `containsR` (x - u, y - v)

(Scale (u, v) r) `containsR` (x, y) =
    r `containsR` (x/u, y/v)

(Complement r) `containsR` p =
    not $ r `containsR` p

(r1 `Union` r2) `containsR` p =
    r1 `containsR` p || r2 `containsR` p

(r1 `Intersect` r2) `containsR` p =
    r1 `containsR` p && r2 `containsR` p

