import 'package:firebase_admob/firebase_admob.dart';

class AdvertService {
  static final AdvertService _instance = AdvertService._internal();
  factory AdvertService() => _instance;
  MobileAdTargetingInfo _targetingInfo;

  AdvertService._internal() {
    _targetingInfo = MobileAdTargetingInfo();
  }

  showIntersitial() {
    InterstitialAd interstitialAd = InterstitialAd(
        adUnitId: InterstitialAd.testAdUnitId, targetingInfo: _targetingInfo);

    interstitialAd
      ..load()
      ..show();

    interstitialAd.dispose();
  }
}
