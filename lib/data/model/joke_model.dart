class JokeModel {
  JokeModel({
    this.id,
    this.type,
    this.setup,
    this.punchline,
  });

  int? id;
  String? type;
  String? setup;
  String? punchline;

  factory JokeModel.fromJson(Map<String, dynamic> json) => JokeModel(
        id: json["id"],
        type: json["type"],
        setup: json["setup"],
        punchline: json["punchline"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "setup": setup,
        "punchline": punchline,
      };
}
