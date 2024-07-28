*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_prime_number DEFINITION.
  PUBLIC SECTION.
    DATA start TYPE i VALUE 2.
    METHODS prepare_prime.
    METHODS is_prime_recursive IMPORTING number      TYPE i
                               RETURNING VALUE(bool) TYPE abap_bool.
    METHODS is_prime_loop IMPORTING iv_number   TYPE i
                          RETURNING VALUE(bool) TYPE abap_bool.
    METHODS is_prime_reduce IMPORTING iv_number   TYPE i
                            RETURNING VALUE(bool) TYPE abap_bool.
ENDCLASS.

CLASS lcl_prime_number IMPLEMENTATION.
  METHOD prepare_prime.
    start = 2.
  ENDMETHOD.

  METHOD is_prime_recursive.

    "corner cases
    IF number = 1 .
      RETURN abap_false.
    ENDIF.

    IF number = 2 .
      RETURN abap_true.
    ENDIF.

    "Checking Prime
    IF number = start.
      RETURN abap_true.
    ENDIF.

    "base cases
    IF number MOD start = 0.
      RETURN abap_false.
    ENDIF.

    start += 1.

    IF start > number.
      EXIT.
    ENDIF.

    RETURN is_prime_recursive( number ).

  ENDMETHOD.

  METHOD is_prime_loop.
    " Corner case
    IF ( iv_number <= 1 ).
      bool = abap_false.
      RETURN.
    ENDIF.
    IF ( iv_number = 2 ).
      RETURN abap_true.
    ENDIF.

    DATA(x) = 2.
    DATA(y) = iv_number.

    WHILE x < y.
      IF ( y MOD x ) = 0.
        RETURN abap_false.
      ENDIF.
      x += 1.
    ENDWHILE..

    bool = abap_true.

  ENDMETHOD.

  METHOD is_prime_reduce.
    "Corner case
    IF ( iv_number <= 1 ).
      RETURN abap_false.
    ENDIF.

    IF ( iv_number = 2 ).
      RETURN abap_true.
    ENDIF.

    "Check from 2 to n-1
    DATA(x) = iv_number - 1.
    bool = REDUCE abap_bool(
             INIT b = abap_true
              FOR n = 2 THEN n + 1 WHILE n < x
             NEXT b = COND abap_bool( WHEN ( iv_number MOD n ) = 0 THEN abap_false ELSE b  )  ).

  ENDMETHOD.

ENDCLASS.
