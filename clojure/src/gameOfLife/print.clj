(ns gameOfLife.print)

(defn cell->str [cell]
  (if (= 1 cell)
    "o"
    " "))

(defn row->str [row]
  (str
   (apply str (map cell->str row))
   "\n"))

(defn world->str [world]
  (str
   (apply str (map row->str world))
   "\n"))
