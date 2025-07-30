class AppUrls {
  String buildCloudinaryCoverUrl(String cover_id){
    return "https://res.cloudinary.com/dhugzirhe/image/upload/$cover_id.jpg";
  }

  String buildCloudinarySongUrl(String song_id){
    return "https://res.cloudinary.com/dhugzirhe/video/upload/v1753066060/$song_id.mp3";
  }
}