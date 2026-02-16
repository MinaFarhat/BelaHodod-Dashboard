import 'package:belahododdashboard/features/offers/controller/offers_controller.dart';
import 'package:belahododdashboard/features/offers/view/pages/modify_offer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/constants/style/color_style_features.dart';
import '../../model/models/offer_model.dart';
class OfferWidget extends StatefulWidget {
  final OfferModel offer;
  final Function onDelete;

  const OfferWidget({
    super.key,
    required this.offer,
    required this.onDelete,
  });

  @override
  State<OfferWidget> createState() => _OfferWidgetState();
}

class _OfferWidgetState extends State<OfferWidget> {
  final OffersController? offersController = Get.find<OffersController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: LayoutBuilder(builder: (context, constraints) {
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
                      padding: EdgeInsets.all(25.px),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.px),
                            ),
                            child: const Icon(
                              Icons.add_chart_outlined,
                              size: 75,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.px),
                            ),
                            child: Center(
                                child: Text(
                              widget.offer.name ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.px),
                            )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.px),
                            ),
                            child: Center(
                                child: Text(
                              widget.offer.description ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.px),
                            )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.px),
                            ),
                            child: Center(
                                child: Text(
                              DateFormat('yyyy-MM-dd – kk:mm')
                                  .format(widget.offer.activeUntil!),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.px),
                            )),
                          ),
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(26.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButton(
                      constraints: constraints,
                      icon: Icons.edit,
                      backgroundColor: Colors.grey[400]!,
                      onTap: () {
                        Get.to(() => ModifyOfferScreen(
                              offer: widget.offer,
                            ));
                      },
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    CustomButton(
                      constraints: constraints,
                      icon: Icons.delete,
                      backgroundColor: Colors.red[600]!,
                      onTap: () async {
                        bool? isSuccess = await offersController
                            ?.deleteOffer(widget.offer.id ?? 0);
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
        }));
  }
}
