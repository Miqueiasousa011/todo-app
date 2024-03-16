import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

const devUrl = 'http://192.168.3.6:8080';

Dio customDio = Dio(
  BaseOptions(
    baseUrl: devUrl,
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  ),
)..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        log('${options.path} - ${options.data}');
        String? token;
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ),
  );
