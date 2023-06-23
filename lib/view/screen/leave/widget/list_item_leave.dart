import 'package:flutter/material.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../utill/styles.dart';
class LeaveItem extends StatelessWidget {
  final String text;
  final String subText;
  final Color color;
  final int index;
  final int numberOfOrder;
  LeaveItem({required this.text,this.subText="",required this.color ,required this.index,  required this.numberOfOrder});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),),
        color: color,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
              child: Container(alignment: Alignment.center,
                child: Center(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 8,),
                      Text(text, style: robotoRegular.copyWith(color: Color(
                          0xFFE0A802),
                          fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(numberOfOrder.toString(),
                              style: robotoBold.copyWith(color: Color(0xFFFCFBFB),
                                  fontSize: 26)),
                          SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                          Text(subText, style: robotoRegular.copyWith(color: Color(
                              0xFFEAEAEA))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox.shrink(),
                //Spacer(),
                Container(width: MediaQuery.of(context).size.width/8,
                  height:MediaQuery.of(context).size.width/8,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(.10),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(100), topLeft: Radius.circular(16))
                  ),),
                Spacer(),
                //SizedBox.shrink(),
              ],
            )


          ],
        ),
      ),
    );
  }
}
