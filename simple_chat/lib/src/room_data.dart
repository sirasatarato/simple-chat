import 'dart:core';

class RoomData {
  String name;
  String room;

  RoomData(this.name, this.room);

  Map<String, dynamic> toJson() => {
        'name': name,
        'room': room,
      };
}
