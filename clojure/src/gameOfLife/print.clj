(ns gameOfLife.print)

(def ^:const boxTopLeft     "┌")
(def ^:const boxTopRight    "┐")
(def ^:const boxBottomLeft  "└")
(def ^:const boxBottomRight "┘")
(def ^:const boxLine        "─")
(def ^:const boxSide        "│")

(defn line
  "returns a line of length n"
  [n]
  (apply str (repeat n boxLine)))

(defn frameTop [n]
  (str boxTopLeft (line n) boxTopRight "\n"))

(defn frameBottom [n]
  (str boxBottomLeft (line n) boxBottomRight "\n"))

(defn cell->str [cell]
  (if (= 1 cell)
    "o"
    " "))

(defn row->str [row]
  (str
   boxSide
   (apply str (map cell->str row))
   boxSide
   "\n"))

(defn world->str [world]
  (let [world-width (count (get world 0))]
    (str
     (frameTop world-width)
     (apply str (map row->str world))
     (frameBottom world-width)
     "\n")))
