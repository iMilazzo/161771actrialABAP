CLASS zcl_54_atc_unused_variables DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_54_atc_unused_variables IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    SELECT FROM /dmo/connection
    FIELDS *
    INTO TABLE @DATA(connections).
*    connection_list = connection_list.

    out->write(  connections  ).
  ENDMETHOD.
ENDCLASS.
