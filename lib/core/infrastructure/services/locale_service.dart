import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class LocaleService {

  bool isLtr(BuildContext context){
    if (context.locale.toLanguageTag() == "ar"){
      return false;
    }
    return true;
  }

  bool isArabic(BuildContext context){
    if (context.locale.toLanguageTag() == "ar"){
      return true;
    }
    return false;
  }

}