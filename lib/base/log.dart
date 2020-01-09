
import 'package:ht_networking/ht_networking.dart';

void htNetworkingLog(String message) {
  if (!HTNetworkingConfig.instance.logEnabled) {
    return;
  }

  print("[HTNetworking] -> $message");
}