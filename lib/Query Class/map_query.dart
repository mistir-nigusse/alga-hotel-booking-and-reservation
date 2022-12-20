class MapQuery {
  final String mapQuery = """
  query(\$nearByHotelLat: Float, \$nearByHotelLong: Float, \$nearByHotelRadius: Float){
  nearByHotel (lat: \$nearByHotelLat,long: \$nearByHotelLong,radius: \$nearByHotelRadius){
 Id
     name
     distance
     star
     photos {
      Id
      imageURI
      createdAt
      updatedAt
    }
      address {
        lat
        long
      }
  }
}
  """;
}
