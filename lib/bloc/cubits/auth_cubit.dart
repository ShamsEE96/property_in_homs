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

//Saving Token In Shared Prefrences
  Future<void> saveTokenInSP(String t) async {
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
        saveTokenInSP(res.data['sessionToken' as String]);
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
  }
}
