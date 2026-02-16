import 'package:belahododdashboard/features/news/model/news_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/components/used_filled.dart';
import '../../../../../core/constants/style/constraint_style_features.dart';
import '../../../../../core/constants/style/text_style_features.dart';
import '../../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../../core/components/most_used_button.dart';
import '../../../../../presentation/view/global_interface.dart';
import '../../../../core/constants/urls.dart';
import '../../../products/controller/file_upload_controller.dart';
import '../../../products/model/models/image_file_model.dart';
import '../../controller/news_controller.dart';
import '../../model/news_params.dart';

class ModifyNewsScreen extends StatefulWidget {
  final NewsModel? news;

  const ModifyNewsScreen({super.key, this.news});

  @override
  State<ModifyNewsScreen> createState() => _ModifyNewsScreenState();
}

class _ModifyNewsScreenState extends State<ModifyNewsScreen> {
  final NewsController? newsController = Get.find<NewsController>();
  final _newsFormKey = GlobalKey<FormState>();
  NewsParams params = NewsParams();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  final FileUploadController fileUploadController =
      Get.put(FileUploadController());

  @override
  void initState() {
    if (widget.news != null) {
      title.text = widget.news?.title ?? "";
      description.text = widget.news?.description ?? "";
    }

    super.initState();
  }

  void _selectFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      fileUploadController.addFile(
          result.files.first.bytes!, result.files.first.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalInterfaceController globalInterfaceController =
        Get.put(GlobalInterfaceController());
    globalInterfaceController.removeExtraWidgets();
    globalInterfaceController.addExtraWidget(
      Center(
        child: Text(
          widget.news != null ? 'تعديل خبر' : 'إضافة خبر',
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );
    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );
    globalInterfaceController.addExtraWidget(Form(
      key: _newsFormKey,
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UsedFilled(
              label: 'عنوان الخبر',
              controller: title,
              isMandatory: true,
              onSaved: (value) {
                params.title = value;
              },
            ),
            SizedBox(height: 1.h),
            UsedFilled(
              label: 'نص الخبر',
              controller: description,
              isMandatory: true,
              onSaved: (value) {
                params.description = value;
              },
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Text(
                  "صورة الخبر",
                  style: TextStyleFeatures.generalTextStyle,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(width: 25),
                GestureDetector(
                    onTap: () {
                      _selectFile();
                    },
                    child: Container(
                        width: 12.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: SizedBox(
                            width: 13.w,
                            height: 10.w,
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.grey,
                                size: 33,
                              ),
                            ),
                          ),
                        ))),
                Obx(
                  () => fileUploadController.images.isEmpty &&
                          widget.news != null
                      ? Expanded(
                          child: ListView(
                          shrinkWrap: true,
                          children: [
                            SizedBox(
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.network(
                                  Urls.imageUrl +
                                      widget.news!.image!
                                          .replaceAll('[', "")
                                          .replaceAll(']', '')
                                          .replaceAll('"', "")
                                          .replaceAll("\\", ""),
                                  height: 10.w,
                                  fit: BoxFit.cover,
                                ),
                                const Text("")
                              ],
                            ))
                          ],
                        ))
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: fileUploadController.images.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                  child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.memory(
                                    fileUploadController.images[index].image,
                                    height: 10.w,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(fileUploadController
                                      .images[index].fileName)
                                ],
                              ));
                            },
                          ),
                        ),
                )
              ],
            )
          ],
        ),
      ),
    ));

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(
      MostUsedButton(
        buttonText: 'حفظ',
        buttonIcon: Icons.save,
        onTap: () async {
          if (_newsFormKey.currentState!.validate() &&
              fileUploadController.images.isNotEmpty) {
            _newsFormKey.currentState?.save();

            if (widget.news != null) {
              List<ImageFileModel> images = [];
              for (int i = 0; i < fileUploadController.images.length; i++) {
                images.add(fileUploadController.images[i]);
              }
              newsController?.updateNews(widget.news?.id ?? 0, params, images);
            } else {
              List<ImageFileModel> images = [];
              for (int i = 0; i < fileUploadController.images.length; i++) {
                images.add(fileUploadController.images[i]);
              }

              bool? isClear = await newsController?.addNews(params, images);
              if (isClear ?? false) {
                fileUploadController.clear();
              }
            }
          }
          fileUploadController.clear();
        },
      ),
    );
    return const GlobalInterface();
  }
}
