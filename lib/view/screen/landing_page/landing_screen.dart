import 'package:hr_app/view/screen/attendance/attendance_screen.dart';
import 'package:hr_app/view/screen/home/home_page_screen.dart';
import 'package:hr_app/view/screen/leave/leave_page_screen.dart';
import 'package:hr_app/view/screen/more/more_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/parse_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';


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
