abstract class AppConsts {

  static const String prefDBName = "app_db";
  static const String userInfoKey = "userInfo";

  static const String localizationPath = "assets/translations";


  static String baseUrl(String serData,int fid,int serCode) => "http://ksa.engqr.com/SRV/?srv_code=$serCode&fid=$fid&userid=1&upass=111111&uname=eng@engegypt.com&SRV_DATA=$serData";

  static const double font32 = 28;
  static const double font28 = 24;
  static const double font16 = 12;
  static const double font14 = 10;

}