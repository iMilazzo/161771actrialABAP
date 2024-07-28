CLASS zcl_54_prime DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_54_prime IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(text) = 'TESTEABAP'.
    DATA(prime) = NEW lcl_prime_number(  ).
    DATA result TYPE string.

    DO strlen( text ) TIMES.
      DATA(pos) = sy-index - 1.
      IF NOT prime->is_prime_loop( sy-index ).
        result = |{ result }{ text+pos(1) }|.
      ENDIF.
    ENDDO.
    out->write( result ).

    clear result.
    DO strlen( text ) TIMES.
      pos = sy-index - 1.
      prime->prepare_prime(  ).
      IF NOT prime->is_prime_recursive( sy-index ).
        result = |{ result }{ text+pos(1) }|.
      ENDIF.
    ENDDO.
    out->write( result ).

    clear result.
    DO strlen( text ) TIMES.
      pos = sy-index - 1.
      IF NOT prime->is_prime_reduce( sy-index ).
        result = |{ result }{ text+pos(1) }|.
      ENDIF.
    ENDDO.
    out->write( result ).

  ENDMETHOD.

ENDCLASS.
