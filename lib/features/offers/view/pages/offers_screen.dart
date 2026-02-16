import 'package:belahododdashboard/features/offers/view/pages/modify_offer_screen.dart';
import 'package:belahododdashboard/features/offers/view/widgets/offer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../core/components/most_used_button.dart';
import '../../../../../../core/components/retry_widget.dart';
import '../../../../../../core/constants/style/constraint_style_features.dart';
import '../../../../../../core/constants/style/text_style_features.dart';
import '../../../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../../../presentation/view/global_interface.dart';
import '../../controller/offers_controller.dart';
class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final OffersController? offersController = Get.find<OffersController>();
  TextEditingController keyword = TextEditingController();

  @override
  void initState() {
    offersController?.getOffers(true);
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
          'العروض الحالية',
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(
      Center(
        child: SizedBox(
          height: 60,
          width: 50.w,
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
                offersController?.searchOffer(keyword);
              } else {
                offersController?.getOffers(false);
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xfff1f1f1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              hintText: "ابحث عن عرض محدد",
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
    );

    globalInterfaceController.addExtraWidget(
      Expanded(
        child: offersController!.obx(
            (state) => GridView.builder(
                  padding:
                      EdgeInsets.all(ConstraintStyleFeatures.gridsPadding()),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: state?.length ?? 0,
                  itemBuilder: (context, index) {
                    return OfferWidget(
                      offer: state![index],
                      onDelete: () {
                        if (keyword.text.isNotEmpty) {
                          offersController?.searchOffer(keyword.text);
                        } else {
                          offersController?.getOffers(false);
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
                      offersController?.searchOffer(keyword.text);
                    } else {
                      offersController?.getOffers(true);
                    }
                  }),
            ),
            onError: (error) => Center(
                  child: RetryWidget(
                      error: error!,
                      func: () {
                        if (keyword.text.isNotEmpty) {
                          offersController?.searchOffer(keyword.text);
                        } else {
                          offersController?.getOffers(true);
                        }
                      }),
                )),
      ),
    );

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(
      MostUsedButton(
          buttonText: 'أضف عرض جديد',
          buttonIcon: Icons.add_circle_outline,
          onTap: () {
            Get.to(() => const ModifyOfferScreen());
          }),
    );

    return const GlobalInterface();
  }
}
