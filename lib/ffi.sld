(define-library (ffi)
  (import (gambit))
  (export h
          console/log
          document/get-element-by-id
          document/add-event-listener
          dom/update)

  (begin
    (declare
      (standard-bindings)
      (extended-bindings))
      
    (define (h tag properties children)
      (##inline-host-expression
       "@host2scm@(h(@scm2host@(@1@), @scm2host@(@2@), @scm2host@(@3@)))"
       tag properties children))

    (define (console/log . stuff)
      (##inline-host-statement "@host2scm@(console.log(...@scm2host@(@1@)))" stuff))

    (define (document/get-element-by-id id)
      (##inline-host-expression "@host2scm@(document.getElementById(@1@))" id))

    (define (document/add-event-listener event handler)
      (##inline-host-statement
       "@host2scm@(document.addEventListener(@scm2host@(@1@), @scm2host@(@2@)))"
       event handler))

    (define (dom/update element node)
      (##inline-host-expression
       "@host2scm@(maquette.dom.merge(@scm2host@(@1@), @scm2host@(@2@)).update)"
       element node))))
