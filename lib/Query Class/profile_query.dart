class ProfileQuery {
  String profilequery = """
  query{
  viewProfile {
    Id
    firstName
    middleName
    lastName
    email
    phone_no
    nationality
    
  }
}
  """;
}
