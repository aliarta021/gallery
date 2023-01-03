// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';



// //TODO move this to lib/common/ui/pages/error/
// class ErrPage extends StatelessWidget {
//   const ErrPage({Key? key, this.title, this.description}) : super(key: key);

//   final String? title;
//   final String? description;

//   @override
//   Widget build(BuildContext context) => CinPage(
//         title: title ?? LocaleKeys.errPage_title.tr(),
//         childrenPadding: const EdgeInsets.symmetric(horizontal: 12),
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 80),
//             child: Column(
//               children: [
//                 SvgPicture.asset(
//                   Svgs.logo,
//                   width: 70,
//                   color: ColorPalette.of(context).textDisabled,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 12),
//                   child: Text(
//                     description ?? LocaleKeys.errPage_description.tr(),
//                     style: Theme.of(context).textTheme.subtitle2!.copyWith(color: ColorPalette.of(context).textCaption),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 15),
//                   child: CinButton(
//                     onPressed: () async {
//                       context.pop();
//                     },
//                     width: 100,
//                     type: ButtonType.secondary,
//                     text: LocaleKeys.errPage_goBack.tr(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
// }
