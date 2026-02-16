// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../core/constants/style/text_style_features.dart';

class DropdownListController extends GetxController {
  Map<String, String> sideBarRoutesMap = {
    "طلبات تم تنفيذها": "/done_orders",
    "طلبات تم إلغاؤها": "/cancelled_orders",
    "طلبات في طريقها للزبون": "/delivery_orders",
    "طلبات في الانتظار": "/pending-orders",
    "إدارة الأقسام": "",
    "المنتجات": "",
    "الأقسام": "/all-sections",
    "إدارة العروض": "",
    "إنشاء عرض جديد": "",
    "العروض الحاليّة": "/offers_screen",
    "الإدارة المالية": "",
    "تقارير عن المبيعات": "",
    "سجلّ المبيعات": "",
    "إدارة الإشعارات": "",
    "إشعارات النظام": "",
    "إشعارات المستخدمين": "",
    "الأخبار": "/news_screen",
    "إدارة الصلاحيات": "",
    "صلاحيّات الأدوار": "",
    "أدوار المستخدمين": "",
    "حسابات المستخدمين": "/users_accounts",
    "أدوار النظام": "/sys_roles",
    "المكتبات": "/libraries_screen",
    "إعدادات الاشعارات": "/notifications_settings_screen",
    "نقاط المستخدمين": "/points_screen",
    "قسائم المستخدمين": "/coupons_screen",
    "إعدادات الحساب": "/account_settings_screen",
    "طلبات تعبئة المحفظة": "/balance_request_screen",
  };
  final String name;
  final List<String> choices;
  RxBool isExpanded = false.obs;
  RxInt hoveredIndex = (-1).obs;
  RxString selectedChoice = ''.obs;
  TextStyleFeatures textStyleFeatures = TextStyleFeatures();

  DropdownListController({required this.name, required this.choices});

  void setSelectedChoice(String? choice) {
    selectedChoice.value = choice ?? ' ';
    printSelectedChoice();
  }

  String searchInsideBarRoutes(String choice) {
    for (var entry in sideBarRoutesMap.entries) {
      if (entry.key == choice) {
        print(entry.value);
        return entry.value;
      }
    }
    return "null";
  }

  void printSelectedChoice() {
    if (kDebugMode) {
      print(selectedChoice.value);
    }
  }
}
