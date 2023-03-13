import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:revolution1401/common/router/app_router.dart';
import 'package:revolution1401/common/styles/appTheme/app_theme_helper.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';
import 'package:revolution1401/common/uikit/button/cin_button.dart';
import 'package:revolution1401/common/uikit/form/cin_checkbox.dart';
import 'package:revolution1401/common/uikit/form/cin_date_picker.dart';
import 'package:revolution1401/common/uikit/form/cin_textfield.dart';
import 'package:revolution1401/modules/content/bloc/content_add_bloc.dart';
import 'package:revolution1401/modules/content/enums/group_type.dart';
import 'package:revolution1401/modules/gallery/ui/widgets/video_index_widget.dart';

class ContentAddPage extends StatelessWidget {
  ContentAddPage({super.key});

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  String get _title => 'title';
  String get _description => 'description';
  String get _arrestDate => 'arrestDate';
  String get _deathDate => 'deathDate';
  String get _freedomDate => 'freedomDate';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContentAddBloc(),
      builder: (context, child) => FormBuilder(
        key: _formKey,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  (context.select<ContentAddBloc, bool>(
                          (bloc) => bloc.file != null))
                      ? const FilePlayer()
                      : const SizedBox(
                          height: 10,
                        ),
                  CinTextField(
                    name: _title,
                    hint: 'عنوان',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CinTextField(
                    name: _description,
                    hint: 'توضیحات',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Selector<ContentAddBloc, List<int>>(
                      selector: (context, bloc) => bloc.groupSelectedList,
                      shouldRebuild: (_, __) => true,
                      builder: (context, list, child) {
                        return ListView.builder(
                          itemCount: context
                              .read<ContentAddBloc>()
                              .groupTypeList
                              .length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) =>
                              CinCheckbox(
                            value: list.contains((index + 1)),
                            onChanged: (value) {
                              context
                                  .read<ContentAddBloc>()
                                  .checkGroup(value, index);
                            },
                            label: stringGroupType(index + 1),
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 8,
                  ),
                  CinDatePicker(name: _arrestDate, label: 'تاریخ دستگیری'),
                  const SizedBox(
                    height: 8,
                  ),
                  CinDatePicker(name: _freedomDate, label: 'تاریخ آزادی'),
                  const SizedBox(
                    height: 8,
                  ),
                  CinDatePicker(name: _deathDate, label: 'تاریخ قتل'),
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
                      if (_formKey.currentState!.saveAndValidate()) {
                        if (context.read<ContentAddBloc>().file != null) {
                          // ignore: use_build_context_synchronously
                          await context.read<ContentAddBloc>().uploadFile(
                                file: context.read<ContentAddBloc>().file,
                                arrestDate: (_formKey.currentState
                                        ?.value[_arrestDate] as DateTime?)
                                    ?.millisecondsSinceEpoch,
                                deathDate: (_formKey.currentState
                                        ?.value[_deathDate] as DateTime?)
                                    ?.millisecondsSinceEpoch,
                                description:
                                    _formKey.currentState?.value[_description],
                                freedomDate: (_formKey.currentState
                                        ?.value[_freedomDate] as DateTime?)
                                    ?.millisecondsSinceEpoch,
                                title: _formKey.currentState?.value[_title],
                              );
                          context.go(R.galleryPage);
                        }
                      }
                    },
                  ),
                  buildProgress(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProgress(BuildContext context) => StreamBuilder<TaskSnapshot>(
        stream: context.read<ContentAddBloc>().uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: context.select<ContentAddBloc, double?>(
                      (bloc) => bloc.progress,
                    ),
                    backgroundColor: context.colors.disabled,
                    color: context.colors.success,
                  ),
                  Center(
                    child: Text(
                      '${(100 * progress).roundToDouble()}%',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox(
              height: 50,
            );
          }
        },
      );
}

class FilePlayer extends StatelessWidget {
  const FilePlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (context.select<ContentAddBloc, bool>((bloc) => bloc.isImage())) {
      return Image.file(
        File(context.read<ContentAddBloc>().file!.path!),
        width: 250,
        height: 250,
      );
    } else if (context.select<ContentAddBloc, bool>((bloc) => bloc.isVideo())) {
      return SizedBox(
        height: 250,
        child: VideoPlayerWidget(
            videoPath: context.read<ContentAddBloc>().file!.path!),
      );
    } else {
      return Container();
    }
  }
}
