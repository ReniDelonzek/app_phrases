import 'package:app_phrases/domain/entities/phrase.dart';

abstract class PhraseRepository {
  Future<List<Phrase>> getData();
}
