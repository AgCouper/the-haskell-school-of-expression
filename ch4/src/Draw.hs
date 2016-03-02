
module Draw (inchToPixel, pixelToInch, intToFloat, xWin, yWin, trans, shapeToGraphic, spaceClose) where
import Graphics.SOE.Gtk
import Shape

intToFloat :: Int -> Float
intToFloat n = fromInteger (toInteger n)

inchToPixel :: Float -> Int
inchToPixel x = round (100 * x)

pixelToInch :: Int -> Float
pixelToInch n = intToFloat n / 100

xWin = 600
xWin2 = div xWin 2

yWin = 500
yWin2 = div yWin 2

trans :: Vertex -> Point
trans (x, y) = (xWin2 + inchToPixel x, yWin2 - inchToPixel y)

transList  = map trans

shapeToGraphic (Rectangle s1 s2) =
    let s12 = s1/2
        s22 = s2/2
    in polygon $ transList [(-s12, -s22), (-s12, s22), (s12, s22), (s12, -s22)]

shapeToGraphic (Ellipse r1 r2) =
    ellipse (trans (-r1, -r2)) (trans (r1, r2))

shapeToGraphic (RtTriangle s1 s2) =
    polygon $ transList [(0, 0), (s1, 0), (0, s2)]

shapeToGraphic (Polygon vts) =
    polygon $ transList vts

spaceClose :: Window -> IO()
spaceClose w = do
    k <- getKey w
    if k == ' ' then
        closeWindow w
    else
        spaceClose w

