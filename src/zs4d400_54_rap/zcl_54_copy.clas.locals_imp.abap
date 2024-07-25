*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_copy_data DEFINITION.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        i_target_table TYPE tabname
      RAISING
        cx_abap_not_a_table
      .

    METHODS
      copy_data.


  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA flights    TYPE STANDARD TABLE OF zejrflight WITH NON-UNIQUE DEFAULT KEY.
    DATA connections    TYPE STANDARD TABLE OF z54aconn WITH NON-UNIQUE DEFAULT KEY.

    DATA table_name TYPE tabname.

    DATA user       TYPE abp_creation_user VALUE 'GENERATOR'.
    DATA timestamp  TYPE abp_creation_tstmpl.

    METHODS prepare_data.

    METHODS is_empty_db
      RETURNING VALUE(result) TYPE abap_bool.

    METHODS delete_db.

    METHODS insert_db.

    METHODS matches_template
      RETURNING VALUE(result) TYPE abap_bool.

    CONSTANTS template_table TYPE tabname VALUE 'z54aconn'.
    CONSTANTS source_table   TYPE tabname VALUE '/dmo/connection'.

ENDCLASS.

CLASS lcl_copy_data IMPLEMENTATION.

  METHOD constructor.

* Store table name
    me->table_name = i_target_table.

    IF me->matches_template( ) <> abap_true.
      RAISE EXCEPTION TYPE cx_abap_not_a_table.
    ENDIF.

  ENDMETHOD.

  METHOD copy_data.

    prepare_data( ).

* Check if DB is empty

*    IF me->is_empty_db( ) = abap_false.
      me->delete_db( ).
*    ENDIF.

    me->insert_db( ).

  ENDMETHOD.

  METHOD is_empty_db.
    CLEAR result.

    SELECT SINGLE
      FROM (table_name)
    FIELDS @abap_true
     INTO @result.

  ENDMETHOD.

  METHOD delete_db.
    DELETE FROM (table_name).
  ENDMETHOD.

  METHOD insert_db.

    INSERT (table_name) FROM TABLE @connections.

  ENDMETHOD.

  METHOD prepare_data.


    SELECT c~carrier_id, c~connection_id,
           f~airport_id AS airport_from_id, f~city AS city_from, f~country AS country_from,
           t~airport_id AS airport_to_id, t~city AS city_to, f~country AS country_to
      FROM /dmo/connection AS c
      JOIN /dmo/airport AS f ON f~airport_id = c~airport_from_id
      JOIN /dmo/airport AS t ON t~airport_id = c~airport_to_id
      INTO CORRESPONDING FIELDS OF TABLE @connections.

    TRY.
* Fill with data from source
        GET TIME STAMP FIELD me->timestamp. "Get timestamp
        DATA(system_uuid) = cl_uuid_factory=>create_system_uuid( ).

        LOOP AT me->connections ASSIGNING FIELD-SYMBOL(<connection>).

          <connection>-uuid = system_uuid->create_uuid_x16( ).
          <connection>-local_created_by  = user.
          <connection>-local_created_at = timestamp.
          <connection>-local_last_changed_by = user.
          <connection>-local_last_changed_at = timestamp.
          <connection>-last_changed_at = timestamp.

        ENDLOOP.
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
  ENDMETHOD.

  METHOD matches_template.

    result = abap_true.

    cl_abap_typedescr=>describe_by_name(
                       EXPORTING
                        p_name = table_name
                        RECEIVING
                         p_descr_ref = DATA(typedescr)
                       EXCEPTIONS
                        type_not_found = 1 ).

    IF sy-subrc <> 0.
      result = abap_false.
      RETURN.
    ENDIF.                    .

    IF typedescr->kind <> cl_abap_typedescr=>kind_struct OR
       typedescr->is_ddic_type( ) <> cl_abap_typedescr=>true.
      result = abap_false.
      RETURN.
    ENDIF.

    IF CAST cl_abap_structdescr( typedescr )->components <>
       CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_name( template_table )
                               )->components.
      result = abap_false.
      RETURN.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
