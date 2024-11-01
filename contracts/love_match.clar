;; Simple Dating App Smart Contract
;; This contract allows users to register, update, and retrieve their dating profiles.

(define-map profiles
    principal
    {
        name: (string-ascii 100),
        age: uint,
        interests: (list 10 (string-ascii 50)),
        location: (string-ascii 100)
    }
)

;; Custom error constants
(define-constant ERR-NOT-FOUND (err u404))
(define-constant ERR-ALREADY-EXISTS (err u409))
(define-constant ERR-INVALID-AGE (err u400))
(define-constant ERR-INVALID-NAME (err u401))
(define-constant ERR-INVALID-LOCATION (err u402))
(define-constant ERR-INVALID-INTERESTS (err u403))

;; Public function to register a new profile
(define-public (register-profile 
    (name (string-ascii 100))
    (age uint)
    (interests (list 10 (string-ascii 50)))
    (location (string-ascii 100)))
    (let
        (
            (caller tx-sender)
            (existing-profile (map-get? profiles caller))
        )
        ;; Ensure the profile does not already exist
        (if (is-none existing-profile)
            (begin
                ;; Validate input data
                (if (or (is-eq name "")
                        (< age u18)
                        (> age u120)
                        (is-eq location "")
                        (is-eq (len interests) u0)) ;; Corrected line here
                    (err ERR-INVALID-AGE) ;; Handle invalid input
                    (begin
                        ;; Store the new profile in the profiles map
                        (map-set profiles caller
                            {
                                name: name,
                                age: age,
                                interests: interests,
                                location: location
                            }
                        )
                        (ok "Profile registered successfully.") ;; Return success message
                    )
                )
            )
            (err ERR-ALREADY-EXISTS)
        )
    )
)

;; Public function to update an existing profile
(define-public (update-profile
    (name (string-ascii 100))
    (age uint)
    (interests (list 10 (string-ascii 50)))
    (location (string-ascii 100)))
    (let
        (
            (caller tx-sender)
            (existing-profile (map-get? profiles caller))
        )
        ;; Ensure the profile exists before updating
        (if (is-some existing-profile)
            (begin
                ;; Validate input data
                (if (or (is-eq name "")
                        (< age u18)
                        (> age u120)
                        (is-eq location "")
                        (is-eq (len interests) u0)) ;; Corrected line here
                    (err ERR-INVALID-AGE) ;; Handle invalid input
                    (begin
                        ;; Update the existing profile in the profiles map
                        (map-set profiles caller
                            {
                                name: name,
                                age: age,
                                interests: interests,
                                location: location
                            }
                        )
                        (ok "Profile updated successfully.") ;; Return success message
                    )
                )
            )
            (err ERR-NOT-FOUND)
        )
    )
)

;; Read-only function to get a profile
(define-read-only (get-profile (user principal))
    (match (map-get? profiles user)
        profile (ok profile)
        ERR-NOT-FOUND
    )
)

;; Read-only function to get user interests
(define-read-only (get-user-interests (user principal))
    (match (map-get? profiles user)
        profile (ok (get interests profile))
        ERR-NOT-FOUND
    )
)
