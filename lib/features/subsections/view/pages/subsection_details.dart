import 'package:belahododdashboard/features/products/view/widgets/subsection_products.dart';
import 'package:belahododdashboard/presentation/view/global_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../presentation/controllers/global_interface_controller.dart';

class SubsectionDetailsScreen extends StatefulWidget {
  final int? subsectionId;
  final int? sectionId;
  final int? initialPage;

  const SubsectionDetailsScreen(
      {super.key, this.subsectionId, this.initialPage, this.sectionId});

  @override
  State<SubsectionDetailsScreen> createState() =>
      _SubsectionDetailsScreenState();
}

class _SubsectionDetailsScreenState extends State<SubsectionDetailsScreen> {
  int _selectedIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    if (widget.initialPage != null) {
      _selectedIndex = widget.initialPage!;
    }
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalInterfaceController globalInterfaceController =
        Get.put(GlobalInterfaceController());
    globalInterfaceController.removeExtraWidgets();
    globalInterfaceController.addExtraWidget(Expanded(
        child: Column(children: [
      Expanded(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: <Widget>[
            SubsectionProducts(
              subsectionId: widget.subsectionId ?? 0,
              sectionId: widget.sectionId ?? 0,
            ),

            // RegisterTab(),
          ],
        ),
      )
    ])));
    return const GlobalInterface();
  }
}
