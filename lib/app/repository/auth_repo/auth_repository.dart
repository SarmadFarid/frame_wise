// import '../../mvvm/model/body_model/driver_signup_body_model.dart';
// import '../../mvvm/model/body_model/garage_signup_body_model.dart';
// import '../../services/https_calls.dart';

class AuthRepository {
  // final HttpsCalls _httpsCalls = HttpsCalls();

  // ================= DRIVER =================

  // Future<ApiResponse<void>> driverSignUpApi(
  //     DriverSignupBodyModel body) async {
  //   try {
  //     const endPoint = AppUrls.signup;
  //     LoggerService.d('Driver signup → $endPoint');
  //     final response =
  //         await _httpsCalls.multipartDriverProfileApiHits(endPoint, body);
  //     return ApiResponseHandler.process(response, endPoint, (_) {});
  //   } catch (e, st) {
  //     ApiResponseHandler.logUnhandledError(e, st);
  //     rethrow;
  //   }
  // }

  // Future<ApiResponse<void>> updateDriver(
  //     DriverSignupBodyModel body) async {
  //   try {
  //     const endPoint = AppUrls.updateAccount;
  //     LoggerService.d('Driver update → $endPoint');
  //     final response =
  //         await _httpsCalls.multipartDriverProfileApiHits(endPoint, body);
  //     return ApiResponseHandler.process(response, endPoint, (_) {});
  //   } catch (e, st) {
  //     ApiResponseHandler.logUnhandledError(e, st);
  //     rethrow;
  //   }
  // }

  // ================= GARAGE =================

  // Future<ApiResponse<void>> garageSignUpApi(
  //     GarageSignupBodyModel body) async {
  //   try {
  //     const endPoint = AppUrls.signup;
  //     LoggerService.d('Garage signup → $endPoint');
  //     final response =
  //         await _httpsCalls.multipartGarageProfileApiHits(endPoint, body);
  //     return ApiResponseHandler.process(response, endPoint, (_) {});
  //   } catch (e, st) {
  //     ApiResponseHandler.logUnhandledError(e, st);
  //     rethrow;
  //   }
  // }
}
