
module Draw (inchToPixel, pixelToInch, intToFloat, xWin, yWin,
             shapeToGraphic, regionToScanline, spaceClose) where
import Graphics.SOE.Gtk
import Region

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

vertexToPoint :: Vertex -> Point
vertexToPoint (x, y) = (xWin2 + inchToPixel x, yWin2 - inchToPixel y)

pointToVertex :: Point -> Vertex
pointToVertex (x, y) = (pixelToInch(x - xWin2), pixelToInch(yWin2 - y))

shapeToGraphic (Rectangle s1 s2) =
    let s12 = s1/2
        s22 = s2/2
    in polygon $  map vertexToPoint [(-s12, -s22), (-s12, s22), (s12, s22), (s12, -s22)]

shapeToGraphic (Ellipse r1 r2) =
    ellipse (vertexToPoint (-r1, -r2)) (vertexToPoint (r1, r2))

shapeToGraphic (RtTriangle s1 s2) =
    polygon $ map vertexToPoint [(0, 0), (s1, 0), (0, s2)]

shapeToGraphic (Polygon vts) =
    polygon $ map vertexToPoint vts

regionToScanline r y =
    [ x | x <- [0..xWin], r `containsR` pointToVertex (x, y)]

spaceClose :: Window -> IO()
spaceClose w = do
    k <- getKey w
    if k == ' ' then
        closeWindow w
    else
        spaceClose w

