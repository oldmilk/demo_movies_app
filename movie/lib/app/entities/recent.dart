import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'recent.g.dart';

@HiveType(typeId: 2)
class Recent extends Equatable {
  @HiveField(0)
  final String item;

  @HiveField(1)
  final DateTime dateTime;

  const Recent({
    required this.item,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [item, dateTime];
}
