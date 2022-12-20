class CybersourceQuery {
  String cybersourcequery = """query (
    \$price: String,
    \$reservationId: String,
    \$Redirect_url:String,
    \$paymentMethod: String,
  ) {
    userHashVisaAndMastercardPaymentInfo(
      price: \$price,
      reservationId: \$reservationId,
      Redirect_url:\Redirect_url,
      paymentMethod: \$paymentMethod,
    ) 
    {
      amount
      access_key
      currency
      locale
      payment_method
      profile_id
      reference_number
      signed_date_time
      signed_field_names
      transaction_type
      transaction_uuid
      unsigned_field_names
      signature
      bill_to_address_postal_code
      bill_to_email
      bill_to_forename
      bill_to_phone
      bill_to_surname
      card_type
     
    }
  } """;
}
