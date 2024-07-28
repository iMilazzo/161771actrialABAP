INTERFACE lif_partner.
  TYPES: BEGIN OF ts_partner,
           name           TYPE string,
           contact_person TYPE string,
         END OF ts_partner,
         tt_partners TYPE SORTED TABLE OF ts_partner WITH UNIQUE KEY name contact_person.
  DATA it_partners  TYPE tt_partners.
  METHODS get_partner_attributes RETURNING VALUE(rs_partner) TYPE ts_partner.
ENDINTERFACE.


CLASS lcl_travel_Agency DEFINITION.
  PUBLIC SECTION.
    TYPES: tt_agencies TYPE STANDARD TABLE OF REF TO lif_partner with DEFAULT KEY.
    DATA it_agencies TYPE tt_agencies.
    METHODS add_partner IMPORTING io_agency TYPE REF TO lif_partner.
    METHODS get_partners RETURNING VALUE(rt_partners) TYPE tt_agencies.
ENDCLASS.

CLASS lcl_travel_agency IMPLEMENTATION.

  METHOD add_partner.
    DATA lo_partner TYPE REF TO lif_partner.
    lo_partner = CAST #( io_agency ).
    INSERT lo_partner INTO TABLE it_agencies.
  ENDMETHOD.

  METHOD get_partners.
    rt_partners = it_agencies[].
  ENDMETHOD.

ENDCLASS.


CLASS lcl_airline DEFINITION.
  PUBLIC SECTION.

    INTERFACES lif_Partner.

    TYPES: BEGIN OF ts_detail,
             name  TYPE string,
             value TYPE string,
             city  TYPE string,
           END OF ts_detail,
           tt_Details TYPE SORTED TABLE OF ts_detail WITH UNIQUE KEY name.

    DATA is_Detail TYPE ts_detail.
    DATA it_Details TYPE tt_Details.

    METHODS constructor IMPORTING iv_name           TYPE ts_detail-name
                                  iv_contact_person TYPE ts_detail-value
                                  iv_city           TYPE ts_detail-city.
    METHODS get_detail RETURNING VALUE(rs_detail) TYPE ts_detail.
ENDCLASS.


CLASS lcl_car_Rental DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_Partner.
    TYPES: BEGIN OF ts_info,
             name    TYPE c LENGTH 20,
             value   TYPE c LENGTH 20,
             has_hgv TYPE abap_bool,
           END OF ts_info,
           tt_Info TYPE SORTED TABLE OF ts_info WITH UNIQUE KEY name.

    DATA is_info TYPE ts_info.
    DATA it_info TYPE tt_info.

    METHODS constructor IMPORTING iv_name           TYPE ts_info-name
                                  iv_contact_person TYPE ts_info-value
                                  iv_has_hgv        TYPE abap_bool.
    METHODS get_information RETURNING VALUE(rs_info) TYPE ts_info.

ENDCLASS.


CLASS lcl_airline IMPLEMENTATION.


  METHOD get_detail.
    rs_detail-name = is_detail-name.
    rs_detail-value = is_detail-value.
  ENDMETHOD.


  METHOD lif_partner~get_partner_attributes.
    rs_partner = VALUE #( name = is_detail-name contact_person = is_detail-value ).
  ENDMETHOD.

  METHOD constructor.
    is_Detail-name = iv_name.
    is_Detail-value = iv_contact_person.
    is_Detail-city = iv_city.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_car_rental IMPLEMENTATION.

  METHOD constructor.
    is_info-name = iv_name.
    is_info-value = iv_contact_person.
    is_info-has_hgv = iv_has_hgv.
  ENDMETHOD.


  METHOD get_information.
    rs_info-name = is_info-name.
    rs_info-value = is_info-value.
  ENDMETHOD.


  METHOD lif_partner~get_partner_attributes.
    rs_partner = VALUE #( name = is_info-name contact_person = is_info-value ).
  ENDMETHOD.


ENDCLASS.
