// lib/core/network/interceptors.dart
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../config/environment.dart';
import 'dart:convert';

final authTokensProvider = StateProvider<_Tokens?>((_) => null);

class _Tokens { _Tokens(this.access, this.refresh); final String access; final String refresh; }

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.ref);
  final Ref ref;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final tokens = ref.read(authTokensProvider);
    if (tokens != null) {
      options.headers['Authorization'] = 'Bearer ${tokens.access}';
    } else {
      final env = ref.read(environmentProvider);
      final user = env.basicUser;
      final pass = env.basicPassword;
      if (user != null && pass != null) {
        final creds = '$user:$pass';
        final basic = 'Basic ${base64Encode(creds.codeUnits)}';
        options.headers['Authorization'] = basic;
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // TODO: refresh token flow
    }
    super.onError(err, handler);
  }
}
