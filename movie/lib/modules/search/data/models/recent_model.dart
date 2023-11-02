import 'package:movie/app/entities/recent.dart';

class RecentModel extends Recent {
  const RecentModel({
    required super.item,
    required super.dateTime,
  });

  factory RecentModel.fromEntity(Recent recent) {
    return RecentModel(
      item: recent.item,
      dateTime: recent.dateTime,
    );
  }
}
