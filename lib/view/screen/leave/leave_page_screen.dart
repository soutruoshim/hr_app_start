import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hr_app/utill/color_resources.dart';
import 'package:hr_app/view/screen/leave/widget/list_item_leave.dart';
import 'package:hr_app/view/screen/leave/widget/on_going_order_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../provider/report_parse_provider.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../home/widget/order_type_button_head.dart';

class LeavePageScreen extends StatefulWidget {
  const LeavePageScreen({Key? key}) : super(key: key);

  @override
  State<LeavePageScreen> createState() => _LeavePageScreenState();
}

class _LeavePageScreenState extends State<LeavePageScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onRefresh();
    _tabController = TabController(length: 2, vsync: this);
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
            child: Padding(padding: Device.get().isTablet
              ? EdgeInsets.only(
                  right: MediaQuery.of(context).size.height / 6,
                  left: MediaQuery.of(context).size.height / 6,
                  top: 8,
                  bottom: 8)
              : EdgeInsets.only(right: 4, left: 4, top: 4, bottom: 4),
            child:

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              SizedBox(height: Dimensions.PADDING_SIZE),
             Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Container(
                      margin: EdgeInsets.only(right: 18, left: 18),
                      child: Text(
                        "Request",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorResources.WHITE
                        ),
                      ),
              )),

            OngoingOrderWidget(),
            //SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Container(
                      margin: EdgeInsets.only(right: 18, left: 18),
                      child: Text(
                        "Leave",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorResources.WHITE
                        ),
                      ),
                    )),
          ]
            ),
        )),

        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 350.0,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 2.0,
          ),
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(

                    margin: index % 2 == 0 ? EdgeInsets.only(left: 16):EdgeInsets.only(right: 16),
                    child: LeaveItem(
                      //color: Color(0xFF7C5D00),
                      color:Colors.blueGrey,
                      text: "Holidays",
                      index: 2,
                      subText: "",
                      numberOfOrder: Provider.of<ReportParseProvider>(context, listen: false).getTotalPending,
                    ),
                  );

            },
            childCount: 10,
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
              _tabSection(context),
            ])),
      ]),
    );
  }

  Widget _tabSection(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    double mainAxisHeight = height > width ? height : width;
    return DefaultTabController(
        length: 2,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Container(
          height: 48,
          margin: EdgeInsets.only(right: 20, left: 20, top: 8),
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10))),
          child: TabBar(
              indicatorColor: Colors.white,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                insets: EdgeInsets.symmetric(horizontal: 40),
              ),
              labelColor: Color(
                  0xFFE0A802),
              unselectedLabelColor: Colors.grey[300],
              tabs: [
                Tab(
                  iconMargin: EdgeInsets.only(top: 5),
                  text: "This Month",
                ),
                Tab(
                  iconMargin: EdgeInsets.only(top: 5),
                  text: "This Year",
                ),
              ]),
        ),

        Container(
            margin: EdgeInsets.only(right: 20, left: 20),
            height: 200,
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  child:  DataTable(
                        columns: [
                            DataColumn(label: Text(
                            'ID',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorResources.WHITE)
                        )),
                      DataColumn(label: Text(
                          'Name',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorResources.WHITE)
                      )),
                      DataColumn(label: Text(
                          'Profession',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorResources.WHITE)
                      )),
                    ],
                    rows: [
                    DataRow(cells: [
                      DataCell(Text('1', style: TextStyle(color: ColorResources.WHITE),)),
                      DataCell(Text('Stephen',style: TextStyle(color: ColorResources.WHITE),)),
                      DataCell(Text('Actor',style: TextStyle(color: ColorResources.WHITE),)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('5',style: TextStyle(color: ColorResources.WHITE),)),
                      DataCell(Text('John',style: TextStyle(color: ColorResources.WHITE),)),
                      DataCell(Text('Student',style: TextStyle(color: ColorResources.WHITE),)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('10',style: TextStyle(color: ColorResources.WHITE),)),
                      DataCell(Text('Harry',style: TextStyle(color: ColorResources.WHITE),)),
                      DataCell(Text('Leader',style: TextStyle(color: ColorResources.WHITE),)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('15',style: TextStyle(color: ColorResources.WHITE),)),
                      DataCell(Text('Peter',style: TextStyle(color: ColorResources.WHITE),)),
                      DataCell(Text('Scientist',style: TextStyle(color: ColorResources.WHITE),)),
                    ]),
                  ],
                 )
                ),
                Icon(Icons.directions_transit, size: 350)
              ],
            ))
    ]));
  }
}
