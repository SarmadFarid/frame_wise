// import 'dart:developer';

// import 'package:googleapis_auth/auth_io.dart';
// import 'package:logger/logger.dart';

// class ServerKeyService {
//   final logger = Logger();
//   String? serverKey;

//   /// NOTE:
//   /// This returns an OAuth access token, not the legacy "server key".
//   /// For FCM HTTP v1, you use this access token as Bearer token.
//   Future<String?> getServiceKey() async {
//     final scopes = [
//       'https://www.googleapis.com/auth/userinfo.email',
//       'https://www.googleapis.com/auth/firebase.database',
//       'https://www.googleapis.com/auth/firebase.messaging',
//     ];

//     // TODO:
//     // Paste your Firebase service account JSON here.
//     // Never commit it to git. Keep it in env/secure store in real projects.
//     final client = await clientViaServiceAccount(
//       ServiceAccountCredentials.fromJson({
//         // "type": "service_account",
//         // "project_id": "...",
//         // "private_key_id": "...",
//         // "private_key": "-----BEGIN PRIVATE KEY-----\\n...\\n-----END PRIVATE KEY-----\\n",
//         // "client_email": "...",
//         // "client_id": "...",
//         // ...
//       }),
//       scopes,
//     );

//     serverKey = client.credentials.accessToken.data;
//     log('✅ FCM Access Token: $serverKey');
//     return serverKey;
//   }
// }
