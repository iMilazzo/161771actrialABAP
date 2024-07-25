CLASS zcl_54_unit_test_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_54_unit_test_2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'LH'.

    TRY.

        DATA(carrier) = NEW lcl_carrier( c_carrier_id ).
        out->write( |Carrier {  carrier->get_name( ) } has currenccy { carrier->get_currency( ) }| ).

      CATCH cx_abap_invalid_value.

        out->write( | Carrier { c_carrier_id } does not exist | ).

    ENDTRY.

  ENDMETHOD.

ENDCLASS.
