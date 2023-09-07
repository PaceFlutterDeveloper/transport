import 'package:geolocator/geolocator.dart';

getPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  // if (defaultTargetPlatform == TargetPlatform.android) {
  //   locationSettings = AndroidSettings(
  //     accuracy: LocationAccuracy.high,
  //     distanceFilter: 100,
  //     forceLocationManager: true,
  //     intervalDuration: const Duration(seconds: 10),
  //     //(Optional) Set foreground notification config to keep the app alive
  //     //when going to the background
  //   );
  // } else if (defaultTargetPlatform == TargetPlatform.iOS ||
  //     defaultTargetPlatform == TargetPlatform.macOS) {
  //   locationSettings = AppleSettings(
  //     accuracy: LocationAccuracy.high,
  //     activityType: ActivityType.fitness,
  //     distanceFilter: 100,
  //     pauseLocationUpdatesAutomatically: true,
  //     // Only set to true if our app will be started up in the background.
  //     showBackgroundLocationIndicator: false,
  //   );
  // } else {
  //   locationSettings = LocationSettings(
  //     accuracy: LocationAccuracy.high,
  //     distanceFilter: 100,
  //   );
  // }
}
