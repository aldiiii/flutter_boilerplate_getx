import 'package:firebase_core/firebase_core.dart';
import 'package:starter_kit_app/constants/app_theme.dart';
import 'package:starter_kit_app/constants/routers.dart';
import 'package:starter_kit_app/controllers/language_controller.dart';
import 'package:starter_kit_app/utils/services/local_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:starter_kit_app/localizations.dart';
import 'package:starter_kit_app/routes/bindings/initial_binding.dart';
import 'package:starter_kit_app/routes/pages.dart';
import 'package:starter_kit_app/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.lazyPut<LocalStorage>(() => LocalStorageImpl());
  Get.put<LanguageController>(LanguageController(Get.find<LocalStorage>()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
        builder: (languageController) => Loading(
              child: GetMaterialApp(
                smartManagement: SmartManagement.full,
                initialBinding: InitialBinding(),
                debugShowCheckedModeBanner: false,
                title: 'Daytech',
                //begin language translation stuff //https://github.com/aloisdeniel/flutter_sheet_localization
                locale: languageController.getLocale, // <- Current locale
                localizationsDelegates: [
                  const AppLocalizationsDelegate(), // <- Your custom delegate
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.languages.keys
                    .toList(), // <- Supported locales
                //end language translation stuff
                //end language translation stuff
                initialRoute: Routers.home,
                getPages: Pages.getPages,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                themeMode: ThemeMode.light,
              ),
            ));
  }
}
