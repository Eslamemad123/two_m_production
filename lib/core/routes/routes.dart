import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:two_m_production/features/pages/Auth/login/Presentation/cubit/auth_cubit.dart';
import 'package:two_m_production/features/pages/Auth/login/Presentation/page/loginScreen.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/Main/page/NavBar.dart';
import 'package:two_m_production/features/pages/ProductDetails/pages/product_details_screen.dart';
import 'package:two_m_production/features/pages/ProductDetails/widget/viewImage.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/cubit/settingCubit.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/pages/appProductPage/add_product_screen.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/pages/editProfilePage/edit_profile_screen.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/pages/injuctionPage/select_size_screen.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/pages/injuctionPage/counting_session_screen.dart';
import 'package:two_m_production/features/pages/intro/splash/page/lockScreen.dart';
import 'package:two_m_production/features/pages/intro/splash/page/splashScreen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String splash = '/';
  static const String main = '/main';
  static const String login = '/login';
  static const String home = '/home';
  static const String productDetails = '/details';
  static const String editProfile = '/edit_profile';
  static const String orderHistory = '/order_history';
  static const String profits = '/profits';
  static const String setting = '/setting';
  static const String addProduct = '/addProduct';
  static const String sale = '/sale';
  static const String addStock = '/addStock';
  static const String notifiction = '/notifiction';
  static const String viewImage = '/imageview';
  static const String appLock = '/lock';
  static const String selectSize = '/selectSize';
  static const String countingSession = '/countingSession';

  static final routes = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(path: appLock, builder: (context, state) => AppLockScreen()),
      GoRoute(
        path: viewImage,
        builder: (context, state) => ViewImage(image: state.extra as String),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: LoginScreen(),
        ),
      ),
      GoRoute(path: main, builder: (context, state) => const NavBar()),
      GoRoute(
        path: productDetails,
        builder: (context, state) {
          final extra = state.extra as Map<String, ProductModel>;
          final product = extra['product'];
          return ProductDetailsScreen(product: product!);
        },
      ),
      GoRoute(
        path: addProduct,
        builder: (context, state) => const AddProductScreen(),
      ),

      GoRoute(
        path: editProfile,
        builder: (context, state) => BlocProvider(
          create: (context) => SettingCubit(),
          child: const EditProfileScreen(),
        ),
      ),
      GoRoute(
        path: selectSize,
        builder: (context, state) => const SelectSizeScreen(),
      ),
      GoRoute(
        path: countingSession,
        builder: (context, state) {
          final extra = state.extra as Map<String, String>;

          final image = extra['image'];
          final name = extra['name'];

          return CountingSessionScreen(
            image: image ?? 'no found',
            name: name ?? 'no foung',
          );
        },
      ),
    ],
  );
}
