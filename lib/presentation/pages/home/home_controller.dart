import 'package:app_phrases/domain/entities/phrase.dart';
import 'package:app_phrases/domain/usecases/home_usecase.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  Future<List<Phrase>> getData() {
    return HomeUsecase().getFlirts();
  }
}
