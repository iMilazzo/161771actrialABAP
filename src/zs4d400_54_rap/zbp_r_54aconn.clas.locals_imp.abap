CLASS lhc_zr_54aconn DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Connections
        RESULT result,

      airlineExists FOR VALIDATE ON SAVE
        IMPORTING keys FOR Connections~AirlineExists,

      checkAirports FOR VALIDATE ON SAVE
        IMPORTING keys FOR Connections~CheckAirports,

      checkSemanticKey FOR VALIDATE ON SAVE
        IMPORTING keys FOR Connections~CheckSemanticKey,

      getCities FOR DETERMINE ON MODIFY
        IMPORTING keys FOR Connections~GetCities.

ENDCLASS.

CLASS lhc_zr_54aconn IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD checkSemanticKey.
    DATA read_keys TYPE TABLE FOR READ IMPORT zr_54aconn.
    DATA connections TYPE TABLE FOR READ RESULT zr_54aconn.
    DATA reported_record LIKE LINE OF reported-connections.
    DATA failed_record LIKE LINE OF failed-connections.

    read_keys = CORRESPONDING #( keys ).
    READ ENTITIES OF zr_54aconn IN LOCAL MODE
         ENTITY Connections
         FIELDS ( uuid CarrierID ConnectionID )
         WITH CORRESPONDING #( keys )
         RESULT connections.

    LOOP AT connections INTO DATA(connection).

      SELECT FROM z54aconn
           FIELDS carrier_id, connection_id
            WHERE carrier_id = @connection-carrierid
              AND connection_id = @connection-connectionid
              AND uuid <> @connection-Uuid

        UNION

      SELECT FROM z54aconn_d
           FIELDS carrierid AS carrier_id, connectionid AS connection_id
            WHERE carrierid = @connection-carrierid
              AND connectionid = @connection-connectionid
              AND uuid <> @connection-Uuid

        INTO TABLE @DATA(check_result).

      IF check_result IS NOT INITIAL.
        DATA(message) = me->new_message(  id = 'Z54_RAP'
                                      number = '001'
                                    severity = ms-error
                                          v1 = connection-CarrierId
                                          v2 = connection-ConnectionId ).
        reported_record-%tky = connection-%tky.
        reported_record-%msg = message.
        reported_record-%element-carrierid = if_abap_behv=>mk-on.
        APPEND reported_record TO reported-connections.

        failed_record-%tky = connection-%tky.
        failed_record-Uuid = connection-Uuid.
        APPEND failed_record TO failed-connections.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD airlineExists.
    DATA reported_record LIKE LINE OF reported-connections.
    DATA failed_record LIKE LINE OF failed-connections.

    READ ENTITIES OF zr_54aconn IN LOCAL MODE
         ENTITY Connections
         FIELDS ( CarrierId )
           WITH CORRESPONDING #( keys )
         RESULT DATA(connections).

    LOOP AT connections INTO DATA(connection).

      SELECT SINGLE
               FROM /dmo/i_carrier
             FIELDS @abap_true
              WHERE AirlineID = @connection-CarrierId
               INTO @DATA(exists).

      IF exists <> abap_true.

        DATA(message) = me->new_message(   id = 'Z54_RAP'
                                       number = '002'
                                     severity = ms-error
                                           v1 = connection-carrierid ) .

        reported_record-%tky = connection-%tky.
        reported_record-%msg = message.
        reported_record-%element-carrierid = if_abap_behv=>mk-on.
        APPEND reported_record TO reported-connections.

        failed_record-%tky = connection-%tky.
        failed_record-Uuid = connection-Uuid.
        APPEND failed_record TO failed-connections.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD checkAirports.
    DATA reported_record LIKE LINE OF reported-connections.
    DATA failed_record LIKE LINE OF failed-connections.

    READ ENTITIES OF zr_54aconn IN LOCAL MODE
         ENTITY Connections
         FIELDS ( AirportFromID AirportToID )
           WITH CORRESPONDING #( keys )
         RESULT DATA(connections).

    LOOP AT connections INTO DATA(connection).
      IF connection-airportfromid = connection-airporttoid.
        DATA(message) = me->new_message( id = 'Z54_RAP'
                                     number = '003'
                                   severity = ms-error ).

        reported_record-%tky = connection-%tky.
        reported_record-%msg = message.
        reported_record-%element-carrierid = if_abap_behv=>mk-on.
        APPEND reported_record TO reported-connections.

        failed_record-%tky = connection-%tky.
        failed_record-Uuid = connection-Uuid.
        APPEND failed_record TO failed-connections.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD getCities.

    DATA connection_upd TYPE TABLE FOR UPDATE zr_54aconn.

    READ ENTITIES OF zr_54aconn IN LOCAL MODE
         ENTITY Connections
         FIELDS ( AirportFromID AirportToID )
         WITH CORRESPONDING #( keys )
         RESULT DATA(connections).

    LOOP AT connections INTO DATA(connection).

      SELECT SINGLE
        FROM /dmo/i_airport
        FIELDS city, Name
        WHERE airportid = @connection-airportfromid
        INTO ( @connection-cityfrom, @connection-countryfrom ).

      SELECT SINGLE
        FROM /dmo/i_airport
        FIELDS city, Name
        WHERE airportid = @connection-airporttoid
        INTO ( @connection-cityto, @connection-countryto ).

      MODIFY connections FROM connection.

    ENDLOOP.

    connection_upd = CORRESPONDING #( connections ).

    MODIFY ENTITIES OF zr_54aconn IN LOCAL MODE
           ENTITY Connections
           UPDATE
           FIELDS ( CityFrom CountryFrom CityTo CountryTo )
           WITH connection_upd
           REPORTED DATA(reported_records)
           MAPPED DATA(mapped_records)
           FAILED DATA(failed_records).

    reported-connections = CORRESPONDING #( reported_records-connections ).

  ENDMETHOD.

ENDCLASS.
