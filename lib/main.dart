import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/GetIt/gi.dart';
import 'package:two_m_production/core/routes/routes.dart';
import 'package:two_m_production/core/services/cache/LocalHelper.dart';
import 'package:two_m_production/core/utils/theme.dart';
import 'package:two_m_production/core/bloc/theme_manager.dart';
import 'package:two_m_production/firebase_options.dart';
import 'package:two_m_production/features/pages/Setting/Domain/UseCase/updateLastConnectionUseCase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Future.value([
    await EasyLocalization.ensureInitialized(),
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    await setupServiceLocator(),
    await Localhelper.init(),
  ]);

  // Update last connection in Firestore (fire and forget)
  gi<UpdateLastConnectionUseCase>().call();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      startLocale: Locale('en'),
      child: MainApp(),
    ),
  );
}

//  child: DevicePreview(enabled: !kReleaseMode,builder:  (context) => MainApp()),
class MainApp extends StatelessWidget {
  const MainApp({super.key});
  //!mnhgfd
  @override
  Widget build(BuildContext context) {
    //context.setLocale(Locale('en'));
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeManager.themeMode,
      builder: (context, themeMode, _) {
        return ScreenUtilInit(
          designSize: const Size(360, 760),
          minTextAdapt: true,
          splitScreenMode: true,
          child: MaterialApp.router(
            locale: context.locale,
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
