import 'package:firebase_admob/firebase_admob.dart';

class AdvertService {
  static final AdvertService _instance = AdvertService._internal();
  factory AdvertService() => _instance;
  MobileAdTargetingInfo _targetingInfo;
  final String _bannerIdAddToMain = "ca-app-pub-2763602296626502/9931889203";

  AdvertService._internal() {
    _targetingInfo = MobileAdTargetingInfo();
  }

  showAddToMainIntersitial() {
    InterstitialAd interstitialAd = InterstitialAd(
        adUnitId: _bannerIdAddToMain, targetingInfo: _targetingInfo);

    interstitialAd
      ..load()
      ..show();

    interstitialAd.dispose();
  }
}
