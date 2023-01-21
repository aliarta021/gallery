import 'package:flutter/material.dart';

class CinCheckbox extends StatelessWidget {
  const CinCheckbox({required this.value, required this.onChanged, Key? key, this.label}) : super(key: key);

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Checkbox(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: value,
            onChanged: onChanged,
          ),
          if (label != null) Text(label!, style: Theme.of(context).textTheme.bodyText2),
        ],
      );
}
