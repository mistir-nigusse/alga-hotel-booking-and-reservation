class CancelReservation {
  String cancelreservation = """
    mutation(\$userCancelReservationReservationId: ID){
  userCancelReservation(reservationId: \$userCancelReservationReservationId) {
    message
  }
}
    """;
}
