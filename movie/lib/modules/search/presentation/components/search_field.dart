import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/app/configs/app_colors.dart';
import 'package:movie/app/configs/app_values.dart';
import 'package:movie/app/constants/app_strings.dart';
import 'package:movie/app/entities/recent.dart';

import 'package:movie/modules/search/presentation/controllers/recent_bloc/recent_bloc.dart';
import 'package:movie/modules/search/presentation/controllers/search_bloc/search_bloc.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _textController = TextEditingController();

  // final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state.searching.isNotEmpty &&
            state.searching != _textController.text) {
          _textController.text = state.searching;
        }
      },
      child: Form(
        // key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: TextFormField(
                controller: _textController,
                cursorColor: AppColors.primaryText,
                cursorWidth: AppSize.s1,
                style: textTheme.bodyLarge,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primaryText,
                    ),
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primaryText,
                    ),
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.primaryText,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _textController.text = '';
                      context
                          .read<SearchBloc>()
                          .add(const GetSearchResultsEvent(''));
                    },
                    child: const Icon(
                      Icons.clear_rounded,
                      color: AppColors.primaryText,
                    ),
                  ),
                  hintText: AppStrings.searchHint,
                  hintStyle: textTheme.bodyLarge,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                icon: const Icon(Icons.search),
                color: Colors.white,
                onPressed: () {
                  if (_textController.text.isNotEmpty) {
                    context.read<RecentBloc>().add(AddRecentItemEvent(
                        recent: Recent(
                            item: _textController.text,
                            dateTime: DateTime.now())));

                    context
                        .read<SearchBloc>()
                        .add(GetSearchResultsEvent(_textController.text));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
