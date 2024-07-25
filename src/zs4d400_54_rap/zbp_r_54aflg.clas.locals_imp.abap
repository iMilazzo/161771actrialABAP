CLASS lhc_zr_54aflg DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Flights
        RESULT result,
      validatePrice FOR VALIDATE ON SAVE
        IMPORTING keys FOR Flights~validatePrice,
      validateCurrency FOR VALIDATE ON SAVE
        IMPORTING keys FOR Flights~validateCurrency.
ENDCLASS.

CLASS lhc_zr_54aflg IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validatePrice.

    DATA read_keys TYPE TABLE FOR READ IMPORT zr_54aflg.
    DATA flights TYPE TABLE FOR READ RESULT zr_54aflg.
    DATA reported_record LIKE LINE OF reported-flights.
    DATA failed_record LIKE LINE OF failed-flights.

    read_keys = CORRESPONDING #( keys ).

    READ ENTITIES OF zr_54aflg IN LOCAL MODE
         ENTITY Flights
         FIELDS ( Price )
         WITH CORRESPONDING #( keys )
         RESULT flights.

    LOOP AT flights INTO DATA(flight).

      IF flight-Price <= 0.

        DATA(message) = me->new_message(  id = 'Z54_RAP'
                                      number = '004'
                                    severity = ms-error ).

        reported_record-%tky = flight-%tky.
        reported_record-%msg = message.
        reported_record-%element-price = if_abap_behv=>mk-on.
        APPEND reported_record TO reported-flights.

        failed_record-%tky = flight-%tky.
        APPEND failed_record TO failed-flights.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateCurrency.

    DATA reported_record LIKE LINE OF reported-flights.
    DATA failed_record LIKE LINE OF failed-flights.

    READ ENTITIES OF zr_54aflg IN LOCAL MODE
         ENTITY flights
         FIELDS ( CurrencyCode )
           WITH CORRESPONDING #( keys )
         RESULT DATA(flights).

    LOOP AT flights INTO DATA(flight).

      SELECT SINGLE
               FROM I_Currency
             FIELDS @abap_true
              WHERE Currency = @flight-CurrencyCode
               INTO @DATA(exists).

      IF exists <> abap_true.

        DATA(message) = me->new_message(  id = 'Z54_RAP'
                                      number = '005'
                                    severity = ms-error
                                          v1 = flight-CurrencyCode ) .

        reported_record-%tky = flight-%tky.
        reported_record-%msg = message.
        reported_record-%element-currencycode = if_abap_behv=>mk-on.
        APPEND reported_record TO reported-flights.

        failed_record-%tky = flight-%tky.
        APPEND failed_record TO failed-flights.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
