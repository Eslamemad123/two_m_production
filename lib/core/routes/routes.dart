import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:two_m_production/features/pages/AddProduct/pages/add_product_screen.dart';
import 'package:two_m_production/features/pages/Auth/login/Presentation/cubit/auth_cubit.dart';
import 'package:two_m_production/features/pages/Auth/login/Presentation/page/loginScreen.dart';
import 'package:two_m_production/features/pages/Main/page/NavBar.dart';
import 'package:two_m_production/features/pages/ProductDetails/pages/product_details_screen.dart';
import 'package:two_m_production/features/pages/Setting/pages/edit_profile_screen.dart';
import 'package:two_m_production/features/pages/intro/splash/splashScreen.dart';

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

  static final routes = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
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
        builder: (context, state) => const ProductDetailsScreen(),
      ),
      GoRoute(
        path: addProduct,
        builder: (context, state) => const AddProductScreen(),
      ),

      GoRoute(
        path: editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
    ],
  );
}
