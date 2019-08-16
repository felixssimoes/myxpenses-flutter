import 'package:flutter/foundation.dart';

class Account {
  final String id;
  final String name;

  Account({
    @required this.id,
    @required this.name,
  });

  Account.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  Account copyWith({String name}) => Account(
        id: this.id,
        name: name ?? this.name,
      );
}
