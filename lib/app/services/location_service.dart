// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'logger_service.dart';

// class LocationService {
//   Future<Position> getCurrentLocation() async {
//     final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!isServiceEnabled) {
//       LoggerService.w('Location services are disabled');
//       await Geolocator.openLocationSettings();
//       throw Exception('Location services are disabled.');
//     }

//     var permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw Exception('Location permission denied.');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       await openAppSettings();
//       throw Exception('Location permission denied forever.');
//     }

//     return Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//   }
// }
