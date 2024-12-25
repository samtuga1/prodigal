import 'package:prodigal/utils/enums.dart';

class Cake {
  final int id;
  final String content;
  final CakeContentType contentType;
  final String instruction;
  final DateTime createdAt;
  final DateTime updatedAt;

  Cake({
    required this.id,
    required this.content,
    required this.contentType,
    required this.instruction,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Cake.fromJson(Map<String, dynamic> json) => Cake(
        id: json["id"],
        content: json["content"],
        contentType: CakeContentType.values.byName(json["contentType"]),
        instruction: json["instruction"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "contentType": contentType,
        "instruction": instruction,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
