class Note {
  String noteName;
  String noteText;
  String timeStamp;
  String userId;

  Note({
    this.noteName,
    this.noteText,
    this.timeStamp,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map();
    json['noteName'] = noteName;
    json['noteText'] = noteText;
    json['timeStamp'] = timeStamp;
    json['userId'] = userId;
    return json;
  }

  Note.fromJson(Map<String, dynamic> responseBody) {
    noteName = responseBody['noteName'];
    noteText = responseBody['noteText'];
    timeStamp = responseBody['timeStamp'];
    userId = responseBody['userId'];
  }
}
