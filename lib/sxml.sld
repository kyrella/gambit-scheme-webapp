(define-library (sxml)
  (import (gambit)
          (only srfi/1 every)
          (only ffi h))
  (export sxml)

  (begin
    (define (non-empty-list? exp)
      (and (list? exp) (not (null? exp))))

    (define (not-element-error exp)
      (error "'exp' is not a proper element" exp))

    (define (get-tag exp)
      (if (non-empty-list? exp)
          (car exp)
          (not-element-error exp)))

    (define (get-attr exp)
      (if (non-empty-list? exp)
          (if (and (non-empty-list? (cadr exp)) (eqv? '@ (caadr exp)))
              (let ((attr-list (cdadr exp)))
                (if (and (non-empty-list? attr-list) (every non-empty-list? attr-list))
                    attr-list
                    (not-element-error exp)))
              '())
          (not-element-error exp)))

    (define (get-children exp)
      (if (non-empty-list? exp)
          (let* ((exp-len (length exp))
                 (has-attr (not (null? (get-attr exp))))
                 (children
                  (filter
                   (lambda (c) (not (eqv? c (void))))
                   (if has-attr (cddr exp) (cdr exp)))))
            (if (and (eqv? 1 (length children)) (string? (car children)))
                (car children)
                children))
          (not-element-error exp)))

    (define (sxml exp)
      (let ((tag (get-tag exp))
            (attr (get-attr exp))
            (children (get-children exp)))
        (h tag attr (if (list? children) (map sxml children) children))))))

