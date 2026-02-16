import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../core/components/retry_widget.dart';
import '../../../core/constants/style/constraint_style_features.dart';
import '../../../core/constants/style/text_style_features.dart';
import '../../../presentation/controllers/global_interface_controller.dart';
import '../../../presentation/view/global_interface.dart';
import '../../features/products/controller/products_controller.dart';
import '../../features/products/view/widgets/product_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductsController? productsController = Get.find<ProductsController>();
  TextEditingController keyword = TextEditingController(text: "");

  @override
  void initState() {
    productsController?.searchProductByName(keyword.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalInterfaceController globalInterfaceController =
        Get.put(GlobalInterfaceController());
    globalInterfaceController.removeExtraWidgets();
    globalInterfaceController.addExtraWidget(
      Center(
        child: Text(
          'جميع المنتجات',
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(Expanded(
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
                  productsController?.searchProductByName(keyword);
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
                    sectionId: 0,
                    product: state![index],
                    onDelete: () {
                      productsController?.searchProductByName(keyword.text);
                    },
                  );
                },
              ),
              onLoading: const Center(child: CircularProgressIndicator()),
              onEmpty: Center(
                child: RetryWidget(
                    error: "لا يوجد نتائج",
                    func: () {
                      productsController?.searchProductByName(keyword.text);
                    }),
              ),
              onError: (error) => Center(
                  child: RetryWidget(
                      error: error!,
                      func: () {
                        productsController?.searchProductByName(keyword.text);
                      })),
            ),
          ),
        ],
      ),
    ));

    return const GlobalInterface();
  }
}
