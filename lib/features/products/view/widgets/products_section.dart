import 'package:belahododdashboard/features/products/controller/products_controller.dart';
import 'package:belahododdashboard/features/products/view/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/components/retry_widget.dart';
class ProductsSection extends StatefulWidget {
  final int sectionId;

  const ProductsSection({super.key, required this.sectionId});

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> {
  final ProductsController? productsController = Get.find<ProductsController>();
  TextEditingController keyword = TextEditingController();

  @override
  void initState() {
    productsController?.getProducts(widget.sectionId, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20.px),
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Center(
              child: SizedBox(
                height: 60,
                width: 40.w,
                child: TextField(
                  controller: keyword,
                  style: const TextStyle(
                    color: Color(0xff020202),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                  ),
                  onChanged: (keyword) {
                    if (keyword.isNotEmpty) {
                      productsController?.searchProductBySection(
                          widget.sectionId, keyword);
                    } else {
                      productsController?.getProducts(widget.sectionId, true);
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xfff1f1f1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "ابحث عن منتج",
                    hintStyle: const TextStyle(
                        color: Color(0xffb2b2b2),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                        decorationThickness: 6),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: productsController!.obx(
                (state) => GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      // Number of columns
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 300.px,
                      childAspectRatio: 1),
                  itemCount: state?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ProductWidget(
                      sectionId: widget.sectionId,
                      product: state![index],
                      onDelete: () {
                        if (keyword.text.isNotEmpty) {
                          productsController?.searchProductBySection(
                              widget.sectionId, keyword.text);
                        } else {
                          productsController?.getProducts(
                              widget.sectionId, false);
                        }
                      },
                    );
                  },
                ),
                onLoading: const Center(child: CircularProgressIndicator()),
                onEmpty: Center(
                  child: RetryWidget(
                      error: "لا يوجد نتائج",
                      func: () {
                        if (keyword.text.isNotEmpty) {
                          productsController?.searchProductBySection(
                              widget.sectionId, keyword.text);
                        } else {
                          productsController?.getProducts(
                              widget.sectionId, true);
                        }
                      }),
                ),
                onError: (error) => Center(
                    child: RetryWidget(
                        error: error!,
                        func: () {
                          if (keyword.text.isNotEmpty) {
                            productsController?.searchProductBySection(
                                widget.sectionId, keyword.text);
                          } else {
                            productsController?.getProducts(
                                widget.sectionId, true);
                          }
                        })),
              ),
            ),
          ],
        ));
  }
}
