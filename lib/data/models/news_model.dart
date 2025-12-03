import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/news_entity.dart';

// Această linie îi spune generatorului cum să numească fișierul generat
part 'news_model.g.dart';

@JsonSerializable()
class NewsModel extends NewsEntity {
  // Mapăm numele din JSON (snake_case) la variabilele noastre (camelCase)

  @JsonKey(name: 'image')
  final String imagePath; // JSON-ul tău zice 'image', dar noi vrem în entitate 'imageUrl'

  @JsonKey(name: 'publisher_icon')
  final String pubIcon;

  const NewsModel({
    required int id,
    required String title,
    required String category,
    required this.imagePath, // Mapare specială
    required String date,
    required String publisher,
    required this.pubIcon,   // Mapare specială
    bool? isVerified,        // Putem ignora câmpurile extra dacă nu ne trebuie în Entity
  }) : super(
    id: id,
    title: title,
    category: category,
    imageUrl: imagePath, // Pasăm valoarea către părinte (Entity)
    date: date,
    publisher: publisher,
    publisherIcon: pubIcon,
  );

  // Magia care generează automat codul de transformare JSON -> Object
  factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}