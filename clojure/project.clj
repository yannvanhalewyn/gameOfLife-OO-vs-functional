(defproject gameOfLife "0.1.0-SNAPSHOT"
  :dependencies [[org.clojure/clojure "1.7.0"]]
  :main gameOfLife.core
  :bin {:name "gol"
        :bin-path "bin/"}
  :target-path "target/%s")
