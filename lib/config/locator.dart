import 'package:get_it/get_it.dart';
import 'package:myxpenses/app/app_navigator.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AppNavigator>(AppNavigator());
}
