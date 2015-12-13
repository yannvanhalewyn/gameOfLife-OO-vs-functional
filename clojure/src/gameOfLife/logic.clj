(ns gameOfLife.logic)

(defn is-alive?
  "Returns true if the cell at postition {x,y} exists and is alive in $WOLRD"
  [world x y]
  (when-let [row (get world y)]
    (when-let [cell (get row x)]
      (= 1 cell))))

(defn neighbour-map
  "Returns a list of booleans representing the living state of the 8
  neighbours of a given cell"
  [world x y]
  (map (partial is-alive? world)
                [(- x 1) (- x 1) (- x 1) x x (+ x 1) (+ x 1) (+ x 1)]
                [(- y 1) y (+ y 1) (- y 1) (+ y 1) (- y 1) y (+ y 1)]))

(defn count-alive-neighbours
  "Returns the number of alive neighbours a given cell in the world has"
  [world x y]
  (count
   (filter identity (neighbour-map world x y))))

(defn cell-step
  "Determines wether the cell survives, dies or comes to live
  depending on the cell's original state and the number of neighbours"
  [cell neighbourCount]
  (if (and (= cell 0) (= 3 neighbourCount))
    1
    (if (or (and (= cell 1) (< neighbourCount 2))
            (and (= cell 1) (> neighbourCount 3)))
      0
      cell)))

(defn take-step
  "Recalculates the state of every cell and returns a new
  representation of the world"
  [world]
  (into []
        (map-indexed (fn [y row]
                       (into []
                             (map-indexed
                              (fn [x cell]
                                (cell-step cell (count-alive-neighbours world x y)))
                              row)))
                     world)))
