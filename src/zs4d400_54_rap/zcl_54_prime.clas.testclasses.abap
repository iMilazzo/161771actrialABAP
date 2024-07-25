*"* use this source file for your ABAP unit test classes
CLASS ltcl_ DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA lo_prime TYPE REF TO lcl_prime_number.

    METHODS testPrimeRecOK FOR TESTING RAISING cx_static_check.
    METHODS testPrimeRecFail FOR TESTING RAISING cx_static_check.
    METHODS testPrimeLoopOK FOR TESTING RAISING cx_static_check.
    METHODS testPrimeLoopFail FOR TESTING RAISING cx_static_check.
    METHODS testPrimeReduceOK FOR TESTING RAISING cx_static_check.
    METHODS testPrimeReduceFail FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_ IMPLEMENTATION.

  METHOD testPrimeRecOK.
    lo_prime = NEW #( ).
    cl_abap_unit_assert=>assert_true( act = lo_prime->is_prime_recursive( 37 ) msg = 'Number is not prime' quit = if_abap_unit_constant=>quit-test ).
  ENDMETHOD.

  METHOD testPrimeLoopFail.
    lo_prime = NEW #( ).
    cl_abap_unit_assert=>assert_false( act = lo_prime->is_prime_loop( 20 ) msg = 'Number is not prime' quit = if_abap_unit_constant=>quit-test ).
  ENDMETHOD.
*
  METHOD testPrimeLoopOK.
    lo_prime = NEW #( ).
    cl_abap_unit_assert=>assert_true( act = lo_prime->is_prime_loop( 37 ) msg = 'Number is not prime' quit = if_abap_unit_constant=>quit-test ).
  ENDMETHOD.

  METHOD testPrimeRecFail.
    lo_prime = NEW #( ).
    cl_abap_unit_assert=>assert_false( act = lo_prime->is_prime_recursive( 20 ) msg = 'Number is not prime' quit = if_abap_unit_constant=>quit-test ).

  ENDMETHOD.

  METHOD testprimereducefail.
    lo_prime = NEW #( ).
    cl_abap_unit_assert=>assert_false( act = lo_prime->is_prime_reduce( 20 ) msg = 'Number is not prime' quit = if_abap_unit_constant=>quit-test ).
  ENDMETHOD.

  METHOD testprimereduceok.
    lo_prime = NEW #( ).
    cl_abap_unit_assert=>assert_true( act = lo_prime->is_prime_reduce( 37 ) msg = 'Number is not prime' quit = if_abap_unit_constant=>quit-test ).
  ENDMETHOD.

ENDCLASS.
