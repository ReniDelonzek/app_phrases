import 'package:app_phrases/data/models/flirt_model.dart';

abstract class PhraseDataSource {
  Future<List<PhraseModel>> getData();
}

class PhraseDataSourceImpl implements PhraseDataSource {
  @override
  Future<List<PhraseModel>> getData() async {
    return [
      PhraseModel(id: 1, flirt: 'Teste 1'),
      PhraseModel(id: 1, flirt: 'Teste 2')
    ];
  }
}
