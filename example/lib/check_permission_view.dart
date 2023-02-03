import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';


///  Description:
///
///  @Author: G
///  @Date 2022/8/16  9:16
class CheckPermissionView {
  VoidCallback? onPressed;

  String? title;
  String? content;

  CheckPermissionView({
    this.title,
    this.content,
    this.onPressed,
  });

  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(40),
      child: Container(
        height: 203,
        padding: EdgeInsets.only(top: 30, left: 30, right: 30),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text(
              title ?? '',
              style: TextStyle(
                color: Color(0xFF7B828E),
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              content ?? '',
              style: TextStyle(
                color: Color(0xFF7B828E),
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 31.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Color(0xFFECF1F9),
                    ),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: (){SmartDialog.dismiss();},
                  child: Text(
                    '取消',
                    style: TextStyle(
                      color: Color(0xFF7B828E),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Color(0xFF3586FF),
                    ),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: onPressed,
                  child: Text(
                    '确定',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
