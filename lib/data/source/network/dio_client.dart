import 'dart:convert';
import 'dart:io';
import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:path_provider/path_provider.dart';

import '../../../config/logger.dart';
import '../../../config/string.dart';
import 'api_result_handler.dart';

class DioClient {
  late Dio dio;

  DioClient({String baseUrl = "", bool verify = true}) {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 60),
    );
    dio = Dio(baseOptions);
    if (!verify) {
      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          HttpClient client = HttpClient();
          client.badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);
          return client;
        },
      );
    }


  }

  Future<ApiResults?> getData(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
      // bool validateToken = true,
      String? bypass,
      String? token,
      String contentType = Headers.jsonContentType,
      Options? options}) async {
    Map<String, dynamic> header = {
      'Content-Type': contentType,
      'bypass': bypass,
      "X-Subject-Token": token,
    };
    // if (validateToken) {
    //   header['Authorization'] =
    //       'Bearer ${await SecureStorageService().readSecureData(keyJWTToken)}';
    // }
    dio.options.headers = header;

      try {
        logger(
            'URL=${dio.options.baseUrl + endPoint + queryParameters.toString()}');

        var response = await dio.get(endPoint,
            queryParameters: queryParameters, options: options);
        logger('Response=${response.data}');
        if (response.statusCode == 200) {
          return ApiResults(
              response.data, response.statusCode, response.statusMessage);
        } else {
          log("${response.statusMessage ?? "no message"} endpoint $endPoint");

          return ApiResults(response.data, 0, response.statusMessage);
        }
      } on SocketException {
        return ApiResults("", 0, "");
      } on DioException catch (e) {
        log("Dio Exception : ${e.message} $endPoint");

        return getErrorResponse(e, "");
      } catch (e) {
        log("Exception : ${e.toString()}   endpoint $endPoint");

        return ApiResults("data", 0, "strAppSomethingWentWrong");
      }

  }

  Future<ApiResults?> postData(
      {required String endPoint,
      Object? data,
      Map<String, dynamic>? queryParameters,
      bool validateToken = true,
      String? bypass,
      String? token,
      String contentType = Headers.formUrlEncodedContentType,
      ProgressCallback? uploadProgress}) async {
    Map<String, dynamic> header = {
      'Content-Type': contentType,
      'bypass': bypass,
      "X-Subject-Token": token,
    };
    // if (validateToken) {
    //   header['Authorization'] =
    //       'Bearer ${await SecureStorageService().readSecureData(keyJWTToken)}';
    // }
    dio.options.headers = header;

      try {
        logger('URL=${dio.options.baseUrl + endPoint}');
        logger('Posting data=$data');
        logger('query param data=$queryParameters');
        var response = await dio.post(endPoint,
            data: data,
            queryParameters: queryParameters,
            onSendProgress: uploadProgress);
        logger(
            'URL=$endPoint statusCode=${response.statusCode} and Response=${response.data}');
        if (response.statusCode == 200 || response.statusCode == 202) {
          return ApiResults(
              response.data, response.statusCode, response.statusMessage);
        } else {
          log("${response.statusMessage ?? "no message"}  endpoint $endPoint");


          return ApiResults(
              response.data, response.statusCode, response.statusMessage);
        }
      } on SocketException {
        return ApiResults("", 0, "");
      } on DioException catch (e) {
        logger('${e.response?.statusCode} = ${e.response?.statusMessage}');
        if (e.response?.statusCode == 999 || e.response?.statusCode == 998) {
          return ApiResults(e.response?.data, e.response?.statusCode,
              e.response?.statusMessage);
        } else {
          logger("Dio Exception : ${e.message} $endPoint");

          return getErrorResponse(e, "");
        }
      } catch (e) {
        log("Exception : ${e.toString()}  $endPoint");


        return ApiResults(data, 0, "strAppSomethingWentWrong");
      }

  }

  Future<ApiResults?> downloadData({
    required String endPoint,
    String? fileName,
    String? filePath,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool validateToken = true,
    String? bypass,
    String contentType = Headers.formUrlEncodedContentType,
  }) async {
    Map<String, dynamic> header = {
      'Content-Type': contentType,
      'bypass': bypass,
    };

    dio.options.headers = header;

    String dir = (await getApplicationCacheDirectory()).path;
    String savePath = '$dir/$fileName';
    File file = File(savePath);
    if (await file.exists() && await file.length() > 0) {
      return ApiResults(savePath, 200, "ImageExist");
    } else {

        try {
          logger('URL=${dio.options.baseUrl + endPoint}');
          logger('Posting data=$data');
          logger('query param data=$queryParameters');

          var response = await dio.post(endPoint,
              data: data,
              queryParameters: queryParameters,
              options: Options(
                  responseType: ResponseType.bytes, contentType: contentType));

          logger('Response=${response.data}');
          if (response.statusCode == 200) {
            File file = File(savePath);
            var raf = file.openSync(mode: FileMode.write);
            raf.writeFromSync(response.data);
            await raf.close();
            return ApiResults(
                savePath, response.statusCode, response.statusMessage);
          } else {


            print("error no meesage  ${response.statusMessage??"no message"} endpoint $endPoint");
            return ApiResults(response.data, 0, response.statusMessage);
          }
        } on SocketException {
          return ApiResults("", 0, "");
        } on DioException catch (e) {
          print("Dio Exception : ${e.message}  $endPoint");


          return ApiResults(data, 0, e.message);
        } catch (e) {
          print("Exception ${e.toString()} endpoint is $endPoint");


          return ApiResults(data, 0, "strAppSomethingWentWrong");
        }

    }
  }

  Future<ApiResults?> getFirDownloaded(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
      String? token,
      Object? data,
      String? firnumber,
      bool validateToken = true,
      String? bypass,
      String contentType = Headers.jsonContentType}) async {
    Map<String, dynamic> header = {
      'Content-Type': contentType,
      'bypass': bypass,
    };

    dio.options.headers = header;
    dio.options.responseType = ResponseType.bytes;
    try {
      final response = await dio.post(
        endPoint,
        data: data,
        queryParameters: queryParameters,
      );
      print(response.statusCode);

      Directory tempDir = await getTemporaryDirectory();

      File file = File('${tempDir.path}/FIR$firnumber.pdf');
      String tempPath = file.path;
      file.writeAsBytes(response.data);

      return ApiResults(tempPath, 200, "");
    } on SocketException {
      return ApiResults("", 0, "");
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return ApiResults("data", 404, "FIR data not found");
      } else {
        if (e.response?.data != null) {
          String string = String.fromCharCodes(e.response?.data);
          if (string.isNotEmpty) {
            return getErrorResponse(e, jsonDecode(string));
          } else {
            return getErrorResponse(e, e.response?.data);
          }
        } else {
          return ApiResults("data", 1, e.message);
        }
      }
    } catch (e) {
      return ApiResults("data", 0, 'app_something_went_wrong');
    }
  }


}

