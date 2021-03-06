module Main where
import Graphics.SOE.Gtk
import Draw
import Shape

sh1 = Rectangle 3 2
sh2 = Ellipse 1 1.5
sh3 = RtTriangle 3 2
sh4 = Polygon [(-2.5, 2.5), (-1.5, 2.0), (-1.1, 0.2), (-1.7, -1.0), (-3.0, 0)]

main = runGraphics $
    do  w <- openWindow "My window" (xWin, yWin)
        drawShapes w shs
        spaceClose w

shs = [(Red, sh1), (Blue, sh2), (Yellow, sh3), (Magenta, sh4)]

drawShapes w = mapM_(\(c, s) -> drawInWindow w $ withColor c $ shapeToGraphic s)

