class EditProfileMutation {
  String editprofilemutation = """

mutation(\$firstName:String,\$lastName:String,\$middleName:String,\$phone_no:Int){
  userUpdateProfile(userInfo:{firstName:\$firstName,lastName:\$lastName,middleName:\$middleName,phone_no:\$phone_no}){
    message
  }
}

""";
}
