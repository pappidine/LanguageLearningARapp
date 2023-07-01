import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';

class ARCoreService {
  static Future<bool> checkARCoreAvailability() async {
    return await ArCoreController.checkArCoreAvailability();
  }
}
