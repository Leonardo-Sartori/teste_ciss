import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:teste_ciss/core/injection/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
GetIt configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @singleton
  HttpClient get http => HttpClient();

}