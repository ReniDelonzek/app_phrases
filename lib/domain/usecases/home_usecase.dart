import 'package:app_phrases/core/di/injection_container.dart';
import 'package:app_phrases/domain/entities/phrase.dart';
import 'package:app_phrases/domain/repositories/phrase_repository.dart';

class HomeUsecase {
  final PhraseRepository repository = get.get();
  Future<List<Phrase>> getFlirts() {
    return repository.getData();
  }
}
