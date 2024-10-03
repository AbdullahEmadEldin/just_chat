import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:just_chat/modules/auth/logic/auth_cubit.dart';

import '../../../../../core/theme/colors/colors_manager.dart';

class EnterPhoneField extends StatelessWidget {
  const EnterPhoneField({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<PhoneAuthCubit>().formKey,
      child: InternationalPhoneNumberInput(
        onInputChanged: (number) {
          context.read<PhoneAuthCubit>().phoneNumber =
              number.phoneNumber!;
              print('============>>>> number ${context.read<PhoneAuthCubit>().phoneNumber}');
        },
        validator: (p0) {
          if (p0!.isEmpty) {
            return 'Phone Number is required';
          }
          return null;
        },
        selectorButtonOnErrorPadding: 0,
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG,
          useEmoji: true,
          setSelectorButtonAsPrefixIcon: true,
          trailingSpace: false,
          leadingPadding: 12.w,
        ),
        selectorTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: ColorsManager().colorScheme.grey60,
            ),
        inputBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ColorsManager().colorScheme.primary,
          ),
        ),
        textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: ColorsManager().colorScheme.grey80,
              fontWeight: FontWeight.bold,
              letterSpacing: 3.w,
            ),
        inputDecoration: InputDecoration(
            hintText: 'Enter your phone number',
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: ColorsManager().colorScheme.grey40,
                width: 1.3,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: ColorsManager().colorScheme.primary,
                width: 1.3,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: ColorsManager().colorScheme.fillRed,
                width: 1.3,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: ColorsManager().colorScheme.fillRed,
                width: 1.3,
              ),
            ),
            fillColor: ColorsManager().colorScheme.grey20.withOpacity(0.4),
            filled: true),
        countries: const [
          'US',
          'EG',
          'AF',
          'IQ',
          'SA',
          'SD',
          'AE',
          'SY',
          'TR',
          'GB'
        ],
      ),
    );
  }
}
