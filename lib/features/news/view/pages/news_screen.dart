import 'package:belahododdashboard/features/news/model/news_model.dart';
import 'package:belahododdashboard/features/news/view/pages/modify_news_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/components/edit_button.dart';
import '../../../../../core/components/retry_widget.dart';
import '../../../../../core/constants/style/constraint_style_features.dart';
import '../../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../../core/components/most_used_button.dart';
import '../../../../../presentation/view/global_interface.dart';
import '../../controller/news_controller.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsController? newsController = Get.find<NewsController>();

  @override
  void initState() {
    newsController?.getNews(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalInterfaceController globalInterfaceController =
        Get.put(GlobalInterfaceController());
    globalInterfaceController.removeExtraWidgets();

    globalInterfaceController.addExtraWidget(Expanded(
      child: newsController!.obx(
          (state) => Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(),
                columnWidths: const {
                  0: FractionColumnWidth(0.6),
                  1: FractionColumnWidth(0.2),
                  2: FractionColumnWidth(0.2),
                },
                children: [
                  const TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: Text('نص الخبر',
                                style: TextStyle(
                                  fontFamily: 'Arabic',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text('تعديل الخبر',
                              style: TextStyle(
                                fontFamily: 'Arabic',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text('حذف الخبر',
                              style: TextStyle(
                                fontFamily: 'Arabic',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ],
                  ),
                  ...state!.map((item) {
                    return _buildTableRow(
                      item,
                      CellButton(
                        onTap: () {
                          Get.to(() => ModifyNewsScreen(
                                news: item,
                              ));
                        },
                        icon: Icons.edit,
                        label: "تعديل",
                      ),
                      CellButton(
                        onTap: () async {
                          bool? isRefresh =
                              await newsController?.deleteNews(item.id ?? 0);
                          if (isRefresh ?? false) {
                            newsController?.getNews(false);
                          }
                        },
                        icon: Icons.delete,
                        label: "حذف",
                      ),
                    );
                  }),
                ],
              ),
          onLoading: const Center(child: CircularProgressIndicator()),
          onEmpty: Center(
            child: RetryWidget(
                error: "لا يوجد نتائج",
                func: () => newsController?.getNews(true)),
          ),
          onError: (error) => Center(
                child: RetryWidget(
                    error: error!, func: () => newsController?.getNews(true)),
              )),
    ));

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(
      MostUsedButton(
          buttonText: 'إضافة خبر',
          buttonIcon: Icons.add_circle_outline,
          onTap: () {
            Get.to(() => const ModifyNewsScreen());
          }),
    );
    return const GlobalInterface();
  }

  TableRow _buildTableRow(
    NewsModel news,
    Widget editButton,
    Widget deleteButton,
  ) {
    const textStyle = TextStyle(
      fontFamily: 'Arabic',
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );

    return TableRow(
      decoration: BoxDecoration(color: Colors.grey[200]),
      children: [
        TableCell(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Text(news.description ?? "", style: textStyle),
              )),
        ),
        TableCell(child: editButton),
        TableCell(child: deleteButton),
      ],
    );
  }
}
