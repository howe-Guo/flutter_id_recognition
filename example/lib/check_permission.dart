import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_id_recognition_example/check_permission_view.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

///  Description:
///
///  @Author: G
///  @Date 2022/8/17  17:50
class CheckPermission {
  CheckPermission._();

  static VoidCallback callback = () {};

  ///检查权限
  static void checkPermission(
      {required List<Permission> permissions,
      String? errMsg,
      VoidCallback? onSuccess,
      VoidCallback? onFailed,
      VoidCallback? onOpenSetting}) async {
    bool flag = true;
    for (var value in permissions) {
      var status = await value.status;
      if (!status.isGranted) {
        flag = false;
        break;
      }
    }
    if (!flag) {
      // 权限拒绝，开始请求权限
      PermissionStatus permissionStatus = await requestPermission(permissions);
      if (permissionStatus.isGranted) {
        //权限已获得
        onSuccess != null ? onSuccess() : callback();
        SmartDialog.showToast('权限已获取');
      } else if (permissionStatus.isDenied) {
        //用户拒绝权限，需要区分IOS和Android，二者不一样
        onFailed != null ? onFailed() : callback();
        SmartDialog.showToast('用户拒绝权限');
      } else if (permissionStatus.isPermanentlyDenied) {
        //权限被用户永久拒绝，且不在提示，需要进入设置界面，IOS和Android不同
        String? content;
        if (permissions[0].value == Permission.storage.value) {
          content = '前去设置打开存储权限';
        }
        SmartDialog.show(
          builder: CheckPermissionView(
              title: '权限永久拒绝',
              content: content,
              onPressed: () {
                onOpenSetting != null ? onOpenSetting() : callback();
                SmartDialog.dismiss();
              }).build,
          alignment: Alignment.center,
        );
      } else if (permissionStatus.isRestricted) {
        //IOS单独处理
        onOpenSetting != null ? onOpenSetting() : callback();
      } else if (permissionStatus.isLimited) {
        //IOS单独处理
        onOpenSetting != null ? onOpenSetting() : callback();
      }
    } else {
      onSuccess != null ? onSuccess() : callback();
    }
    // if (Platform.isIOS) {
    // } else if (Platform.isAndroid) {
    // }
  }

  ///申请权限
  static Future<PermissionStatus> requestPermission(
      List<Permission> permissions) async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    PermissionStatus currentPermissionStatus = PermissionStatus.granted;
    statuses.forEach((key, value) {
      if (!value.isGranted) {
        currentPermissionStatus = value;
        return;
      }
    });
    return currentPermissionStatus;
  }
}
