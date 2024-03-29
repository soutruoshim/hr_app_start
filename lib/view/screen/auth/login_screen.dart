import 'package:hr_app/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:hr_app/view/screen/landing_page/landing_screen.dart';
import 'package:provider/provider.dart';

import '../../../helper/email_cheker.dart';
import '../../../provider/auth_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../../base/custom_button.dart';
import '../../base/custom_snackbar.dart';
import '../../base/textfeild/custom_text_feild.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKeyLogin;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    // _emailController.text = Provider.of<AuthProvider>(context, listen: false).getUserEmail() ?? null;
    // _passwordController.text = Provider.of<AuthProvider>(context, listen: false).getUserPassword() ?? null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Provider.of<AuthProvider>(context, listen: false).isActiveRememberMe;
    print(Provider.of<AuthProvider>(context, listen: false).isActiveRememberMe);
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => Form(
        key: _formKeyLogin,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE, right: Dimensions.PADDING_SIZE_LARGE,
                    bottom: Dimensions.PADDING_SIZE_SMALL),
                    child: CustomTextField(
                      border: true,
                      prefixIconImage: Images.email_icon,
                      hintText: "Enter email",
                      focusNode: _emailFocus,
                      nextNode: _passwordFocus,
                      textInputType: TextInputType.emailAddress,
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      onChanged: (String text) {  },
                    )),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                Container(margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE,
                    right: Dimensions.PADDING_SIZE_LARGE, bottom: Dimensions.PADDING_SIZE_DEFAULT),
                    child: CustomTextField(
                      border: true,
                      isPassword: true,
                      prefixIconImage: Images.lock,
                      hintText: "Password",
                      focusNode: _passwordFocus,
                      textInputAction: TextInputAction.done,
                      controller: _passwordController,
                      onChanged: (String text) {  },
                    )),

                Container(
                  margin: EdgeInsets.only(left: 24, right: Dimensions.PADDING_SIZE_LARGE),
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) => InkWell(
                      onTap: () => authProvider.toggleRememberMe(),
                      child: Row(
                        children: [
                          Container(width: Dimensions.ICON_SIZE_DEFAULT, height: Dimensions.ICON_SIZE_DEFAULT,
                            decoration: BoxDecoration(color: authProvider.isActiveRememberMe ?
                            Theme.of(context).primaryColor : Theme.of(context).cardColor,
                                border: Border.all(color:  authProvider.isActiveRememberMe ?
                                Theme.of(context).primaryColor : Theme.of(context).hintColor.withOpacity(.5)),
                                borderRadius: BorderRadius.circular(3)),
                            child: authProvider.isActiveRememberMe ?
                            Icon(Icons.done, color: ColorResources.WHITE,
                                size: Dimensions.ICON_SIZE_SMALL) : SizedBox.shrink(),
                          ),
                          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                          Text("Remember me",
                            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                color: ColorResources.getHintColor(context)),
                          ),
                          Spacer(),


                          InkWell(
                            onTap: () {},
                            child: Text("Forget Password",
                                style: robotoRegular.copyWith(
                                    color: Theme.of(context).primaryColor, decoration: TextDecoration.underline)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),



                SizedBox(height: Dimensions.PADDING_SIZE_BUTTON),
                !authProvider.isLoading ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: CustomButton(
                    borderRadius: 100,
                    backgroundColor: Theme.of(context).primaryColor,
                    btnTxt: "Login",
                    onTap: () async {
                      String _email = _emailController.text.trim();
                      String _password = _passwordController.text.trim();
                      if (_email.isEmpty) {
                        showCustomSnackBar("Enter email address", context);
                      }else if (EmailChecker.isNotValid(_email)) {
                        showCustomSnackBar("Enter valid email", context);
                      }else if (_password.isEmpty) {
                        showCustomSnackBar("Enter password", context);
                      }else if (_password.length < 6) {
                        showCustomSnackBar("Password should be", context);
                      }else {authProvider.login(context, emailAddress: _email, password: _password).then((status) async {
                        if (status.response!.statusCode == 200) {
                          if (authProvider.isActiveRememberMe) {
                            authProvider.saveUserNumberAndPassword(_email, _password);
                          } else {
                            authProvider.clearUserEmailAndPassword();
                          }
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LandingScreen()));
                        }
                      });
                      }
                    },
                  ),
                ) :
                Center( child: CircularProgressIndicator( valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                )),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical:Dimensions.PADDING_SIZE_BOTTOM_SPACE),
                  child: GestureDetector(
                      onTap: (){},
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Terms & Conditions",
                              style: robotoMedium.copyWith(color: Theme.of(context).primaryColor, decoration: TextDecoration.underline)),
                        ],
                      )),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
