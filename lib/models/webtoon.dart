/// 웹툰의 데이터 모델
class WebtoonModel {
  final String id, title, thumb;

  // Named constructor
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
