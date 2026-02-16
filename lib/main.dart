// ignore_for_file: must_be_immutable

import 'package:belahododdashboard/features/authentication/view/pages/account_settings_screen.dart';
import 'package:belahododdashboard/features/balance/view/pages/balance_request_details_screen.dart';
import 'package:belahododdashboard/features/balance/view/pages/balance_requests_screen.dart';
import 'package:belahododdashboard/features/libraries/view/pages/libraries_screen.dart';
import 'package:belahododdashboard/features/notifications/view/notifications_settings_screen.dart';
import 'package:belahododdashboard/features/offers/view/pages/offers_screen.dart';
import 'package:belahododdashboard/features/orders/view/pages/cancelled_orders_screen.dart';
import 'package:belahododdashboard/features/orders/view/pages/done_orders_screen.dart';
import 'package:belahododdashboard/features/orders/view/pages/delivery_orders_screen.dart';
import 'package:belahododdashboard/features/reports/view/pages/reports_screen.dart';
import 'package:belahododdashboard/features/sections/view/pages/modify_section_screen.dart';
import 'package:belahododdashboard/presentation/view/home_screen.dart';
import 'package:belahododdashboard/features/authentication/view/pages/login_screen.dart';

import 'package:belahododdashboard/features/sections/view/pages/section_details_screen.dart';
import 'package:belahododdashboard/presentation/view/settings_screen.dart';
import 'package:belahododdashboard/presentation/view/splash_screen.dart';
import 'package:belahododdashboard/features/permissions/view/pages/sys_roles_interface.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/constants/style/color_style_features.dart';
import 'core/constants/style/text_style_features.dart';
import 'core/services/settings_services.dart';
import 'core/utils/data_bindings.dart';
import 'features/coupons/view/pages/coupons_screen.dart';
import 'features/news/view/pages/news_screen.dart';
import 'features/orders/view/pages/pending_order_details_screen.dart';
import 'features/orders/view/pages/pending_orders_screen.dart';
import 'features/points/view/pages/points_screen.dart';
import 'features/permissions/view/pages/users_accounts_screen.dart';
import 'features/products/view/pages/display_products/display_book_page.dart';
import 'features/products/view/pages/display_products/display_game_page.dart';
import 'features/products/view/pages/display_products/display_product_page.dart';
import 'features/products/view/pages/display_products/display_quran_page.dart';
import 'features/products/view/pages/display_products/display_stationary_page.dart';
import 'features/sections/view/pages/all_sections_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(MyApp());
}

Future initialServices() async {
  await Get.putAsync(() => SettingsServices().init());
}

class MyApp extends StatelessWidget {
  TextStyleFeatures textStyleFeatures = TextStyleFeatures();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final double availableWidth = MediaQuery.of(context).size.width;
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bila Houdoud',
        initialRoute: '/',
        textDirection: TextDirection.rtl,
        initialBinding: DataBindings(),
        getPages: [
          GetPage(name: '/', page: () => SplashScreen()),
          GetPage(name: '/home_screen', page: () => const HomeScreen()),
          GetPage(name: '/settings', page: () => const SettingsScreen()),
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/reports_screen', page: () => const ReportsScreen()),
          GetPage(
              name: '/section-details',
              page: () => const SectionDetailsScreen()),
          GetPage(name: '/all-sections', page: () => const AllSectionsScreen()),
          GetPage(name: '/sys_roles', page: () => const SysRolesInterface()),
          GetPage(
              name: '/modifySection', page: () => const ModifySectionScreen()),
          GetPage(
              name: '/pending-orders', page: () => const PendingOrdersScreen()),
          GetPage(
              name: '/pending_orders_details',
              page: () => const PendingOrderDetailsScreen()),
          GetPage(
              name: '/libraries_screen', page: () => const LibrariesScreen()),
          GetPage(name: '/offers_screen', page: () => const OffersScreen()),
          GetPage(
              name: '/display_product_page',
              page: () => const DisplayProductPage()),
          GetPage(
              name: '/display_book_page', page: () => const DisplayBookPage()),
          GetPage(
              name: '/display_game_page', page: () => const DisplayGamePage()),
          GetPage(
              name: '/display_quran_page',
              page: () => const DisplayQuranPage()),
          GetPage(
              name: '/display_stationary_page',
              page: () => const DisplayStationaryPage()),
          GetPage(
              name: '/delivery_orders',
              page: () => const DeliveryOrdersScreen()),
          GetPage(
              name: '/cancelled_orders',
              page: () => const CancelledOrdersScreen()),
          GetPage(name: '/done_orders', page: () => const DoneOrdersScreen()),
          GetPage(name: '/news_screen', page: () => const NewsScreen()),
          GetPage(
              name: '/balance_request_details_screen',
              page: () => const BalanceRequestDetailsScreen()),
          GetPage(
              name: '/notifications_settings_screen',
              page: () => const NotificationsSettingsScreen()),
          GetPage(name: '/points_screen', page: () => const PointsScreen()),
          GetPage(name: '/coupons_screen', page: () => const CouponsScreen()),
          GetPage(
              name: '/balance_request_screen',
              page: () => const BalanceRequestsScreen()),
          GetPage(
              name: '/account_settings_screen',
              page: () => const AccountSettingsScreen()),
          GetPage(
              name: '/users_accounts', page: () => const UsersAccountsScreen()),
        ],
        theme: ThemeData(
          cardColor: ColorStyleFeatures.cardColor,
          // Apply the card color from style features
          textTheme: TextTheme(
            titleLarge:
                textStyleFeatures.cardTitleTextStyle(availableWidth, true),
            titleMedium:
                textStyleFeatures.cardTitleTextStyle(availableWidth, false),
          ),
        ),
      );
    });
  }
}
