 ;Map Function
(= (map $func $list)
    (case $list
        (
            (Nil Nil)
            ( (Cons $x $xs) (Cons ($func $x) (map $func $xs)))
        )
)
)

 ; Example: Double each element in the list
(= (double $x) (* $x 2))
! (map double (Cons 1 (Cons 2 (Cons 3 Nil)))) ; [2, 4, 6]

 ;Reverse Function
(= (reverse $list)
    (reverse-helper $list Nil)) ; Use an accumulator

(= (reverse-helper $list $acc)
    (case $list
        (
            (Nil $acc) ; Base case: return accumulator
            ( (Cons $x $xs) (reverse-helper $xs (Cons $x $acc))) ; Add to acc and recurse
        )
)
)
! (reverse (Cons 1 (Cons 2 (Cons 3 Nil)))) ; [3, 2, 1]

 ; Length Function

(= (length $list)
    (length-helper $list 0)) ; Start with count 0

(= (length-helper $list $acc)
    (case $list
        (
            (Nil $acc) ; Base case: return accumulated count
            ( (Cons $x $xs) (length-helper $xs (+ $acc 1))) ; Increment count and recurse
        )
)
)

! (length (Cons 1 (Cons 2 (Cons 3 Nil)))) ; 3

 ; Append Function

(= (append $list1 $list2)
    (case $list1
        (
            (Nil $list2) ; If list1 is empty, return list2
            ( (Cons $x $xs) (Cons $x (append $xs $list2))) ; Prepend to list 2
        )
)
)

! (append (Cons 1 (Cons 2 Nil)) (Cons 3 (Cons 4 Nil))) ; [1, 2, 3, 4]

 ; Max Function: Finds the maximum value in a list of numbers.
(= (max $list)
    (case $list
        (
            (Nil Nil) ; If the list is empty, return Nil.
            ( (Cons $x $xs) (max-helper $xs $x)) ; Use helper with initial max
        )
)
)

 ; Helper function for max: Compares each element to the current maximum.
(= (max-helper $list $current-max)
    (case $list
        (
            (Nil $current-max) ; Base case: return the current maximum
            ( (Cons $x $xs)
                (if (> $x $current-max)
                    (max-helper $xs $x) ; Update current max if necessary
                    (max-helper $xs $current-max) ; Otherwise keep the same
                )
        )
)
)
)

 ; Example: Find the maximum value
! (max (Cons 1 (Cons 9 (Cons 5 (Cons 2 Nil))))) ; 9