import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../constants/constants.dart';
import '../../constants/error_handlers.dart';

class RestaurantsService{
  static Future<Either<MainFailures,http.Response>> get getRestaurants async {
   try {
      final url = Uri.https(AppUrls.host, AppUrls.restaurantsEndPoint);
      final response = await client.get(url).timeout(const Duration(seconds: 10));
      return ErrorHandlers.httpHandler(response);
    } catch (exception) {
      return ErrorHandlers.exceptionHandler(exception);
    }
  }
}