*"* use this source file for your ABAP unit test classes
CLASS ltcl_UnitTest2 DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      setup,
      test_GetName FOR TESTING RAISING cx_static_check,
      test_GetCurrency FOR TESTING RAISING cx_static_check.

    DATA carrier TYPE REF TO lcl_carrier.

ENDCLASS.


CLASS ltcl_UnitTest2 IMPLEMENTATION.

  METHOD test_GetName.

*    cl_abap_unit_assert=>fail( msg = `Implement your first test here` ).

    DATA(name) = me->carrier->get_name(  ).

    cl_abap_unit_assert=>assert_not_initial( act = name
                                             msg = `Result of method get_name( )`
                                            quit = if_abap_unit_constant=>quit-no ).

  ENDMETHOD.

  METHOD setup.
    " read arbitrary carrier_id from DB table
    SELECT SINGLE
      FROM /dmo/carrier
      FIELDS carrier_id
      INTO @DATA(carrier_id).
    IF sy-subrc <> 0.
      cl_abap_unit_assert=>skip( msg = `No data in /DMO/CARRIER` ) .
    ENDIF.

    " then create the instance to be tested
    TRY.
        me->carrier = NEW lcl_carrier( carrier_id ).
      CATCH cx_abap_invalid_value.
        cl_abap_unit_assert=>fail( msg = `Cannot create instance of lcl_carrier`
                                detail = `Constructor of lcl_carrier raises an exception when it should not` ).
    ENDTRY.
  ENDMETHOD.

  METHOD test_GetCurrency.

    cl_abap_unit_assert=>assert_not_initial(  act = me->carrier->get_currency( )
                                              msg = `Result of method get_currency( )`
                                             quit = if_abap_unit_constant=>quit-no ).

  ENDMETHOD.

ENDCLASS.
