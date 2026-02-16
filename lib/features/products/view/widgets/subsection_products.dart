import 'package:belahododdashboard/features/products/view/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/components/retry_widget.dart';
import '../../controller/products_controller.dart';

class SubsectionProducts extends StatefulWidget {
  final int subsectionId;
  final int sectionId;

  const SubsectionProducts(
      {super.key, required this.subsectionId, required this.sectionId});

  @override
  State<SubsectionProducts> createState() => _SubsectionProductsState();
}

class _SubsectionProductsState extends State<SubsectionProducts> {
  final ProductsController? productsController = Get.find<ProductsController>();

  @override
  void initState() {
    productsController?.getSubsectionProducts(widget.subsectionId, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            height: 60,
            width: 50.w,
            child: TextField(
              style: const TextStyle(
                color: Color(0xff020202),
                fontSize: 20,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
              onChanged: (keyword) {
                if (keyword.isNotEmpty) {
                  productsController?.searchProduct(keyword, widget.sectionId);
                } else {
                  productsController?.getSubsectionProducts(
                      widget.subsectionId, true);
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xfff1f1f1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintText: "ابحث عن منتج محدد",
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
        Expanded(
            //  padding: EdgeInsets.all(2.px),
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
                sectionId: widget.subsectionId,
                product: state![index],
                onDelete: () {
                  productsController?.getSubsectionProducts(
                      widget.subsectionId, false);
                },
              );
            },
          ),
          onLoading: const Center(child: CircularProgressIndicator()),
          onEmpty: Center(
            child: RetryWidget(
                error: "لا يوجد نتائج",
                func: () => productsController?.getSubsectionProducts(
                    widget.subsectionId, true)),
          ),
          onError: (error) => Center(
              child: RetryWidget(
                  error: error!,
                  func: () => productsController?.getSubsectionProducts(
                      widget.subsectionId, true))),
        )),
      ],
    );
  }
}
