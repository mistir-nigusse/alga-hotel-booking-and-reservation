class PlacesQuery {
  String placesQuery = """
  query{
  viewHotelsState {
      location{

      }
    
  }
}
  """;
}

class FindPlaces {
  String fetchAA = """query 
 viewHotelsState {
  where: { location: { _eq: AddisAbaba} },
   {
    hotel name..........
  }
}""";
}
