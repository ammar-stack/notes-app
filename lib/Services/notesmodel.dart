class NotesModel {
  int? id;
  String? title;
  String? description;
  String? time;

  NotesModel({this.id, this.title, this.description, this.time});

  NotesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['time'] = this.time;
    return data;
  }
}