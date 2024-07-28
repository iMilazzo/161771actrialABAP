*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_connection DEFINITION CREATE PRIVATE.
  PUBLIC SECTION.
    TYPES: BEGIN OF ts_connection,
             AirlineId        TYPE /dmo/carrier_id,
             ConnectionNumber TYPE /dmo/connection_id,
             fromAirport      TYPE /dmo/airport_from_id,
             toAirport        TYPE /dmo/airport_to_id,
           END OF ts_connection.

    METHODS constructor
      IMPORTING
        airlineid        TYPE /dmo/carrier_id
        connectionnumber TYPE /dmo/connection_id
        fromAirport      TYPE /dmo/airport_from_id
        toAirport        TYPE /dmo/airport_to_id.


    CLASS-METHODS get_connection IMPORTING airlineId            TYPE /dmo/carrier_id
                                           connectionNumber     TYPE /dmo/connection_id
                                 RETURNING VALUE(ro_connection) TYPE REF TO lcl_Connection.
    METHODS get_attributes RETURNING VALUE(rs_connection) TYPE ts_connection.

  PRIVATE SECTION.
    DATA AirlineId TYPE /dmo/carrier_id.
    DATA ConnectionNumber TYPE /dmo/connection_id.
    DATA fromAirport TYPE /dmo/airport_from_id.
    DATA toAirport TYPE /dmo/airport_to_id.
ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD constructor.


    me->airlineid = airlineid.
    me->connectionnumber = connectionnumber.
    me->fromAirport = fromAirport.
    me->toAirport = toAirport.


  ENDMETHOD.


  METHOD get_connection.
    DATA fromAirport TYPE /dmo/airport_from_id.
    DATA toAirport TYPE /dmo/airport_to_id.


    SELECT SINGLE
      FROM /dmo/connection FIELDS airport_from_id, airport_to_id
     WHERE carrier_id = @airlineid
       AND connection_id = @connectionnumber
      INTO ( @fromAirport, @toAirport ).


    ro_connection = NEW #( airlineid = airlineid connectionnumber = connectionnumber fromairport = fromairport toairport = toairport ).


  ENDMETHOD.


  METHOD get_attributes.
    rs_connection-airlineid = me->airlineid.
    rs_connection-connectionnumber = me->connectionnumber.
    rs_connection-fromairport = me->fromairport.
    rs_connection-toairport = me->toairport.
  ENDMETHOD.

ENDCLASS.
