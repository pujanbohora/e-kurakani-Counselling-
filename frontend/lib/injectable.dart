// Package imports:
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'injectable.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection() async{
 await $initGetIt(getIt);
}
