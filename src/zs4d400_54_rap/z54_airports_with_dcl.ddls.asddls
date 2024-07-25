@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS View for airport'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z54_AIRPORTS_WITH_DCL
  as select from /DMO/I_Airport
{
  key AirportID,
      Name,
      City,
      CountryCode,
      /* Associations */
      _Country
}
