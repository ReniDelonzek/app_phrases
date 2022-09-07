import 'package:app_phrases/data/datasources/phrase_datasource.dart';
import 'package:app_phrases/domain/entities/phrase.dart';
import 'package:app_phrases/domain/repositories/phrase_repository.dart';

class PhraseRepositoryImpl implements PhraseRepository {
  final PhraseDataSource dataSource;
  PhraseRepositoryImpl({
    required this.dataSource,
  });
  @override
  Future<List<Phrase>> getData() {
    return dataSource.getData();
  }
}
