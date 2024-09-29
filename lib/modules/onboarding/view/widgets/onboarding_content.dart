// import 'package:animate_do/animate_do.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../../core/constants/app_strings.dart';

// class OnBoardingContent extends StatelessWidget {
//   const OnBoardingContent({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         FadeInUp(
//             duration: const Duration(seconds: 1),
//             child: SvgPicture.asset(SvgAssets.logoWithOpacity)),
//         FadeInUp(
//           duration: const Duration(milliseconds: 1500),
//           child: Container(
//             foregroundDecoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.white,
//                   Colors.white.withOpacity(0.0),
//                 ],
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//                 stops: const [0.15, 0.4],
//               ),
//             ),
//             child: Image.asset(ImageAssets.onboardingDoctor),
//           ),
//         ),
//         Positioned(
//           bottom: 20,
//           left: 0,
//           right: 0,
//           child: FadeInUp(
//             duration: const Duration(seconds: 2),
//             child: Text(
//               ' AppStrings.onBoardingText1.tr()',
//               style: Theme.of(context).textTheme.headlineLarge,
//               textAlign: TextAlign.center,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
