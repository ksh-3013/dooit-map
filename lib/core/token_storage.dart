// import 'package:shared_preferences/shared_preferences.dart';
//
// abstract interface class TokenStorage {
//   Future<void> save({
//     required String accessToken,
//     required String refreshToken,
//     required String email,
//   });
//
//   String? get accessToken;
//
//   String? get refreshToken;
//
//   String? get email;
// }
//
// class SharedPrefsTokenStorage implements TokenStorage {
//   SharedPrefsTokenStorage(this._prefs);
//
//   final SharedPreferences _prefs;
//   static const _kAccess = 'accessToken';
//   static const _kRefresh = 'refreshToken';
//   static const _kEmail = 'email';
//
//   @override
//   Future<void> save({
//     required String accessToken,
//     required String refreshToken,
//     required String email,
//   }) async {
//     await Future.wait([
//       _prefs.setString(_kAccess, accessToken),
//       _prefs.setString(_kRefresh, refreshToken),
//       _prefs.setString(_kEmail, email),
//     ]);
//   }
//
//   @override
//   String? get accessToken => _prefs.getString(_kAccess);
//
//   @override
//   String? get refreshToken => _prefs.getString(_kRefresh);
//
//   @override
//   String? get email => _prefs.getString(_kEmail);
// }
