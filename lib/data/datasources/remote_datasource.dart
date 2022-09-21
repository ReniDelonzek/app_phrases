import 'package:app_phrases/domain/errors/exeptions.dart';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';

abstract class RemoteDatasource {
  Future<bool> updateTokenByUser(String token);
}

class RemoteDatasourceImpl implements RemoteDatasource {
  String get url => kDebugMode
      ? 'http://localhost:5001/project-1126612155927744763/us-central1/'
      // TODO preencher com o URL do projeto
      // Ele vai estar no formato de https://us-central1-${Código do projeto}.cloudfunctions.net/

      : 'https://us-central1-project-1126612155927744763.cloudfunctions.net/';

  @override
  Future<bool> updateTokenByUser(String token) async {
    try {
      var response = await Dio().post('$url/updateUserToken',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response.statusCode == 200 && response.data['success'];
    } catch (error) {
      debugPrint(error.toString());
      throw ServerException();
    }
  }
}
