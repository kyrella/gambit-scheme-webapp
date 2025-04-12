(import (ffi))
(import (sxml))

(define clicked (make-parameter #f))
(define refresh #f)

(define (on-click _ev state)
  (console/log "Clicked!" (clicked))
  (clicked (not (clicked))))

(define (event-handler event-key handler . params)
  (list event-key
        (lambda (event)
          (apply handler `(event ,@params))
          (refresh))))

(define (content)
  `(div
    (h1 "Hello")
    (button (@ ,(event-handler onclick: on-click clicked))
            ,(if (clicked) "Clicked!" "Not clicked?"))
    ,(when (clicked) '(input (@ (placeholder: "Your name! Now!"))))))

(define (root-content content)
  (sxml `(div ,content)))

(define (main _ev)
  (let* ((root (document/get-element-by-id "app"))
         (update (dom/update root (root-content (content)))))
    (set! refresh (lambda () (update (root-content (content)))))))

(document/add-event-listener "DOMContentLoaded" main)
(thread-sleep! +inf.0)

