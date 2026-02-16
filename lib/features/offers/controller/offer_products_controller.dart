import 'package:belahododdashboard/features/offers/model/params/offer_product_params.dart';
import 'package:get/get.dart';
class OfferProductsController extends GetxController {
  RxList offerProducts = [].obs;

  void addOfferProducts(OfferProductParams offerProduct) {
    offerProducts.add(offerProduct);
  }

  void clear() {
    offerProducts = [].obs;
  }
}
