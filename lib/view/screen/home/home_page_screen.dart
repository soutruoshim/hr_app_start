import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:hr_app/utill/color_resources.dart';
import 'package:hr_app/view/screen/home/widget/on_going_order_widget.dart';
import 'package:intl/intl.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onRefresh();
  }

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return RefreshIndicator(
      onRefresh: () => _onRefresh(),
      child: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: ColorResources.MAIN_COLOR,
          title: Image.asset(Images.logo_with_app_name, height: 35),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: Device.get().isTablet
              ? EdgeInsets.only(
                  right: MediaQuery.of(context).size.height / 6,
                  left: MediaQuery.of(context).size.height / 6,
                  top: 8,
                  bottom: 8)
              : EdgeInsets.only(right: 4, left: 4, top: 4, bottom: 4),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(height: Dimensions.PADDING_SIZE),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                "19:00 25 AM",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: ColorResources.WHITE),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                formattedDate,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: ColorResources.WHITE
                ),
              ),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE),
            new Center(
              child: new GestureDetector(
                // this is the one you are looking for..........
                onTap: () => {},
                child: new Container(
                  padding: const EdgeInsets.all(20.0),
                  //I used some padding without fixed width and height
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    // You can use like this way or like the below line
                    //borderRadius: new BorderRadius.circular(30.0),
                    color: Colors.green,
                  ),
                  child: Icon(
                    Icons.fingerprint,
                    size: 120.0,
                    color: Colors.brown[900],
                  ), // You can add a Icon instead of text also, like below.
                  //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                ), //............
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                "Check in | Check out",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                    color: ColorResources.WHITE
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.all(16),
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  // You can use like this way or like the below line
                  borderRadius: new BorderRadius.circular(20.0),
                  color: Colors.blueGrey,
                ),
                child: Text(
                  "2h 15mn",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                      color: ColorResources.WHITE
                  ),
                ), // You can add a Icon instead of text also, like below.
                //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 0),
                child: Container(
                  margin: EdgeInsets.only(right: 18, left: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "2h 15mn",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                            color: ColorResources.WHITE
                        ),
                      ),
                      Text(
                        "2h 15mn",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                            color: ColorResources.WHITE
                        ),
                      ),
                    ],
                  ),
                )),
                SizedBox(height: Dimensions.PADDING_SIZE),
                Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Container(
                      margin: EdgeInsets.only(right: 18, left: 18),
                      child: Text(
                        "Overview",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorResources.WHITE
                        ),
                      ),
                    )),
            OngoingOrderWidget(),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          ]),
        )),
      ]),
    );
  }
}
