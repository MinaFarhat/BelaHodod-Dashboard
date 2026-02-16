import "package:belahododdashboard/features/authentication/controller/user_info_controller.dart";
import "package:belahododdashboard/features/coupons/controller/coupon_details_controller.dart";
import "package:belahododdashboard/features/libraries/controller/libraries_controller.dart";
import "package:belahododdashboard/features/news/controller/news_controller.dart";
import "package:belahododdashboard/features/offers/controller/offers_controller.dart";
import "package:belahododdashboard/features/orders/controller/normal_orders_controller.dart";
import "package:belahododdashboard/features/permissions/controller/roles_controller.dart";
import "package:belahododdashboard/features/products/controller/products_controller.dart";
import "package:belahododdashboard/features/reports/controller/reports_controller.dart";
import "package:belahododdashboard/features/subsections/controller/subsection_controller.dart";
import "package:get/get.dart";
import "../../features/authentication/controller/authentication_controller.dart";
import "../../features/balance/controller/balance_request_details_controller.dart";
import "../../features/balance/controller/balance_requests_controller.dart";
import "../../features/coupons/controller/coupons_controller.dart";
import "../../features/offers/controller/offer_products_controller.dart";
import "../../features/orders/controller/delivery_method_dropdown_controller.dart";
import "../../features/orders/controller/order_details_controller.dart";
import "../../features/orders/controller/status_dropdown_controller.dart";
import "../../features/permissions/controller/permissions_controller.dart";
import "../../features/permissions/controller/role_state_controller.dart";
import "../../features/points/controller/points_controller.dart";
import "../../features/products/controller/selected_item_dropdown_controller.dart";
import "../../features/sections/controller/all_sections_controller.dart";
import "../../features/subsections/controller/dropdown_controller.dart";

class DataBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationController(), fenix: true);
    Get.lazyPut(() => AllSectionsController(), fenix: true);
    Get.lazyPut(() => LibrariesController(), fenix: true);
    Get.lazyPut(() => SubsectionsController(), fenix: true);
    Get.lazyPut(() => ProductsController(), fenix: true);
    Get.lazyPut(() => RolesController(), fenix: true);
    Get.lazyPut(() => OffersController(), fenix: true);
    Get.lazyPut(() => DropdownController(), fenix: true);
    Get.lazyPut(() => StatusDropdownController(), fenix: true);
    Get.lazyPut(() => NormalOrdersController(), fenix: true);
    Get.lazyPut(() => DeliveryMethodDropdownController(), fenix: true);
    Get.lazyPut(() => OrderDetailsController(), fenix: true);
    Get.lazyPut(() => NewsController(), fenix: true);
    Get.lazyPut(() => PointsController(), fenix: true);
    Get.lazyPut(() => CouponsController(), fenix: true);
    Get.lazyPut(() => BalanceRequestsController(), fenix: true);
    Get.lazyPut(() => BalanceRequestsDetailsController(), fenix: true);
    Get.lazyPut(() => ReportsController(), fenix: true);
    Get.lazyPut(() => UserInfoController(), fenix: true);
    Get.lazyPut(() => PermissionsController(), fenix: true);
    Get.lazyPut(() => RoleStateController(), fenix: true);
    Get.lazyPut(() => OfferProductsController(), fenix: true);
    Get.lazyPut(() => UserInfoController(), fenix: true);
    Get.lazyPut(() => SelectedItemDropdownController(), fenix: true);
    Get.lazyPut(() => CouponDetailsController(), fenix: true);
  }
}
