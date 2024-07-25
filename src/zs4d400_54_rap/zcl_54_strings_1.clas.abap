CLASS zcl_54_strings_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_54_strings_1 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA result TYPE i.

    DATA text    TYPE string VALUE `  ABAP  `.
    DATA substring TYPE string VALUE `AB`.
    DATA offset    TYPE i      VALUE 1.

* Call different description functions
******************************************************************************
    result = strlen(     text ).
    out->write( |strlen( text )      = `{ result }`| ).

    result = numofchar(  text ).
    out->write( |numofchar( text )   = `{ result }`| ).

    result = count(             val = text sub = substring off = offset ).
    out->write( |count(             val = text sub = substring off = offset ) = `{ result }`| ).

    result = find(             val = text sub = substring off = offset ).
    out->write( |find(              val = text sub = substring off = offset ) = `{ result }`| ).

    result = count_any_of(     val = text sub = substring off = offset ).
    out->write( |count_any_of(      val = text sub = substring off = offset ) = `{ result }`| ).

    result = find_any_of(      val = text sub = substring off = offset ).
    out->write( |find_any_of(       val = text sub = substring off = offset ) = `{ result }`| ).

    result = count_any_not_of( val = text sub = substring off = offset ).
    out->write( |count_any_not_of(  val = text sub = substring off = offset ) = `{ result }`| ).

    result = find_any_not_of(  val = text sub = substring off = offset ).
    out->write( |find_any_not_of(   val = text sub = substring off = offset ) = `{ result }`| ).

    out->write( |Text      = `{ text }`| ).
    out->write( |Substring = `{ substring }` | ).
    out->write( |Offset    = { offset } | ).
    out->write( |Result    = { result } | ).

  ENDMETHOD.
ENDCLASS.
