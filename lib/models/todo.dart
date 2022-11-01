import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Todo {
  final String? id;
  final String? text;

  Todo({this.id, this.text});
}
