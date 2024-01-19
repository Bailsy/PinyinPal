// device_info.dart

import 'package:flutter/widgets.dart';

class DeviceInfo {
  static double get physicalHeight {
    return WidgetsBinding
        .instance.platformDispatcher.views.first.physicalSize.height;
  }

  static double get physicalWidth {
    return WidgetsBinding
        .instance.platformDispatcher.views.first.physicalSize.width;
  }

  static double get devicePixelRatio {
    return WidgetsBinding
        .instance.platformDispatcher.views.first.devicePixelRatio;
  }

  static double get height {
    return physicalHeight / devicePixelRatio;
  }

  static double get width {
    return physicalWidth / devicePixelRatio;
  }
}
