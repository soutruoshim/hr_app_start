import 'package:hr_app/helper/check_device.dart';
import 'package:hr_app/provider/report_parse_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:provider/provider.dart';
import '../../../../utill/dimensions.dart';
import 'order_type_button_head.dart';

class OngoingOrderWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      // decoration: BoxDecoration(
      //   color: Theme.of(context).cardColor,
      //   boxShadow: [
      //     BoxShadow(color: Color(0xFFFFAA47),
      //         spreadRadius: -3, blurRadius: 4, offset: Offset.fromDirection(0,6))],
      // ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

        Padding(
          padding: const EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_SMALL,0, Dimensions.PADDING_SIZE_SMALL,Dimensions.FONT_SIZE_SMALL),
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: Device.get().isTablet ? 3: 2,
            childAspectRatio: Device.get().isTablet ? (2/ 1): (1/0.67),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              OrderTypeButtonHead(
                color: Color(0xFF0F6E54),
                text: "Issue Leave", index: 1,
                subText: "",
                numberOfOrder: Provider.of<ReportParseProvider>(context, listen: false).getTotalPending,
              ),

              OrderTypeButtonHead(
                color: Color(0xFF7C5D00),
                text: "Early Leave", index: 2,
                subText: "",
                numberOfOrder: Provider.of<ReportParseProvider>(context, listen: false).getTotalPending,

              )
            ],
          ),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
      ],),);
  }
}
