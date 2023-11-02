import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/app/configs/app_values.dart';
import 'package:movie/app/constants/app_strings.dart';

import 'package:movie/modules/search/presentation/controllers/recent_bloc/recent_bloc.dart';
import 'package:movie/modules/search/presentation/controllers/search_bloc/search_bloc.dart';

class SearchText extends StatelessWidget {
  const SearchText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: AppPadding.p10,
            ),
            child: Text(
              AppStrings.search,
              style: textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: AppPadding.p6, bottom: AppPadding.p20),
            child: Text(
              AppStrings.searchText,
              style: textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          BlocBuilder<RecentBloc, RecentState>(
            builder: (context, state) {
              if (state.items.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.items.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Text(
                            AppStrings.recent,
                            style: textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return ListTile(
                            subtitle: Text(state.items[index - 1].item),
                            onTap: () {
                              context.read<SearchBloc>().add(ApplySearchEvent(
                                  state.items[index - 1].item));
                            },
                          );
                        }
                      }),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
