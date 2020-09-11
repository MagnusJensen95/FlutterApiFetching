import 'dart:convert';

class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] ?? false,
        type = parsedJson['type'],
        by = parsedJson['by'],
        time = parsedJson['time'],
        text = parsedJson['text'],
        dead = parsedJson['dead'] ?? false,
        parent = parsedJson['parent'],
        kids = parsedJson['kids'] ?? [],
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];

  ItemModel.fromDbMap(Map<String, dynamic> map)
      : id = map['id'],
        type = map['type'],
        by = map['by'],
        time = map['time'],
        text = map['text'],
        parent = map['parent'],
        kids = jsonDecode(map['kids']),
        url = map['url'],
        score = map['score'],
        title = map['title'],
        descendants = map['descendants'],
        deleted = map['deleted'] == 1,
        dead = map['dead'] == 1;

  ItemModel.fromMock()
      : id = 1,
        deleted = false,
        type = 'type',
        by = 'me',
        time = 1,
        text = 'text',
        dead = false,
        parent = 2,
        kids = [1, 2],
        url = 'url',
        score = 1,
        title = 'title',
        descendants = 1;

  static Map<String, dynamic> toDbMap(ItemModel item) {
    return {
      'id': item.id,
      'deleted': (!item.deleted) ? 0 : 1,
      'type': item.type,
      'by': item.by,
      'time': item.time,
      'text': item.text,
      'dead': (!item.dead) ? 0 : 1,
      'parent': item.parent,
      'kids': jsonEncode(item.kids),
      'url': item.url,
      'score': item.score,
      'title': item.title,
      'descendants': item.descendants,
    };
  }
}
