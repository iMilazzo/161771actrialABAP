*"* use this source file for your ABAP unit test classes
CLASS ltcl_UnitTest1 DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      test_success FOR TESTING RAISING cx_static_check.
    METHODS test_exception FOR TESTING.
ENDCLASS.


CLASS ltcl_UnitTest1 IMPLEMENTATION.

  METHOD test_success.

* Preparation: Read an arbitrary carrier_id from DB
**********************************************************************
    SELECT SINGLE
      FROM /dmo/carrier
      FIELDS carrier_id
      INTO @DATA(carrier_id).

    IF sy-subrc <> 0.
      "No data in table /DMO/CARRIER, stop testing
      cl_abap_unit_assert=>fail( `Test requires at least on entry on DB table /DMO/CARRIER` ).
    ENDIF.

* Do the test of method lcl_data=>get_carrier( )
**********************************************************************
    TRY.
        DATA(carrier) = lcl_data=>get_carrier( carrier_id ).
      CATCH cx_abap_invalid_value.
        cl_abap_unit_assert=>fail( msg = `Inapropriate exception`
                                detail = `Method lcl_data=>get_carrier( ) raises and exception when it should not` ).
    ENDTRY.
  ENDMETHOD.

  METHOD test_exception.

* Specify a carrier_id that (hopefully) does not exist in the DB
**********************************************************************
    CONSTANTS c_wrong_carrier_id TYPE /DMO/Carrier_id VALUE 'XX'.

* Preparation: Make sure the carrier does not exist on DB
**********************************************************************
    SELECT SINGLE
      FROM /dmo/carrier
      FIELDS carrier_id
      WHERE carrier_id = 'XX'
      INTO @DATA(carrier_id).

    IF sy-subrc = 0.
      " Carrier exists in DB table /DMO/CARRIER, stop testing
      cl_abap_unit_assert=>fail(  msg = |Carrier { c_wrong_carrier_id } exists in /DMO/CARRIER|
                                level = if_abap_unit_constant=>severity-high
                                 quit = if_abap_unit_constant=>quit-test
                               detail = `If DB table /DMO/CARRIER contains an entry` && |with carrier_id = `{ c_wrong_carrier_id }`| &&
                                        `it is not possible to test the exception` ).

    ENDIF.

* Do the test of method lvl_data=>get_carrier( )
**********************************************************************
    TRY.

        DATA(carrier) = lcl_data=>get_carrier( carrier_id ).
        cl_abap_unit_assert=>fail(  msg = `No exception`
                                 detail = `Method lcl_data=>get_carrier( ) does not raise an exception when it should do so` ).

      CATCH cx_abap_invalid_value.
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
