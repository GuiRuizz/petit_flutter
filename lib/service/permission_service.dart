import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static final permissions = [
    Permission.camera,
    Permission.photos,
    Permission.notification,
    Permission.microphone,
  ];

  static Future<bool> requestAll() async {
    final result = await permissions.request();

    return result.values.every((status) => status.isGranted);
  }

  static Future<bool> hasPermanentlyDenied() async {
    for (final permission in permissions) {
      if (await permission.isPermanentlyDenied) {
        return true;
      }
    }

    return false;
  }
}