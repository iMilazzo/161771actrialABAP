CLASS zcl_43_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_43_eml IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA agencies_upd TYPE TABLE FOR UPDATE /DMO/I_AgencyTP.
    agencies_upd = VALUE #(   "%is_draft = '00'
                            (  AgencyID = '070043'
                                   Name = 'Mundo iMilazzo'
                                   city = 'Curitiba'
                            countrycode = 'BR'
                             postalcode = '80410-200'
                                 street = 'Rua Visconde de Nácar, 370'
                           emailaddress = 'info@mundoimilazzo.sap'
                             webaddress = 'www.mundoimilazzo.com'
                       /DMO/ZZSloganZAG =  `Traveling in the maionese`
 ) ).

    MODIFY ENTITIES OF /DMO/I_AgencyTP
           ENTITY /DMO/Agency
           UPDATE FIELDS ( Name city countrycode postalcode street emailaddress webaddress )
           WITH agencies_upd.

    DATA agencies_cre TYPE TABLE FOR CREATE /DMO/I_AgencyTP.
    agencies_cre = VALUE #(  (     %cid = 'cid1'
                                   name = 'Mundo iMilazzo'
                                   city = 'Curitiba'
                            countrycode = 'BR'
                             postalcode = '80410-200'
                                 street = 'Rua Visconde de Nácar, 370'
                           emailaddress = 'info@mundoimilazzo.sap'
                             webaddress = 'www.mundoimilazzo.com'
                       /DMO/ZZSloganZAG = 'Traveling in the maionese' ) ).

    MODIFY ENTITIES OF /DMO/I_AgencyTP
           ENTITY /DMO/Agency
           CREATE
           FIELDS ( Name City CountryCode PostalCode Street EMailAddress WebAddress /DMO/ZZSloganZAG )
           WITH agencies_cre.

    COMMIT ENTITIES.

    out->write( `Method execution finished!` ).


  ENDMETHOD.

ENDCLASS.
