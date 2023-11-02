import 'package:flutter/material.dart';
import 'package:movie/app/configs/app_values.dart';
import 'package:movie/app/constants/app_strings.dart';

class EmptyRecentText extends StatelessWidget {
  const EmptyRecentText({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.recentIsEmpty,
          style: textTheme.titleMedium,
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppPadding.p6),
          child: Text(
            AppStrings.watchlistText,
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
