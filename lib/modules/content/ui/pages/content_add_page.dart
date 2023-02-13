import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:revolution1401/common/uikit/button/cin_button.dart';
import 'package:revolution1401/common/uikit/form/cin_checkbox.dart';
import 'package:revolution1401/common/uikit/form/cin_date_picker.dart';
import 'package:revolution1401/common/uikit/form/cin_radio_group.dart';
import 'package:revolution1401/common/uikit/form/cin_textfield.dart';
import 'package:revolution1401/modules/content/bloc/content_add_bloc.dart';
import 'package:revolution1401/modules/content/enums/group_type.dart';

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
                  if (context.select<ContentAddBloc, bool>(
                      (bloc) => bloc.file != null))
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
                                arrestDate:
                                    _formKey.currentState?.value[_arrestDate],
                                deathDate: _formKey.currentState?.value[_deathDate],
                                description:
                                    _formKey.currentState?.value[_description],
                                freedomDate:
                                    _formKey.currentState?.value[_freedomDate],
                                title: _formKey.currentState?.value[_title],
                              );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
