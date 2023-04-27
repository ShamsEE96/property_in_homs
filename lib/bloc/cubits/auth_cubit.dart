import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/states/auth_states.dart';
import 'package:property_in_homs/utils/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this.sp) : super(AuthInitialState());
  static AuthCubit get(BuildContext context) => BlocProvider.of(context);
  SharedPreferences sp;
  String token = '';

  TextEditingController loginUsernameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  TextEditingController registerUsernameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerMobileNoController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerPassowrdConfirmation = TextEditingController();

  static String adminUserId = "rOIkuoPLN2";
  static String? currentUserId;
  String? posterUserName;
  String? currentUserName;
  String? currentUserEmail;
  String? currentUserNumber;

//Saving Token In Shared Prefrences
  Future<void> saveTokenInSP(
    String t,
  ) async {
    await sp.setString("token", t);
    loadTokenFromSP();
  }

  // Loading Token from Shared Prefrences
  void loadTokenFromSP() {
    String t = sp.getString('token') ?? "";
    DioHelper.initialize(token: t);
    token = t;
    emit(AuthRefreshUIState());
  }

  Future<void> saveUserInfo(String currentUserId, String currentUserName,
      String currentUserEmail, String currentUserNumber) async {
    await sp.setString("UserId", currentUserId);
    await sp.setString("UserName", currentUserName);
    await sp.setString("UserEmail", currentUserEmail);
    await sp.setString("Number", currentUserNumber);
    loadUserInfo();
  }

  void loadUserInfo() {
    String userId = sp.getString('UserId') ?? "";
    currentUserId = userId;
    String user = sp.getString('UserName') ?? "";
    currentUserName = user;
    String email = sp.getString('UserEmail') ?? "";
    currentUserEmail = email;
    String num = sp.getString('Number') ?? "";
    currentUserNumber = num;
    emit(AuthRefreshUIState());
  }

  Future<bool> register() async {
    try {
      var regData = {
        'username': registerUsernameController.text.trim(),
        'email': registerEmailController.text.trim(),
        'mobileNo': registerMobileNoController.text,
        'password': registerPasswordController.text,
        // 'password confirmation': registerPassowrdConfirmation.text,
      };
      var res = await DioHelper.dio!.post('users', data: regData);
      if (res.statusCode == 201) {
        saveTokenInSP(res.data['sessionToken'] as String);
        emit(AuthSuccessState());
        return true;
      }
    } catch (e) {
      emit(AuthErrorState());
    }
    return false;
  }

  Future<bool> login() async {
    try {
      var logData = {
        'username': loginUsernameController.text.trim(),
        'password': loginPasswordController.text,
      };
      var res = await DioHelper.dio!.get('login', queryParameters: logData);
      if (res.statusCode == 200) {
        saveTokenInSP(res.data['sessionToken']);
        await getProfileInfo();
        loadUserInfo();
        emit(AuthSuccessState());
        return true;
      }
    } catch (e) {
      emit(AuthErrorState());
    }
    return false;
  }

  Future<void> logout() async {
    await saveTokenInSP('');
    await saveUserInfo('', '', '', '');
  }

  Future<bool> getProfileInfo() async {
    try {
      var res = await DioHelper.dio!.get(
        'users/me',
      );
      if (res.statusCode == 200) {
        saveUserInfo(
          res.data['objectId'],
          res.data['username'],
          res.data['email'],
          res.data['mobileNo'],
        );

        emit(AuthSuccessState());
        return true;
      }
    } catch (e) {
      emit(AuthErrorState());
    }
    return false;
  }

  Future<bool> getPosterUser() async {
    try {
      var res = await DioHelper.dio!.get(
        'users/me',
      );
      if (res.statusCode == 200) {
        emit(AuthSuccessState());
        return true;
      }
    } catch (e) {
      emit(AuthErrorState());
    }
    return false;
  }
}
