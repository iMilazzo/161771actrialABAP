@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_54AFLG
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_54AFLG
{
  key CarrierId,
  key ConnectionId,
  key FlightDate,
  Price,
  CurrencyCode,
  PlaneTypeId,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
