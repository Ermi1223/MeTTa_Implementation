 ; Define Graph Node and Edge Structures
(: Edge (-> Number Number)) ; Represents an edge between two nodes
(: Node (-> Number List)) ; Represents a node with a list of edges
(: Graph Type)
(: NilGraph Graph) ; Represents an empty graph
(: ConsGraph (-> Node Graph)) ; ConsGraph takes a Node and a Graph

 ; Example graph definition
(define (example-graph) Graph
    (ConsGraph
        (Node 1 (Cons (Edge 1 2) (Cons (Edge 1 3) Nil)))
        (ConsGraph
            (Node 2 (Cons (Edge 2 3) Nil))
            (ConsGraph (Node 3 Nil) NilGraph)
        )
)
)

 ; Function to transform edges
(= (transform-edges $edges) List
    (case $edges
        (Nil Nil)
        ( (Cons (Edge $from $to) $rest)
            (if (= $from 1)
                (Cons (Edge 10 $to) (transform-edges $rest)) ; Change edge from 1 to 10
                (Cons (Edge $from $to) (transform-edges $rest)))
        )
)
)

 ; Function to rewrite the graph
(= (rewrite-rule $graph) Graph
    (case $graph
        (NilGraph NilGraph)
        ( (ConsGraph $node $rest)
            (let
                (
                    $new-edges (transform-edges (get-node-edges $node)) ; Extract edges explicitly
                    $new-node (Node (get-node-number $node) $new-edges) ; Reconstruct Node
                )
            (ConsGraph $new-node (rewrite-rule $rest))) ; Recursively rewrite the rest of the graph
    )
)
)

 ; Helper function to access node properties
(= (get-node-number $node) Number
    (case $node
        ( (Node $n $_) $n)))

(= (get-node-edges $node) List
    (case $node
        ( (Node $_ $edges) $edges)))

 ; Helper function to print the graph
(= (print-graph $graph) None
    (case $graph
        (NilGraph (println "NilGraph")) ; Print message for empty graph
        ( (ConsGraph $node $rest)
            (do
                (print-node $node) ; Print current node
                (print-graph $rest) ; Recursively print the rest of the graph
            )
    )
)
)

 ; Helper function to print a node
(= (print-node $node) None
    (case $node
        ( (Node $n $edges)
            (println (concat "Node: " (to-string $n) ", Edges: " (edges-to-string $edges))) ; Print node details
        )
)
)

 ; Helper function to convert edges to string
(= (edges-to-string $edges) String
    (case $edges
        (Nil "[]") ; Return empty list representation
        ( (Cons (Edge $from $to) $rest)
            (concat "[" (to-string $from) " → " (to-string $to) "] " (edges-to-string $rest))
        )
)
)

 ; Execute the rewrite and print the result
! (println "Transformed Graph:")
! (print-graph (rewrite-rule (example-graph)))