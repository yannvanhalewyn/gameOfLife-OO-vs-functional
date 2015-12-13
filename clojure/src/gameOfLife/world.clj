(ns gameOfLife.world)

(defn random-cell []
  (if (< 15 (rand 20))
    1
    0))

(defn random-row
  "Generates a random row of length $WIDTH"
  [width]
  (into []
        (take width (repeatedly random-cell))))

(defn new-world
  "Generates a new 2D array representing the game of live board with WIDTH and HEIGHT"
  [width height]
  (into []
        (take height (repeatedly #(random-row width)))))
