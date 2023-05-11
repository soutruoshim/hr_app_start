import 'package:hr_app/view/screen/attendance/attendance_screen.dart';
import 'package:hr_app/view/screen/home/home_page_screen.dart';
import 'package:hr_app/view/screen/leave/leave_page_screen.dart';
import 'package:hr_app/view/screen/more/more_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/parse_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../auth/auth_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  late List<Widget> _screens;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {

    super.initState();
    _screens = [
         HomePageScreen(),
         LeavePageScreen(),
         AttendanceScreen(),
         MoreScreen()
    ];

  }
  @override
  Widget build(BuildContext context) {
    // LiveQuery liveQuery = LiveQuery();
    // onCreateOrder(context, liveQuery, getLoginInfo(context), 1);
    // onUpdateOrder(context, liveQuery, getLoginInfo(context), -1);
    Provider.of<ParseProvider>(context,listen: false).liveQueryBooking(context);
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        key: _scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: ColorResources.HINT_TEXT_COLOR,
          selectedFontSize: Dimensions.FONT_SIZE_SMALL,
          unselectedFontSize: Dimensions.FONT_SIZE_SMALL,
          selectedLabelStyle: robotoBold,
          backgroundColor: Theme.of(context).backgroundColor,
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            _barItem(Images.home, "Home", 0),
            _barItem(Images.product_icon, "Leave", 1),
            _barItem(Images.order, "Report", 2),
            _barItem(Images.menu, "More", 3)
          ],
          onTap: (int index) {
            if (index != 4) {
              setState(() {
                _setPage(index);
              });
            } else {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (con) => _buildMoreMenu()
              );
            }
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  _buildMoreMenu(){
    return  Container(
      margin: Device.get().isTablet ? EdgeInsets.only(right: MediaQuery.of(context).size.height / 6, left: MediaQuery.of(context).size.height / 6): EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
            topLeft:  Radius.circular(25),
            topRight: Radius.circular(25)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: ()=> Navigator.pop(context),
            child: Icon(Icons.keyboard_arrow_down_outlined,color: Theme.of(context).hintColor,
              size: Dimensions.ICON_SIZE_LARGE,),
          ),

          SizedBox(height: Dimensions.PADDING_SIZE_VERY_TINY),
          Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(Images.logo_with_app_name, height: 35),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Restart.restartApp();
                          },
                          child: Text("Restart", style: TextStyle(color: Colors.green, fontSize: 16),),
                        ),
                        SizedBox(width: 16,),
                        GestureDetector(
                          onTap: () {
                            Provider.of<AuthProvider>(context, listen: false).logOut(context).then((value) =>  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => AuthScreen())));
                          },
                          child: Text("Logout", style: TextStyle(color: Colors.red, fontSize: 16),),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 32,),
                Text("From humble beginnings grow great things. What started off as a staff of less than 10 has grown to a staff of over seven hundreds in just 10 years. We believe in treating our staff like family. Because when people love what they do, they do good work. The BROWN family is committed to excellence and to providing friendly and welcoming service. From our Baristas to our Chefs to our Head of Human Resources, we embrace an environment of teamwork and personal growth.",
                  style: robotoRegular.copyWith(color: Theme.of(context).hintColor),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 32,),
                Text("Thank You For good service.",
                  style: robotoRegular.copyWith(color: Colors.green),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 32,),
                Center(
                  child:  Text("Copyright © 2009 - 2023 Brown Coffee", style: TextStyle(color: Color(0xFF603813), fontSize: 12),),
                )

              ],
            )
          )

        ],
      ),
    );
  }

  BottomNavigationBarItem _barItem(String icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom : Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(width: index == _pageIndex ? Dimensions.ICON_SIZE_LARGE : Dimensions.ICON_SIZE_MEDIUM,
                child: Image.asset(icon, color: index == _pageIndex ?
                Theme.of(context).primaryColor : ColorResources.HINT_TEXT_COLOR,)),
          ],
        ),
      ),
      label: label,
    );
  }
  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
