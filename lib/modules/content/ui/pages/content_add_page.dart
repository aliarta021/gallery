import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:revolution1401/common/uikit/button/cin_button.dart';
import 'package:revolution1401/common/uikit/form/cin_textfield.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';
import 'package:revolution1401/modules/content/bloc/content_add_bloc.dart';

class ContentAddPage extends StatelessWidget {
   ContentAddPage({super.key});

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  String get _title => 'title';

  String get _description => 'description';

  String get _commentTitle => 'commentTitle';

  String get _commentContent => 'commentContent';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContentAddBloc(),
      builder: (context, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (context
                  .select<ContentAddBloc, bool>((bloc) => bloc.file != null))
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(context.read<ContentAddBloc>().file!.path!),
                      width: 250,
                      height: 250,
                    ),
                  ),
                ),
              CinTextField(
                name: 'title',
                hint: 'عنوان',
                controller: context.select<ContentAddBloc, TextEditingController?>((bloc) => bloc.titleController),
              ),
              const SizedBox(
                height: 8,
              ),
              CinTextField(
                name: 'description',
                hint: 'توضیحات',
                controller: context.select<ContentAddBloc, TextEditingController?>((bloc) => bloc.descriptonController),
              ),
              const SizedBox(
                height: 8,
              ),
              CinButton(
                text: 'انتخاب فایل',
                onPressed: () async {
                  await context.read<ContentAddBloc>().selectFile();
                },
              ),
              const SizedBox(
                height: 8,
              ),
              CinButton(
                text: 'ارسال',
                onPressed: () async {
                  if (context.read<ContentAddBloc>().file != null) {
                    // ignore: use_build_context_synchronously
                    await context
                        .read<ContentAddBloc>()
                        .uploadFile(context.read<ContentAddBloc>().file);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
