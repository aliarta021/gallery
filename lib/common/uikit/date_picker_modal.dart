import 'package:flutter/cupertino.dart';

import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:revolution1401/common/styles/appTheme/app_theme_helper.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';
import 'package:revolution1401/common/uikit/modal.dart';
import 'package:revolution1401/common/uikit/modal_title.dart';
import 'package:revolution1401/common/uikit/page/cin_page_footer.dart';
import 'package:revolution1401/common/utils/locale_helper.dart';

class DatePickerModal extends StatefulWidget {
  const DatePickerModal({this.initialDate, this.onSubmit, Key? key}) : super(key: key);

  final DateTime? initialDate;
  final Function(DateTime date)? onSubmit;

  @override
  State<DatePickerModal> createState() => _DatePickerModalState();
}

class _DatePickerModalState extends State<DatePickerModal> {
  late Jalali jalali;
  late FixedExtentScrollController dayController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController yearController;

  final int _shownYears = 90;

  @override
  void initState() {
    jalali = Jalali.fromDateTime(widget.initialDate ?? DateTime.now());
    dayController = FixedExtentScrollController(initialItem: jalali.day - 1);
    monthController = FixedExtentScrollController(initialItem: jalali.month - 1);
    yearController = FixedExtentScrollController(
        initialItem: (_shownYears - (Jalali.now().year - jalali.year)) > 0
            ? (_shownYears - (Jalali.now().year - jalali.year))
            : 0);
    super.initState();
  }

  static const List<String> _monthNames = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];

  @override
  Widget build(BuildContext context) => Modal(
        child: Column(
          children: [
            ModalTitle(
              '${jalali.formatter.wN} ${jalali.formatter.d} ${jalali.formatter.mN} ${jalali.formatter.yyyy}',
              titleStyle: context.theme.appBarTheme.titleTextStyle!.copyWith(
                color: context.colors.textCaption,
                fontFamily: context.localeNumericFont,
              ),
            ),
            SizedBox(
              height: 165,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    picker(
                      controller: dayController,
                      itemCount: jalali.monthLength,
                      resolveItemText: (int index) => (index + 1).toString(),
                    ),
                    picker(
                      controller: monthController,
                      itemCount: 12,
                      resolveItemText: (int index) => _monthNames[index],
                    ),
                    picker(
                      controller: yearController,
                      itemCount: _shownYears + 1,
                      resolveItemText: (int index) => ((Jalali.now().year - _shownYears) + index).toString(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CinPageFooter(
                invert: true,
                onSubmit: () async {
                  if (widget.onSubmit != null) {
                    widget.onSubmit!(jalali.toDateTime());
                  }
                  Navigator.of(context).pop(jalali.toDateTime());
                },
              ),
            ),
          ],
        ),
      );

  Expanded picker(
          {required FixedExtentScrollController controller,
          required int itemCount,
          required String Function(int index) resolveItemText}) =>
      Expanded(
        child: CupertinoPicker.builder(
          scrollController: controller,
          itemExtent: 50,
          diameterRatio: 1.6,
          onSelectedItemChanged: (index) {
            updateDate();
          },
          selectionOverlay: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: context.colors.black.withOpacity(0.02),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          childCount: itemCount,
          itemBuilder: (context, index) => Center(
            child: Text(
              resolveItemText(index),
              style: context.textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w700,
                fontFamily: context.localeNumericFont,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );

  void updateDate() {
    final newYear = (Jalali.now().year - _shownYears) + yearController.selectedItem;
    final newMonth = monthController.selectedItem + 1;
    final int newMonthDaysLength = jalali.copy(month: newMonth, year: newYear, day: 1).monthLength;
    if (newMonthDaysLength < (dayController.selectedItem + 1)) {
      dayController.jumpToItem(newMonthDaysLength - 1);
    }
    setState(() {
      jalali = jalali.copy(day: dayController.selectedItem + 1, month: newMonth, year: newYear);
    });
    return;
  }
}
