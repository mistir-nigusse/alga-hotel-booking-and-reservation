class ResevationMutation {
  String reservationmutation = """
 mutation(\$checkin_time:String,\$checkout_time:String,\$roomId:ID,\$hotelId:ID){
  addReservation(reservationInfo:{checkin_time:\$checkin_time,checkout_time:\$checkout_time,roomId:\$roomId,hotelId:\$hotelId}) {
    message
  }
}
  """;
  String companyReservationMutation = """
 
   mutation(\$companyName:String,\$companyEmail:String,\$checkin_time:String,\$checkout_time:String,\$roomId:[ID],\$hotelId:ID ){
    companyAddReservation(companyReserve:{companyName:\$companyName, companyEmail:\$companyEmail,checkin_time:\$checkin_time,checkout_time:\$checkout_time,roomId:\$roomId,hotelId:\$hotelId}){
      message
    }
   }


""";
}
