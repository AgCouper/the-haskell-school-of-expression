module Main where
import Graphics.SOE.Gtk
import Draw
import Perimeter
import Region

sh1 = Rectangle 3 2
sh2 = Ellipse 1 1.5
sh3 = RtTriangle 3 2
sh4 = Polygon [(-3.0, 0), (-1.7, -1.0), (-1.1, 0.2), (-1.5, 2.0), (-2.5, 2.5)]

sh = ((Shape sh1 `Union` Shape sh2) `Union` Shape sh3) `Union` Shape sh4

main = runGraphics $
    do  w <- openWindow "My window" (xWin, yWin)
        -- drawShapes w shs
        drawPoints w (regionToGraphicPoints sh)
        spaceClose w

shs = [(Red, sh1), (Blue, sh2), (Yellow, sh3), (Magenta, sh4)]

drawShapes w = mapM_(\(c, s) -> drawInWindow w $ withColor c $ shapeToGraphic s)
drawPoints w = mapM_(\(x, y) -> drawInWindow w $ withColor White $ line (x, y) (x + 1, y + 1))
