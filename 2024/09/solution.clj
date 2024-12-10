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

(def disk-map (str/trimr (slurp (first *command-line-args*))))

(println (format "input '%s'" disk-map))

(defn disk-map->filesystem [disk-map]
  (->>
    (str disk-map \0)
    (partition 2)
    (map-indexed
     (fn [i [size free]]
       (list
         (repeat (Character/digit size 10) i)
         (repeat (Character/digit free 10) \.))))
    (apply concat)
    (apply concat)))

(defn disk-map->free-list [disk-map]
  (->>
    (str disk-map \0)
    (partition 2)
    (map-indexed
      (fn [i [size _]]
        {(Character/digit size 10) (list i)}))
    (apply merge-with concat)
    (#(update-vals % reverse))))

(defn disk-map->file-sizes [disk-map]
  (->>
    (str disk-map \0)
    (partition 2)
    (map-indexed
      (fn [i [size _]]
        {(str i) (Character/digit size 10)}))
    (apply merge)))

(defn checksum [filesystem]
  (loop [i 0
         j (- (count filesystem) 1)
         sum 0]
    (if (<= i j)
      (let [id1 (nth filesystem i)]
        (if (= id1 \.)
          (do
            (let [id2 (nth filesystem j)]
              (if (= id2 \.)
                (recur i (dec j) sum)
                (do
                  ; (println "i" i "id" id2 "sum" sum "increment" (* i id2))
                  (recur (inc i) (dec j) (+ sum (* i id2)))))))
          (do
            ; (println "i" i "id" id1 "sum" sum "increment" (* i id1))
            (recur (inc i) j (+ sum (* i id1))))))
      sum)))

(println (disk-map->free-list disk-map))

(defn checksum* [filesystem free-list file-sizes]
  (println "filesystem" filesystem)
  (loop [i 0
         j (- (count file-sizes) 1)
         sum 0
         free-list free-list
         handled #{}]
    ; (println "i" i "j" j "sum" sum "handled" handled)
    ; (println "i" i "sum" sum)
    (if (>= i (count filesystem))
      sum
      (let [id1 (nth filesystem i)]
        (if (not (= id1 \.))
          (do
            ; (println "id is not .")
            (if (contains? handled (str id1))
              (do
                (println "skipping" id1)
                (recur (inc i) j sum free-list handled))
              (do
                (println "i" i "id" id1 "sum" sum)
                (recur (inc i) j (+ sum (* i id1)) free-list handled))))
          (let [i1 (atom i)
                j1 (atom j)]
            (while (= (nth filesystem @i1) \.)
              (swap! i1 inc))
            ; (println "i" i "i1" @i1 "j1" @j1 "file-sizes" file-sizes "handled" handled)
            (while (and (pos? @j1)
                        (or (> (get file-sizes (str @j1)) (- @i1 i))
                            (contains? handled (str @j1))))
              (swap! j1 dec))
            ; (println "@j1" @j1 "(contains? handled @j1)" (contains? handled (str @j1)))
            (if (pos? @j1)
              (do
                (println "shifted" @j1 "to" i "-" (+ i (get file-sizes (str @j1))) "sum" sum)
                (recur (+ i (get file-sizes (str @j1))) j (apply + sum (map (partial * @j1) (if (= i (dec @i1)) (list i) (range i (dec @i1)))))
                       free-list
                       (conj handled (str @j1))))
              (do
                (println "Unable to fit anything from" i "to" @i1)
                (recur @i1 j sum free-list handled)))))))))

(println (checksum* (disk-map->filesystem disk-map)
                    (disk-map->free-list disk-map)
                    (disk-map->file-sizes disk-map)))
