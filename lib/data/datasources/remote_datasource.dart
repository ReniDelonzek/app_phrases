import 'package:app_phrases/domain/errors/exeptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

abstract class RemoteDatasource {
  Future updateTokenByUser(String token);
}

class RemoteDatasourceImpl implements RemoteDatasource {
  @override
  Future updateTokenByUser(String token) async {
    try {
      var response = await Dio().post('http://www.google.com',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response.statusCode == 200;
    } catch (error) {
      debugPrint(error.toString());
      throw ServerException();
    }
  }
}
