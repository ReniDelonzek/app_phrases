import 'package:app_phrases/data/datasources/auth_datasource.dart';
import 'package:app_phrases/data/datasources/phrase_datasource.dart';
import 'package:app_phrases/data/datasources/remote_datasource.dart';
import 'package:app_phrases/data/repositories/auth_repository_impl.dart';
import 'package:app_phrases/data/repositories/phrase_repository_impl.dart';
import 'package:app_phrases/domain/repositories/auth_repository.dart';
import 'package:app_phrases/domain/repositories/phrase_repository.dart';
import 'package:get_it/get_it.dart';

final get = GetIt.instance;

void initDependencies() {
  get.registerSingleton<PhraseDataSource>(PhraseDataSourceImpl());
  get.registerSingleton<PhraseRepository>(
      PhraseRepositoryImpl(dataSource: get.get()));
  get.registerSingleton<RemoteDatasource>(RemoteDatasourceImpl());
  get.registerSingleton<AuthDatasource>(AuthDatasourceFirebase());
  get.registerSingleton<AuthRepository>(AuthRepositoryImpl(
      authDatasource: get.get(), remoteDatasource: get.get()));
}
