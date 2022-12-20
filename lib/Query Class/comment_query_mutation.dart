class CommentQueryMutation {
  String commentquery = """
    query{
      userViewHotels{
        name

         rate{
        rateAvarage
        rateTotal
        rateCount
      }
      comments {
      Id
      createdAt
      body
      hotelId
     
      user {
        Id
        firstName
        lastName
        middleName
        email
        phone_no
      }
    }
      }
    }
    """;
  String commentmutation = """
    mutation(\$commentBody: String, \$commentHotelId: ID,\$userId: ID){
  comment(body: \$commentBody,hotelId: \$commentHotelId, userId:\$userId) {
    message
  }
}
    """;
  String commentmutation2 = """
    mutation(\$rateHotelRate: Int, \$rateHotelHotelId: ID){
  rateHotel (rate: \$rateHotelRate,hotelId: \$rateHotelHotelId){
    message
  }
}
    """;
}
