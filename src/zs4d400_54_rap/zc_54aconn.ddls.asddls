@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_54ACONN
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_54ACONN
{
  key Uuid,
  CarrierId,
  ConnectionId,
  AirportFromId,
  CityFrom,
  CountryFrom,
  AirportToId,
  CityTo,
  CountryTo,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
