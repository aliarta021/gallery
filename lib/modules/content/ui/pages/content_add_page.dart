import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:revolution1401/common/uikit/button/cin_button.dart';
import 'package:revolution1401/common/uikit/form/cin_textfield.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';
import 'package:revolution1401/modules/content/bloc/content_add_bloc.dart';

class ContentAddPage extends StatelessWidget {
  const ContentAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContentAddBloc(),
      builder: (context, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const CinTextField(
                name: 'title',
                hint: 'عنوان',
              ),
              const SizedBox(
                height: 8,
              ),
              const CinTextField(
                name: 'description',
                hint: 'توضیحات',
              ),
              const SizedBox(
                height: 8,
              ),
              CinButton(
                text: 'انتخاب فایل',
                onPressed: () async {
                  ImagePicker? imagePicker = ImagePicker();
                  XFile? result =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  // ignore: use_build_context_synchronously
                  await context.read<ContentAddBloc>().selectFile(result);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              CinButton(
                text: 'ارسال',
                onPressed: () async {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
