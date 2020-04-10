

import 'config.dart';

void footstoneLog(String message) {
  if (!HTNetworkingConfig.instance.logEnabled) {
    return;
  }

  print("[HTNetworking] -> $message");
}