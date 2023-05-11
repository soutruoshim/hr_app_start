import 'dart:async';

import 'package:hr_app/data/model/body/login_model_request.dart';
import 'package:hr_app/data/model/response/store_model.dart';
import 'package:hr_app/provider/splash_provider.dart';
import 'package:hr_app/utill/app_constants.dart';
import 'package:hr_app/utill/strings_manager.dart';
import 'package:hr_app/view/base/custom_dropdown.dart';
import 'package:hr_app/view/base/custom_dropdown_obj.dart';
import 'package:hr_app/view/screen/landing_page/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';

import '../../../data/model/body/MenuModelRequest.dart';
import '../../../helper/parse_event.dart';
import '../../../helper/security_helper.dart';
import '../../../helper/user_login_info.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/parse_provider.dart';
import '../../../provider/product_provider.dart';
import '../../../provider/report_parse_provider.dart';
import '../../../utill/dimensions.dart';
import '../../base/custom_button.dart';
import '../../base/custom_snackbar.dart';
import '../../base/textfeild/custom_text_feild.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({Key? key}) : super(key: key);

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  //FocusNode _passwordFocus = FocusNode();

  late ProgressDialog pd;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKeyLogin;

  final List<String> _accounts = [
    "Cashier AM 1",
    "Cashier AM 2",
    "Cashier AM 3",
    "Cashier PM 1",
    "Cashier PM 2",
    "Cashier PM 3"
  ];
  String _accountSelected = "";
  late Store _storeSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pd = ProgressDialog(context: context);
    _formKeyLogin = GlobalKey<FormState>();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Store>? storeList = Provider.of<SplashProvider>(context, listen: false)
        .storeModelList
        .result;

    Provider.of<AuthProvider>(context, listen: false).isActiveRememberMe;

    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => Form(
          key: _formKeyLogin,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_SMALL),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_LARGE,
                          right: Dimensions.PADDING_SIZE_LARGE,
                          bottom: Dimensions.PADDING_SIZE_SMALL),
                      child: CustomDropdown(
                        border: true,
                        hintText: AppStrings.select_account,
                        items: _accounts,
                        onChanged: (text) {
                          setState(() {
                            _accountSelected = text;
                          });
                        },
                      )),
                  const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  Container(
                      margin: const EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_LARGE,
                          right: Dimensions.PADDING_SIZE_LARGE,
                          bottom: Dimensions.PADDING_SIZE_DEFAULT),
                      child: CustomTextField(
                        border: true,
                        isPassword: true,
                        //prefixIconImage: Images.lock,
                        hintText: AppStrings.password,
                        //focusNode: _passwordFocus,
                        textInputAction: TextInputAction.done,
                        controller: _passwordController,
                        onChanged: (text) {},
                      )),
                  const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  Container(
                      margin: const EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_LARGE,
                          right: Dimensions.PADDING_SIZE_LARGE,
                          bottom: Dimensions.PADDING_SIZE_SMALL),
                      child: CustomDropdownObj(
                        border: true,
                        hintText: AppStrings.select_store,
                        items: storeList ?? [],
                        onChanged: (item) {
                          _storeSelected = item;
                        },
                      )),
                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: CustomButton(
                      borderRadius: 100,
                      backgroundColor: authProvider.isLoading?Theme.of(context).hintColor: Theme.of(context).primaryColor,
                      btnTxt: authProvider.isLoading?"Waiting...": AppStrings.login,
                      onTap: authProvider.isLoading?(){}: () {
                        String user_id = _accountSelected;
                        String password = _passwordController.text.trim();
                        String store_id = _storeSelected.storeId!;

                        String data_enc =
                            SecurityHelper.getDataEncryptionKey(dataTypes: [
                          "${store_id}USER_CASHIER_LOGIN",
                        ], dev_kit: AppConstants.dev_kid);

                        print("enc= $data_enc");

                        if (user_id.isEmpty) {
                          showCustomSnackBar("Select User id", context);
                        } else if (password.isEmpty) {
                          showCustomSnackBar("Enter Password", context);
                        } else {
                          //pd.show(max: 100, msg: 'Please waiting...!');
                          authProvider
                              .login(
                                  context,
                                  LoginModelRequest(
                                      devKid: AppConstants.dev_kid,
                                      function: AppConstants.store_app_function,
                                      storeappFunction: AppConstants
                                          .store_app_function_store_app_login,
                                      datas: Datas(
                                          username: _accountSelected,
                                          userpassword: password,
                                          storeid: store_id,
                                          dataEncryption: data_enc)),
                                  _storeSelected)
                              .then((status) async {
                            if (status.response!.statusCode == 200) {
                              // if (authProvider.isActiveRememberMe) {
                              //    authProvider.saveUserNumberAndPassword(password);
                              // } else {
                              //    authProvider.clearUserEmailAndPassword();
                              // }

                              var userModelInfo = await getLoginInfo(context);
                              print("store save id: ${userModelInfo.storeId}");
                              if (userModelInfo.storeId != null) {
                                print("store id not null");
                                await Provider.of<ParseProvider>(context, listen: false).getOrderList(context, 1, userModelInfo.storeId!);
                               Timer(const Duration(seconds: 3), () async {
                                await Provider.of<ParseProvider>(context, listen: false).getOrderList(context, 0, userModelInfo.storeId!);
                                await Provider.of<ParseProvider>(context, listen: false).getOrderList(context, 2, userModelInfo.storeId!);
                                await Provider.of<ParseProvider>(context, listen: false).getOrderList(context, 3, userModelInfo.storeId!);
                                await Provider.of<ParseProvider>(context, listen: false).getOrderList(context, 4,userModelInfo.storeId!);
                                await Provider.of<ParseProvider>(context, listen: false).getOrderList(context, 5, userModelInfo.storeId!);
                                await Provider.of<ParseProvider>(context, listen: false).getOrderList(context, -1,userModelInfo.storeId!);
                                await Provider.of<ParseProvider>(context, listen: false).getOrderList(context, -2, userModelInfo.storeId!);

                                Provider.of<ParseProvider>(context,listen: false).liveQueryBooking(context);

                                //==========product=======
                                String data_enc_menu =
                                    SecurityHelper.getDataEncryptionKey(
                                        dataTypes: [
                                      "CSTORE_LIST_MENU_STATUS",
                                    ],
                                        dev_kit: AppConstants.dev_kid);

                                MenuModelRequest menuModelRequest =
                                    MenuModelRequest(
                                        devKid: AppConstants.dev_kid,
                                        function:
                                            AppConstants.store_app_function,
                                        storeappFunction: AppConstants
                                            .store_app_function_check_all_menu_status,
                                        datas: DatasMenuRequest(
                                            dataEncryption: data_enc_menu,
                                            storeid: _storeSelected.storeId,
                                            func: AppConstants.func_type));
                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .getMenuList(context, menuModelRequest);

                                //==========service=======
                                String data_enc_menu_service =
                                    SecurityHelper.getDataEncryptionKey(
                                        dataTypes: [
                                      "CSERVICE_LIST",
                                    ],
                                        dev_kit: AppConstants.dev_kid);
                                MenuModelRequest menuModelRequest_for_service =
                                    MenuModelRequest(
                                        devKid: AppConstants.dev_kid,
                                        function:
                                            AppConstants.store_app_function,
                                        storeappFunction: AppConstants
                                            .store_app_function_service_list,
                                        datas: DatasMenuRequest(
                                            dataEncryption:
                                                data_enc_menu_service,
                                            storeid: _storeSelected.storeId,
                                            func: AppConstants.func_type));
                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .getServiceList(
                                        context, menuModelRequest_for_service);

                                //=========badges=======
                                await Provider.of<ReportParseProvider>(context,
                                        listen: false)
                                    .getReportOrderTotal(
                                        context, 1, userModelInfo.storeId!);
                                await Provider.of<ReportParseProvider>(context,
                                        listen: false)
                                    .getReportOrderTotal(
                                        context, 2, userModelInfo.storeId!);
                                await Provider.of<ReportParseProvider>(context,
                                        listen: false)
                                    .getReportOrderTotal(
                                        context, 3, userModelInfo.storeId!);
                                await Provider.of<ReportParseProvider>(context,
                                        listen: false)
                                    .getReportOrderTotal(
                                        context, 4, userModelInfo.storeId!);
                                await Provider.of<ReportParseProvider>(context,
                                        listen: false)
                                    .getReportOrderTotal(
                                        context, 5, userModelInfo.storeId!);
                                await Provider.of<ReportParseProvider>(context,
                                        listen: false)
                                    .getReportOrderTotal(
                                        context, -1, userModelInfo.storeId!);
                                await Provider.of<ReportParseProvider>(context,
                                        listen: false)
                                    .getReportOrderTotal(
                                        context, -2, userModelInfo.storeId!);

                                // if(pd.isOpen()){
                                //   pd.close();
                                // }
                                Provider.of<AuthProvider>(context, listen: false).setLoading(false);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) => LandingScreen()));
                               });
                              }
                            }
                          });
                        }

                        // String _password = _passwordController.text.trim();
                        // print("Account: $_accountSelected, Pass: $_password, Store: $_storeSelected");
                        //
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashboardScreen()));
                      },
                    ),
                  ),
                  const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  authProvider.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ))
                      : Container(),
                ],
              ),
            ),
          )),
    );
  }
}
