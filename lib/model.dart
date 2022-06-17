import 'package:hive/hive.dart';
part 'model.g.dart';
@HiveType(typeId: 0)
class data{
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String detail;
  @HiveField(2)
  bool? iscompleted;
  @HiveField(3)
  final String? timestamp;
  data({required this.title,required this.detail,required this.iscompleted,required this.timestamp});
  }