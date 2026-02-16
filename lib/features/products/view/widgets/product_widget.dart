import 'package:belahododdashboard/features/products/controller/products_controller.dart';
import 'package:belahododdashboard/features/products/model/models/product_model.dart';
import 'package:belahododdashboard/features/products/view/pages/modify_product/modify_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/components/custom_button.dart';
import '../../../../core/constants/style/color_style_features.dart';
import '../pages/display_products/display_book_page.dart';
import '../pages/display_products/display_game_page.dart';
import '../pages/display_products/display_product_page.dart';
import '../pages/display_products/display_quran_page.dart';
import '../pages/display_products/display_stationary_page.dart';
import '../../../../core/constants/urls.dart';
import '../pages/modify_product/modify_book_screen.dart';
import '../pages/modify_product/modify_game_screen.dart';
import '../pages/modify_product/modify_quran_screen.dart';
import '../pages/modify_product/modify_stationery_screen.dart';

class ProductWidget extends StatefulWidget {
  final ProductModel product;
  final Function onDelete;
  final int sectionId;

  const ProductWidget({
    super.key,
    required this.product,
    required this.onDelete,
    required this.sectionId,
  });

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final ProductsController? productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.product.book != null) {
          Get.to(() => DisplayBookPage(
                productModel: widget.product,
              ));
        } else if (widget.product.stationery != null) {
          Get.to(() => DisplayStationaryPage(
                productModel: widget.product,
              ));
        } else if (widget.product.game != null) {
          Get.to(() => DisplayGamePage(
                productModel: widget.product,
              ));
        } else if (widget.product.quran != null) {
          Get.to(() => DisplayQuranPage(
                productModel: widget.product,
              ));
        } else {
          Get.to(() => DisplayProductPage(
                productModel: widget.product,
              ));
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.all(10.px),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.px),
                    color: ColorStyleFeatures.headLinesTextColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30.px),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 1.h),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.px),
                          ),
                          child: SizedBox(
                            height: 75,
                            width: 75,
                            child: widget.product.images != null
                                ? CachedNetworkImage(
                                    imageUrl: Urls.imageUrl +
                                        widget.product.images!
                                            .replaceAll('[', "")
                                            .replaceAll(']', '')
                                            .replaceAll('"', "")
                                            .replaceAll("\\", ""),
                                    fit: BoxFit.cover,
                                    // Ensures the image fits the container size
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(25.px),
                                      color:
                                          ColorStyleFeatures.headLinesTextColor,
                                    ),
                                  ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.px),
                          ),
                          child: Center(
                            child: Text(
                              widget.product.name ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.px,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButton(
                      constraints: constraints,
                      icon: Icons.edit,
                      backgroundColor: Colors.grey[400]!,
                      onTap: () {
                        switch (widget.product.sectionId) {
                          case 1:
                            Get.to(() => ModifyBookScreen(
                                  product: widget.product,
                                  sectionId: widget.sectionId,
                                ));
                            break;
                          case 2:
                            Get.to(() => ModifyGameScreen(
                                  product: widget.product,
                                  sectionId: widget.sectionId,
                                ));
                            break;
                          case 3:
                            Get.to(() => ModifyStationeryScreen(
                                  product: widget.product,
                                  sectionId: widget.sectionId,
                                ));
                            break;

                          case 4:
                            Get.to(() => ModifyQuranScreen(
                                  product: widget.product,
                                  sectionId: widget.sectionId,
                                ));
                            break;
                          default:
                            Get.to(() => ModifyProductScreen(
                                  product: widget.product,
                                  sectionId: widget.sectionId,
                                ));
                            break;
                        }
                      },
                    ),
                    SizedBox(width: 1.w),
                    CustomButton(
                      constraints: constraints,
                      icon: Icons.delete,
                      backgroundColor: Colors.red[600]!,
                      onTap: () async {
                        bool? isSuccess = await productsController
                            ?.deleteProduct(widget.product.id ?? 0);
                        if (isSuccess ?? false) {
                          widget.onDelete();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
