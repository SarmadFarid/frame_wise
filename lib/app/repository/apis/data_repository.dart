// import '../../config/app_urls.dart';
// import '../../mvvm/model/api_response_model/api_response.dart';
// import '../../mvvm/model/body_model/add_car_body_model.dart';
// import '../../mvvm/model/body_model/buy_car_request_model.dart';
// import '../../services/api_response_handler.dart';
// import '../../services/https_calls.dart';
// import '../../services/logger_service.dart';

// class DataRepository {
//   final HttpsCalls _httpsCalls = HttpsCalls();

//   // ================= ADD CAR =================

//   Future<ApiResponse<void>> addCarApi(AddCarBodyModel body) async {
//     try {
//       const endPoint = AppUrls.signup; // TODO: replace endpoint
//       LoggerService.d('Add car → $endPoint');
//       final response =
//           await _httpsCalls.crudCarMultipartApi(endPoint, body);
//       return ApiResponseHandler.process(response, endPoint, (_) {});
//     } catch (e, st) {
//       ApiResponseHandler.logUnhandledError(e, st);
//       rethrow;
//     }
//   }

//   // ================= BUY CAR =================

//   Future<ApiResponse<void>> buyCarApi(BuyCarRequestModel body) async {
//     try {
//       const endPoint = AppUrls.signup; // TODO: replace endpoint
//       LoggerService.d('Buy car → $endPoint');
//       final response =
//           await _httpsCalls.multipartBuyCarRequestApi(endPoint, body);
//       return ApiResponseHandler.process(response, endPoint, (_) {});
//     } catch (e, st) {
//       ApiResponseHandler.logUnhandledError(e, st);
//       rethrow;
//     }
//   }
// }