ApiResults getErrorResponse(DioException exception, dynamic data) {
  logger('Error code- ${exception.response?.statusCode}');
  switch (exception.type) {
    case DioExceptionType.connectionTimeout:
      return ApiResults(
          data, exception.response?.statusCode, "strAppConnectionTimeout");

    case DioExceptionType.receiveTimeout:
      return ApiResults(
          data, exception.response?.statusCode, "strAppRequestTimeout");

    case DioExceptionType.badCertificate:
      return ApiResults(data, exception.response?.statusCode,
          'सर्टिफिकेट एरर - ${"strAppSomethingWentWrong"}');

    case DioExceptionType.badResponse:
      return ApiResults(
          data, exception.response?.statusCode, "strAppSomethingWentWrong");

    case DioExceptionType.cancel:
      return ApiResults(
          data, exception.response?.statusCode, "strAppConnectionCancelled");

    case DioExceptionType.connectionError:
      return ApiResults(
          data, exception.response?.statusCode, "strAppSomethingWentWrong");

    case DioExceptionType.unknown:
      if (exception.error != null) {
        return ApiResults(
            data, exception.response?.statusCode, "strAppSomethingWentWrong");
      }
      return ApiResults(data, exception.response?.statusCode, "strAppNoInternet");

    case DioExceptionType.sendTimeout:
      return ApiResults(
          data, exception.response?.statusCode, "strAppSomethingWentWrong");
  }
}

// Future<String> refreshToken() async {
//   logger('access token expired refreshing ....');
//   BaseOptions baseOptions = BaseOptions(
//       baseUrl: EnvHelper().getBaseUrlV2(),
//       receiveDataWhenStatusError: false,
//       connectTimeout: const Duration(seconds: 60),
//       receiveTimeout: const Duration(seconds: 60),
//       headers: {'Content-Type': Headers.jsonContentType});
//   var dioClient = Dio(baseOptions);
//   logger(jsonEncode(
//       {'token': await SecureStorageService().readSecureData(keyRefreshToken)}));
//   var data = {
//     'var': encryptAES(
//         keyToEnc: key4,
//         jsonEncode({
//           'token': await SecureStorageService().readSecureData(keyRefreshToken)
//         }))
//   };
//   try {
//     Response response = await dioClient.post(
//       'psa-auth/getRefreshToken',
//       data: data,
//     );
//     // logger(response.data);
//     Map dataResponse = response.data;
//     if (response.statusCode == 200 && dataResponse['status'] == '200') {
//       var resp = jsonDecode(decryptAES(keyToDcrpt: key4, dataResponse['data']));
//       // logger(resp);
//       //save access token and refresh token
//       SecureStorageService().writeSecureData(keyJWTToken, resp['accessToken']);
//       SecureStorageService()
//           .writeSecureData(keyRefreshToken, resp['refreshToken']);
//       return Future.value(resp['accessToken']);
//     } else {
//       return Future.value('');
//     }
//   } on DioException catch (e) {
//     if (e.response?.statusCode == 401) {
//       // pin validation
//       logger('sending user to pin validation ...');
//       moveToPinValidation(NavigationUtil().getNavigationContext());
//     }
//     print(e.message);
//   }
//   return Future.value('');
// }
