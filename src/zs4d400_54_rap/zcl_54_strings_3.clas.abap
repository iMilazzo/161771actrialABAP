CLASS zcl_54_strings_3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_54_strings_3 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    DATA text TYPE string VALUE 'Date 1989-11-09 is in ISO-Format'.
    DATA regex TYPE string VALUE '[0-9]{4}(-[0-9]{2}){2}'.


    IF contains( val = text pcre = regex ).

      DATA(number) = count( val = text pcre = regex ).
      out->write( |count( val = text pcre = regex         ) = { number } | ).

      DATA(offset) = find( val = text pcre = regex occ = 1 ).
      out->write( |find(  val = text pcre = regex occ = 1 ) = { offset } | ).

      DATA(date_text) = match( val = text pcre = regex occ = 1 ).
      out->write( |match( val = text pcre = regex occ = 1 ) = { date_text } | ).

      IF matches( val = text pcre = regex ).
        out->write( |matches( val = text pcre = regex occ = 1 ) has passed| ).
      ENDIF.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
