import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:movie/app/configs/app_colors.dart';

import 'package:movie/app/configs/app_theme.dart';

import 'package:movie/app/entities/genre.dart';

class GenresFilterView extends StatelessWidget {
  final GenresFilterParameters params;

  const GenresFilterView({
    super.key,
    required this.params,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FilterListWidget<Genre>(
        themeData: FilterListThemeData(context,
            headerTheme: HeaderThemeData.dark(),
            choiceChipTheme: ChoiceChipThemeData.dark(),
            backgroundColor: AppColors.primaryBackground),
        listData: params.genres,
        selectedListData: params.selectedGenres,
        choiceChipLabel: (genre) => genre!.name,
        validateSelectedItem: (list, val) => list!.contains(val),
        onItemSearch: (genres, query) {
          return genres.name.toLowerCase().contains(query.toLowerCase());
        },
        onApplyButtonClick: (list) {
          params.addEvent(list);

          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class GenresFilterParameters {
  final List<Genre> genres;
  final List<Genre> selectedGenres;
  final Function addEvent;

  const GenresFilterParameters({
    required this.genres,
    required this.selectedGenres,
    required this.addEvent,
  });
}
