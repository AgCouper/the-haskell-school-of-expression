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
        mydrawRegion w sh
        spaceClose w

shs = [(Red, sh1), (Blue, sh2), (Yellow, sh3), (Magenta, sh4)]

drawShapes w = mapM_(\(c, s) -> drawInWindow w $ withColor c $ shapeToGraphic s)
drawScanline w y = mapM_(\(x1, x2) -> drawInWindow w $ withColor White $ line (x1, y) (x2, y))
mydrawRegion w r = mapM_(\y -> drawScanline w y (scanlineToRange $ regionToScanline r y)) [0..yWin]

-- converts list of ints into list of ranges
-- for example: [1, 2, 3, 6, 7, 8] = > [(1,3), (6,8)]
scanlineToRange [] = []
scanlineToRange [x] = [(x, x)]
scanlineToRange (x:xs) = fst a : snd a
    where a = foldl scanlineFold ((x, x), []) xs

scanlineFold ((rangeMin, rangeMax), rangeList) val  =
  if val == rangeMax + 1 then
      ((rangeMin, rangeMax + 1), rangeList)
  else
      ((val, val), (rangeMin, rangeMax):rangeList)
