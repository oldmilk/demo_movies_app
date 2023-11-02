import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/app/configs/app_values.dart';
import 'package:movie/app/presentation/components/image_with_shimmer.dart';
import 'package:movie/app/routes/app_routes.dart';
import 'package:movie/modules/search/data/models/search_result_item.dart';

class GridViewCard extends StatelessWidget {
  const GridViewCard({
    super.key,
    required this.item,
  });

  final SearchResultItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(AppRoutes.movieDetailsRoute,
                params: {'movieId': item.tmdbID.toString()});
          },
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s8),
              child: ImageWithShimmer(
                imageUrl: item.posterUrl,
                width: double.infinity,
                height: AppSize.s150,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
