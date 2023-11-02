import 'package:flutter/material.dart';
import 'package:movie/app/configs/app_colors.dart';
import 'package:movie/app/entities/media.dart';
import 'package:movie/app/configs/app_values.dart';
import 'package:movie/app/presentation/components/image_with_shimmer.dart';
import 'package:movie/common/utils/functions.dart';

class VerticalPageViewCard extends StatelessWidget {
  const VerticalPageViewCard({
    super.key,
    required this.media,
  });

  final Media media;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        navigateToDetailsView(context, media);
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s8),
              child: ImageWithShimmer(
                imageUrl: media.posterUrl,
                width: size.width,
                height: double.infinity,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: AppSize.s200,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
              )),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p16),
                child: Text(
                  media.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleSmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p16),
                child: Row(
                  children: [
                    if (media.releaseDate.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(right: AppPadding.p12),
                        child: Text(
                          media.releaseDate.split(', ')[1],
                          textAlign: TextAlign.center,
                          style: textTheme.bodyLarge,
                        ),
                      ),
                    ],
                    const Icon(
                      Icons.star_rate_rounded,
                      color: AppColors.ratingIconColor,
                      size: AppSize.s18,
                    ),
                    Text(
                      media.voteAverage.toString(),
                      style: textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p16, bottom: AppPadding.p16),
                child: Text(
                  media.overview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyLarge,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
