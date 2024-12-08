#!/usr/bin/sh
#_(
   exec clojure -M "$0" "$@"
)

(ns aoc-2024-09
  (:require [clojure.set :as set]
            [clojure.string :as str]))

(when-not (= (count *command-line-args*) 1)
  (.println *err* "Usage: day9 <filename>")
  (System/exit 1))

(println "Hello from Clojure!")

(def lines (str/split-lines (slurp (first *command-line-args*))))

(doseq [[i line] (map-indexed vector lines)]
  (println (format "line %d: '%s'" i line)))
