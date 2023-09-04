import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/error/error_messages.dart';
import 'package:eng_shop/features/auth/views/screens/reset_password/password_reset_methods_screen.dart';
import 'package:eng_shop/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:eng_shop/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:eng_shop/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:eng_shop/features/profile/views/screens/profile_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:libphonenumber/libphonenumber.dart' as phoneUtil;
import '../../../../../core/config/app_consts.dart';
import '../../../../../core/config/app_images.dart';
import '../../../../../core/di/app_module.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../auth/domain/usecase/logout_usecase.dart';
import '../../../../auth/views/screens/auth_methods_screen.dart';
import '../../../../settings/view/screens/settings_screen.dart';
import '../../components/diaglog.dart';
import '../../util/me_entity.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();


  PhoneNumber initialValue = PhoneNumber(isoCode: "KW" );
  String phoneNumber = "";

  bool isPhoneNumberValid = false;

  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();


  ProfileCubit() : super(ProfileInitial());

  String? validateEmail() {
    if (emailController.text.isEmail()) {
      return null;
    } else {
      return "Please enter a valid email";
    }
  }

  String? validateUsername() {
    if (nameController.text.isNotEmpty) {
      return null;
    } else {
      return "Please enter your name";
    }
  }

  validatePhoneNumber() {
    if (isPhoneNumberValid) {
      return null;
    } else {
      return "Please enter a valid phone number";
    }
  }


  onSaveClick(BuildContext context) {
    updateProfile();
  }

  onInputValidate(bool value) {
    isPhoneNumberValid = value;

  }


  onPhoneChange(PhoneNumber phoneNumber, BuildContext context) {
    validatePhoneNumber();
    if(initialValue.phoneNumber != null) {
      this.phoneNumber = initialValue.phoneNumber! ;
      phoneNumber = initialValue;
    }
  }

  onChangePasswordClick(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_)=> const PasswordResetMethodsScreen()));
  }


  List<MeEntity> get myOrders => [
    MeEntity(label: LocaleKeys.processing.tr(), icon: AppImages.processing),

    MeEntity(label: LocaleKeys.shipped.tr(), icon: AppImages.shipped),

    MeEntity(label: LocaleKeys.returns.tr(), icon: AppImages.returns),

    MeEntity(label: LocaleKeys.tracking.tr(), icon: AppImages.tracking),
  ];


  List<MeEntity> get services => [
    MeEntity(label: LocaleKeys.support.tr(), icon: AppImages.support),

    MeEntity(label: LocaleKeys.survey.tr(), icon: AppImages.survey),
  ];

  onLogoutClick(BuildContext context) {
    showCustomDialog(
        context,
        label: LocaleKeys.logout.tr(),
        message: LocaleKeys.logout_sub_text.tr(),
        callToAction: LocaleKeys.logout.tr(),
        antiCallToAction: LocaleKeys.cancel.tr(),
        onAntiCallToActionTap: (){
          Navigator.pop(context);
        },
        onCallToActionTap: (){
          logout(context);
        }
    );
  }


  logout(BuildContext context) async {
    await getIt<LogoutUsecase>().call(LogoutParams(AppConsts.homeScreen)).then(
            (value) => value.fold(
                (error) {
            },
                (success) {
              return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> const AuthMethodsScreen()), (route) => false);
            }
        )
    );
  }

  onSettengsClick(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (_)=> const SettingsScreen()));
  }

  onProfileClick(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_)=> const ProfileScreen()));
  }

  late String initName;
  late String initEmail;
  late String initMobile;

  String? getMobile(){
    if(initMobile != phoneNumberController.text){
      return phoneNumberController.text;
    }
    return null;
  }

  String? getEmail(){
    if(initEmail != emailController.text){
      return emailController.text;
    }
    return null;
  }

  String? getName(){
    if(initName != nameController.text){
      return nameController.text;
    }
    return null;
  }

  getProfile(){

    emit(ProfileLoading());
    getIt<GetProfileUsecase>().call(GetProfileParams(AppConsts.profileScreen)).then(
      (value) => value.fold(
        (error) {
          emit(ProfileFailure(error));
          emit(ProfileInitial());

          print(ErrorMessages().debugErrorCode(error.code()));
        },
        (success) async {
          emit(ProfileSuccess());

          initName = success.etxt?? "";
          initEmail = success.uname?? "";
          initMobile = success.mobile?? "";

          nameController.text = success.etxt?? "";
          emailController.text = success.uname?? "";
          phoneNumberController.text = success.mobile != null ? success.mobile! : "";

          

          emit(ProfileInitial());

        }
      )
    );
  }



  updateProfile(){
    if(initName == nameController.text && initMobile == phoneNumberController.text && initEmail == emailController.text ){

    }else {
      if(profileFormKey.currentState!.validate()) {
        emit(ProfileLoading());
        getIt<UpdateProfileUsecase>().call(UpdateProfileParams(screenCode: AppConsts.profileScreen,name: getName(),email: getEmail(),mobile: getMobile() )).then(
          (value) => value.fold(
            (error) {
              emit(ProfileFailure(error));
              emit(ProfileInitial());

              print(ErrorMessages().debugErrorCode(error.code()));
            },
            (success) {
              emit(ProfileSuccess());
              emit(ProfileInitial());
              getProfile();

            }
          )
        );
      }
    }

  }

  changePassword() {
    if(changePasswordFormKey.currentState!.validate()) {
      emit(ProfileLoading());
      getIt<ChangePasswordUsecase>().call(ChangePasswordParams(oldPasswordController.text, newPasswordController.text, AppConsts.profileScreen)).then(
        (value) => value.fold(
          (error) {
            emit(ProfileFailure(error));
            emit(ProfileInitial());

          },
          (success) {
            emit(ProfileSuccess());
            emit(ProfileInitial());

          }
        )
      );
    }
  }


}
