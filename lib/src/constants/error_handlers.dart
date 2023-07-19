import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';


class ErrorHandlers {
  /*
 ------------------------- HTTP RESPONSE HANDLER -----------------------
*/
  static Either<MainFailures, http.Response> httpHandler(
      http.Response response) {
        log(response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        return Right(response);
      case 204:
        return const Left(MainFailures.noContentFailure);
      case 401:
        return const Left(MainFailures.unAuthorized);
      case 406:
        return const Left(MainFailures.notAcceptable);
      case 422:
        return const Left(MainFailures.unprocessable);
      default:
        return const Left(MainFailures.serverFailure);
    }
  }

/*
 ------------------------- HTTP EXCEPTION HANDLER -----------------------
*/
  static Either<MainFailures, http.Response> exceptionHandler(
      Object exception) {
    log("EX===>:$exception");
    switch (exception) {
      case TimeoutException : return const Left(MainFailures.noInternetFailure);
      case SocketException:
        return const Left(MainFailures.noInternetFailure);
      case FormatException:
        return const Left(MainFailures.formatExceptionFailure);
      default:
        return const Left(MainFailures.serverFailure);
    }
  }
}
