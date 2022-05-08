import 'package:get_it/get_it.dart';
import 'package:marketing_admin_panel/repositories/admin/admin_repo.dart';
import 'package:marketing_admin_panel/repositories/bills/bills_repo.dart';
import 'package:marketing_admin_panel/repositories/categories/category_repository.dart';
import 'package:marketing_admin_panel/repositories/currencies/currencies_repo.dart';
import 'package:marketing_admin_panel/repositories/offers/offers_repo.dart';
import 'package:marketing_admin_panel/repositories/packages/packages_repository.dart';
import 'package:marketing_admin_panel/repositories/stories/stories_repository.dart';
import 'package:marketing_admin_panel/repositories/users/user_repo.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<CategoriesRepo>(() => CategoriesRepo());
  locator.registerLazySingleton<UserRepo>(() => UserRepo());
  locator.registerLazySingleton<OffersRepo>(() => OffersRepo());
  locator.registerLazySingleton<AdminRepo>(() => AdminRepo());
  locator.registerLazySingleton<CurrenciesRepo>(() => CurrenciesRepo());
  locator.registerLazySingleton<BillsRepo>(() => BillsRepo());
  locator.registerLazySingleton<PackagesRepository>(() => PackagesRepository());
  locator.registerLazySingleton<StoriesRepository>(() => StoriesRepository());
}
