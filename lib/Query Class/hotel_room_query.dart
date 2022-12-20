class HotelRoomtypesQuery {
  String hotelroomsquery = """
  query{
  userViewHotels{
    Id
    description
    star
    name
    email
    phone_no
    sellers {
      Id
      firstName
      lastName
      middleName
      phone_no
      password
      username
      updatedAt
      createdAt
    }
    services {
      Id
      name
      description
      updatedAt
      createdAt
    }
    rate {
      Id
      rateTotal
      rateCount
      rateAvarage
    }
    updatedAt
    createdAt
    photos {
      Id
      imageURI
      createdAt
      updatedAt
    }
    roomTypes {
      Id
      description
      price
      name
      createdAt
      updatedAt
      rooms {
        Id
        floor_no
        room_no
        updatedAt
        createdAt
        available
      }
      images {
        Id
        imageURI
        createdAt
        updatedAt
      }
      roomService {
        Id
        name
        description
        price
        createdAt
        updatedAt
      }
      capacity
      price
      rate {
        Id
        rateTotal
        rateCount
        rateAvarage
      }
    }
    comments {
      Id
      createdAt
      body
      user {
        Id
        firstName
        lastName
        middleName
        email
        phone_no
      }
    }
    location {
      Id
      city
      wereda
      state
    }
  }
}
  """;
}
