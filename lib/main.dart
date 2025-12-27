import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/routes/routes.dart';
import 'package:two_m_production/core/utils/theme.dart';
import 'package:two_m_production/core/bloc/theme_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  //Future.value([await Dio_Provider.intit(), await Local_helper.init()]);
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      startLocale: Locale('en'),
      child: const MainApp(),
    ),
  );
}

/*Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MainApp(), // Wrap your app
  ),
);
}*/
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.setLocale(Locale('en'));
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeManager.themeMode,
      builder: (context, themeMode, _) {
        return ScreenUtilInit(
          designSize: const Size(360, 760),
          minTextAdapt: true,
          splitScreenMode: true,
          child: MaterialApp.router(
            // locale: context.locale,
            routerConfig: Routes.routes,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
          ),
        );
      },
    );
  }
}
