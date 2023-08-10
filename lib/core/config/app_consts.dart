import 'dart:ui';

abstract class AppConsts {

  static const String prefDBName = "app_db";
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


  static String baseUrl(String domain,String serviceEmail,String servicePassword,String serData,int fid,int serCode) => "$domain/SRV/?srv_code=$serCode&fid=$fid&userid=1&upass=$servicePassword&uname=$serviceEmail&SRV_DATA=$serData";

  static const double font32 = 28;
  static const double font28 = 24;
  static const double font21 = 17;
  static const double font16 = 12;
  static const double font14 = 10;

}