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
      "      IF NOT prime->is_prime_loop( sy-index ).
      IF NOT prime->is_prime_reduce( sy-index ).
        result = |{ result }{ text+pos(1) }|.
      ENDIF.
    ENDDO.

*    out->write( |20 é primo: { prime->is_prime_recursive( 177 ) }| ).
*    out->write( |37 é primo: { prime->is_prime_recursive( 2 ) }| ).
*    out->write( |7 é primo: { prime->is_prime_loop( 35 ) }| ).
*    out->write( |4 é primo: { prime->is_prime_loop( 37 ) }| ).
    out->write( result ).

  ENDMETHOD.

ENDCLASS.
