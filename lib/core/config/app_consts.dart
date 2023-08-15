import 'dart:ui';

abstract class AppConsts {

  static const String prefDBName = "app_db";
  static const String mainDBName = "app_database.db";

  static const String userInfoKey = "userInfo";
  static const String languageKey = "language";
  static const String serviceProviderDomainKey = "serviceDomainKey";
  static const String serviceProviderEmailKey = "serviceEmailKey";
  static const String serviceProviderPasswordKey = "servicePasswordKey";
  static const String isFirstTimeKey = "isFirstTimeKey";

  static const String localizationPath = "assets/translations";

  static const String english = "en";
  static const String arabic = "ar";

  static const String domain = "http://ksa.engqr.com";
  static const String serviceEmail = "eng@engegypt.com";
  static const String servicePassword = "111111";


  static String baseUrl(String domain,String serviceEmail,String servicePassword,String serData,int fid,int serCode,{String endPoint = ""}) => "$domain/SRV/$endPoint?srv_code=$serCode&fid=$fid&userid=1&upass=$servicePassword&uname=$serviceEmail&SRV_DATA=$serData";
  static String baseImageUrl(String domain,String productId) => "$domain/files/ENG_STORES/mdata/751/images/thums/t${productId}_29.jpg";


  //Screens code
  static int get authMethodScreen => 100;
  static int get loginScreen => 101;
  static int get registrationScreen => 102;
  static int get resetPasswordMethodScreen => 103;
  static int get resetPasswordScreen => 104;
  static int get pinScreen => 105;
  static int get newPasswordScreen => 106;
  static int get accountActivationScreen => 107;


}