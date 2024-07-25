*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_data DEFINITION FINAL.

  PUBLIC SECTION.
    TYPES ty_result TYPE STANDARD TABLE OF /dmo/flight WITH DEFAULT KEY.

*  Data r_result TYPE ty_result.
    CLASS-METHODS get_flights
      RETURNING VALUE(r_result) TYPE ty_result.

ENDCLASS.


CLASS lcl_data IMPLEMENTATION.
  METHOD get_flights.
    SELECT * FROM /dmo/flight INTO TABLE @r_result.
  ENDMETHOD.
ENDCLASS.
