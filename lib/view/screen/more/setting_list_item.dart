import 'package:flutter/material.dart';
import 'package:hr_app/view/screen/more/size_config.dart';
class SettingsListItem extends StatelessWidget {
  final String text;
  final bool arrow;
  final bool first;
  final Color color;
  final VoidCallback onTap;

  const SettingsListItem({
    required this.text,
    required this.arrow,
    required this.color,
    this.first = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16)
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !first
                ? Divider(
              thickness: 1,
              color: Theme.of(context).dividerColor,
              height: 0,
            )
                : Container(),
            SizedBox(height: 8),
            Padding(
              // padding: EdgeInsets.symmetric(
              //   horizontal: SizeConfig.blockSizeHorizontal * 6,
              // ),
              padding: EdgeInsets.only(left: 8, top: 4, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color:Colors.orangeAccent
                    ),
                  ),
                  arrow
                      ? Icon(
                    Icons.chevron_right,
                    size: SizeConfig.blockSizeHorizontal * 5,
                    color: Colors.black87,
                  )
                      : Container()
                ],
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}