import 'package:get_it/get_it.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/card_repository.dart';
import 'data/repositories/contact_repository.dart';
import 'data/repositories/dynamic_link_repository.dart';
import 'data/repositories/storage_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupInjection() async {
  _injectRepositories();
}

void _injectRepositories() {
  getIt.registerSingleton<AuthRepository>(AuthRepository());
  getIt.registerSingleton<CardRepository>(CardRepository());
  getIt.registerSingleton<ContactRepository>(ContactRepository());
  getIt.registerSingleton<DynamicLinkRepository>(DynamicLinkRepository());
  getIt.registerSingleton<StorageRepository>(StorageRepository());
}
