import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/style/constraint_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';

class ProductDisplayWidget extends StatelessWidget {
  final List<String> images;
  final String description;
  final String productName;
  final String barcode;
  final int price;
  final int quantity;
  final int minimumQuantity;
  final Map<String, dynamic> additionalSpecifications;

  const ProductDisplayWidget({super.key, 
    required this.images,
    required this.description,
    required this.productName,
    required this.barcode,
    required this.price,
    required this.quantity,
    required this.minimumQuantity,
    this.additionalSpecifications = const {},
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                productName,
                style: TextStyleFeatures.generalTextStyle,
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 350,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSpecificationRow('باركود', barcode),
                      const SizedBox(
                          height: ConstraintStyleFeatures.spaceBetweenElements),
                      _buildSpecificationRow('سعر المنتج', '$price ليرة '),
                      const SizedBox(
                          height: ConstraintStyleFeatures.spaceBetweenElements),
                      _buildSpecificationRow('الكمية', '$quantity'),
                      const SizedBox(
                          height: ConstraintStyleFeatures.spaceBetweenElements),
                      _buildSpecificationRow(
                          'أقل كمية مسموح بها', '$minimumQuantity'),
                      const SizedBox(
                          height: ConstraintStyleFeatures.spaceBetweenElements),
                      for (var entry in additionalSpecifications.entries)
                        _buildSpecificationRow(
                            entry.key, entry.value.toString()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'صور المنتج', // Images Label (in Arabic)
                style: TextStyleFeatures.generalTextStyle,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 300,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: images[index],
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'الوصف', // Description Label (in Arabic)
                style: TextStyleFeatures.generalTextStyle,
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpecificationRow(String key, String value) {
    return Column(
      children: [
        const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              key,
              style: TextStyleFeatures.generalTextStyle,
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
