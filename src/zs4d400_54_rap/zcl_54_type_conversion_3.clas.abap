CLASS zcl_54_type_conversion_3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_54_type_conversion_3 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    DATA var_date TYPE d.
    DATA var_int TYPE i.
    DATA var_string TYPE string.
    DATA var_n TYPE n LENGTH 4.

    var_date = cl_abap_context_info=>get_system_date(  ).
    var_int = var_date.

    var_string = `R2D2`.
    var_n = var_string.

    var_date = `ABCDEFGH`.

    out->write( |var_date: { var_date }| ).
    out->write( |var_int: { var_int }| ).
    out->write( |var_string: { var_string }| ).
    out->write( |var_n: { var_n }| ).
    out->write( |var_date: { var_date }| ).


  ENDMETHOD.
ENDCLASS.
