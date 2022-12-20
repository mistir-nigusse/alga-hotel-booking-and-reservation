class GalleryQuery {
  String galleryquery = """
  query{
    userViewHotels{
      photos {
      Id
      imageURI
      createdAt
      updatedAt
    }
    }
  }
  """;
}
