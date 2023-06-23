import 'package:flutter/material.dart';
import 'package:hr_app/view/screen/more/setting_list_item.dart';

import 'package:hr_app/view/screen/more/size_config.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

import 'package:flutter_share/flutter_share.dart';

import '../../../provider/auth_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../auth/auth_screen.dart';
// import 'package:quran_cham/pages/about_page.dart';
// import 'package:quran_cham/pages/contact_page.dart';
// import 'package:quran_cham/pages/faq_page.dart';
// import 'package:quran_cham/pages/privacy_page.dart';
// import 'package:quran_cham/pages/term_page.dart';
// import 'package:quran_cham/widgets/setting_list_item.dart';

enum Availability { loading, available, unavailable }

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> with SingleTickerProviderStateMixin{
  final _formKey = GlobalKey<FormState>();
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _rateMyApp(){
    // LaunchReview.launch(
    //   androidAppId: "com.srhdp.quran_khmer_online",
    //   iOSAppId: "id6444371225",
    // );
  }

  Future<void> _shareApp() async {
    try {
      if (UniversalPlatform.isAndroid) {
        await FlutterShare.share(
            title: 'Quran Khmer Online',
            text: "https://play.google.com/store/apps/details?id=com.srhdp.quran_cham_v2.quran_cham"
        );
      } else if (UniversalPlatform.isIOS) {
        await FlutterShare.share(
            title: 'Quran Khmer Online',
            text: "https://apps.apple.com/au/app/quran-khmer-online/id6444371225"
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.MAIN_COLOR,
      appBar: AppBar(
        title: Image.asset(Images.logo_with_app_name, height: 35),
        elevation: 0.0,
        backgroundColor: ColorResources.MAIN_COLOR,
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.blockSizeVertical * 3),
                _buildUserImage(context),
                SizedBox(height: SizeConfig.blockSizeVertical * 2),
                Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Container(
                      margin: EdgeInsets.only(right: 18, left: 18),
                      child: Text(
                        "Services",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorResources.WHITE
                        ),
                      ),
                    )),
                _buildScreenButtonsList(context),
                SizedBox(height: SizeConfig.blockSizeVertical * 2),
                Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Container(
                      margin: EdgeInsets.only(right: 18, left: 18),
                      child: Text(
                        "Additional",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorResources.WHITE
                        ),
                      ),
                    )),

                _buildBottomScreenButtonsList(context),
                //SizedBox(height: SizeConfig.blockSizeVertical * 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildUserImage(BuildContext context) {
    return Container(
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/image/brown_login.png'),
        backgroundColor: Colors.transparent,
        maxRadius: SizeConfig.blockSizeHorizontal * 9.5,
      ),
    );
  }

  _buildScreenButtonsList(BuildContext context) {
    return _buttonsListContainer(
      context,
      Column(
        children: [
          SettingsListItem(
            text: "Profile",
            arrow: false,
            onTap: () => _shareApp(),color: Colors.black,
          ),
          SettingsListItem(
            text: "Change Password",
            arrow: false,
            onTap: () => _rateMyApp(), color: Colors.black,
          ),
          SettingsListItem(
            text: "Meeting",
            arrow: false,
            onTap: () => _rateMyApp(), color: Colors.black,
          ),
          SettingsListItem(
            text: "Holiday",
            arrow: false,
            onTap: () => _rateMyApp(), color: Colors.black,
          ),
          SettingsListItem(
            text: "Team Sheet",
            arrow: false,
            onTap: () => _rateMyApp(), color: Colors.black,
          ),
          SettingsListItem(
            text: "Leave Calendar",
            arrow: false,
            onTap: () => _rateMyApp(), color: Colors.black,
          ),
          SettingsListItem(
            text: "Notices",
            arrow: false,
            onTap: () => _rateMyApp(), color: Colors.black,
          ),
        ],
      ),
    );
  }
  _buttonsListContainer(BuildContext context, Widget body) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 10.0),

      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.blueGrey.shade700,
            width: 1.0),
        color: Colors.blueGrey.shade700,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color:Colors.blueGrey.shade700,
            blurRadius: 0.5,
            offset: Offset(0.2, 0.2),
          ),
        ],
      ),
      child: body,
    );
  }

  _buildBottomScreenButtonsList(BuildContext context) {
    return  Container(
      child: _buttonsListContainer(
        context,
        Column(
          // shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          children: [
            SettingsListItem(
              text: 'Company Rule',
              arrow: true,
              first: true,
              onTap: (){},
              // onTap: () => Navigator.of(context).push(
              //     MaterialPageRoute<void>(
              //       fullscreenDialog: true,
              //       builder: (context) => AboutUsScreen(),
              //     )
              // ),
              color: Colors.black,
            ),
            SettingsListItem(
              text: "About Us",
              arrow: true,
              onTap: (){},
              color: Colors.black,
            ),
            SettingsListItem(
              text: "Terms & Conditions",
              arrow: true,
              onTap: (){},
              color: Colors.black,
            ),
            SettingsListItem(
              text: "Privacy Policy",
              arrow: true,
              onTap: (){},
              color: Colors.black,
            ),
            SettingsListItem(
              text: "Logout",
              arrow: true,
              onTap: (){
                Provider.of<AuthProvider>(context, listen: false).clearSharedData();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthScreen()), (route) => false);
              },
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}