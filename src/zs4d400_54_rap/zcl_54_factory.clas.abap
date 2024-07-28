CLASS zcl_54_factory DEFINITION
PUBLIC
FINAL
CREATE PUBLIC .


  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_54_factory IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA connection TYPE REF TO lcl_connection.


* Debug the method to show that the class returns objects, but that there are different
* objects for the same combination of airline and flight number


    connection = lcl_connection=>get_connection( airlineid = 'LH' connectionnumber = '0400' ).
    out->write( connection->get_attributes(  ) ).

    connection = lcl_connection=>get_connection( airlineid = 'AA' connectionnumber = '1234' ).
    out->write( connection->get_attributes(  ) ).


  ENDMETHOD.


ENDCLASS.
