CLASS zcl_54_type_conversion_4 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_54_type_conversion_4 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(result1) = 5 * 10.
    out->write( |5 * 10 = { result1 }| ).

    DATA(result2) = 5 / 10.
    out->write( |5 / 10: { result2 }| ).

    DATA(result3) = '5.0' / '10.000'.
    out->write( |5 / 10 = { result3 }| ).

  ENDMETHOD.
ENDCLASS.
