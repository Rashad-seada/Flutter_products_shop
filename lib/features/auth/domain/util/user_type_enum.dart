enum UserType {
  customer,
  admin
}

UserType? fromIntToUserType(dynamic userType){

    int? userTypeNumber =  int.tryParse(userType);

    if(userTypeNumber == 5) {
      return UserType.customer;

    } else if(userTypeNumber == 4) {
      return UserType.admin;

    } else {
      return null;
    }

}

UserType? fromStringToUserType(String userType){


  if(userType == "5") {
    return UserType.customer;

  } else if(userType == "4") {
    return UserType.admin;

  } else {
    return null;
  }

}

int? fromUserTypeToInt(UserType userType){

  if(userType == UserType.customer) {
    return 5;

  } else if(userType == UserType.admin) {
    return 4;

  } else {
    return null;
  }

}

String? fromUserTypeToString(UserType userType){

  if(userType == UserType.customer) {
    return "5";

  } else if(userType == UserType.admin) {
    return "4";

  } else {
    return null;
  }

}