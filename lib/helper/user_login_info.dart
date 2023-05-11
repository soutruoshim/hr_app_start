import 'dart:convert';

import 'package:hr_app/data/model/body/login_model_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

LoginModelInfo getLoginInfo(BuildContext context){
  final String userInfo = "";
  Map<String, dynamic> jsonUserInfo = jsonDecode(userInfo);
  var userModelInfo = LoginModelInfo.fromJson(jsonUserInfo);
  return userModelInfo;
}