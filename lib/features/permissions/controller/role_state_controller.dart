import 'package:get/get.dart';
import '../model/params/permission_params.dart';
class RoleStateController extends GetxController {
  RxList permissions = [].obs;

  void addPermission(PermissionParams permission) {
    permissions.add(permission);
  }

  void clear() {
    permissions = [].obs;
  }
}
