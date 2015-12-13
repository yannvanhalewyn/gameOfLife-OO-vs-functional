(ns gameOfLife.logic)

(defn vec2
  "Returns a vector with :x and :y coords"
  [x y]
  {:x x :y y})

(defn addVec2
  "Adds two 2d vectors together"
  [a b]
  (vec2 (+ (:x a) (:x b)) (+ (:y a) (:y b))))

(def ^:const neighbourOffsets
  [(vec2 -1 -1) (vec2 0 -1) (vec2 1 -1)
   (vec2 -1  0)             (vec2 1  0)
   (vec2 -1  1) (vec2 0  1) (vec2 1  1)])

(defn is-alive?
  "Returns true if the cell at postition {x,y} exists and is alive in
  $WORLD"
  [world point]
  (when-let [row (get world (:y point))]
    (when-let [cell (get row (:x point))]
      (= 1 cell))))

(defn neighbour-coords
  "Returns a list of vectors representing the coordinates of all
  neighbours"
  [point]
  (map (partial addVec2 point) neighbourOffsets))

(defn neighbour-map
  "Returns a list of booleans representing the living state of the 8
  neighbours of a given cell"
  [world point]
  (map (partial is-alive? world) (neighbour-coords point)))

(defn count-alive-neighbours
  "Returns the number of alive neighbours a given cell in the world has"
  [world x y]
  (count
   (filter identity (neighbour-map world (vec2 x y)))))

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
