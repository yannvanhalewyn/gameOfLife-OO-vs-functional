(ns gameOfLife.core
  (:gen-class)
  (:require [gameOfLife.world :as world]
            [gameOfLife.print :as print]
            [gameOfLife.logic :as logic]))

(def WIDTH 60)
(def HEIGHT 40)
(def SLEEP 300)
(def STEPS 100)

(defn -main []
  (loop [world (world/new-world WIDTH HEIGHT) count 0]
    (println (print/world->str world))
    (Thread/sleep SLEEP)
    (if (= count STEPS)
      "Done!"
      (recur (logic/take-step world) (inc count)))))

(-main)
