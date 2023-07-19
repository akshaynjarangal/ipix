import 'dart:convert';

import 'package:akshaytest/src/data/model/restaurant_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../constants/constants.dart';
import '../providers/restaurants_provider.dart';

class RestaurantRepository{
   static Future<Either<MainFailures, List<RestaurantsModel>>> get getRestaurants async {
    final res = await RestaurantsProvider.getRestaurants;
    return res.fold((failure) {
      return Left(failure);
    }, (r) async{
      final jsondata = jsonDecode(r.body)["restaurants"];
      final list = await compute(restaurantsModelFromJson,jsonEncode(jsondata));
      return Right(list);
    });
  }
}