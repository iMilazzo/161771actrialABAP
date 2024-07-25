CLASS zcl_54_profiling_3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_54_profiling_3 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TYPES:
      BEGIN OF st_airport,
        airport_id TYPE /dmo/airport-airport_id,
        city       TYPE /dmo/airport-city,
      END OF st_airport,
      tt_airports TYPE SORTED TABLE OF st_airport WITH UNIQUE KEY airport_id.

    DATA airports TYPE tt_airports.
    DATA(connections) = lcl_data=>get_connections( ).
    SORT connections BY carrier_id
                        connection_id ASCENDING.

    SELECT FROM /dmo/connection AS c
                  LEFT JOIN /dmo/airport AS a ON a~airport_id = c~airport_from_id
      FIELDS a~airport_id, a~city

      UNION

    SELECT FROM /dmo/connection AS c
           LEFT JOIN /dmo/airport AS a ON a~airport_id = c~airport_to_id
      FIELDS a~airport_id, a~city

      INTO TABLE @airports.

    IF sy-subrc = 0.

      LOOP AT connections INTO DATA(connection).

        DATA(city_from) = VALUE #( airports[ airport_id =  connection-airport_from_id ]-city OPTIONAL ).
        DATA(city_to) = VALUE #( airports[ airport_id =  connection-airport_to_id ]-city OPTIONAL ).

        DATA(text) = |Flight { connection-carrier_id } { connection-connection_id } | &&
        | from { city_from } to { city_to } |.

        out->write( '--------------------------------------------------------------------' ).
        out->write( text ).

      ENDLOOP.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
