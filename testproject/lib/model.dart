class QuestionsModel {
  late String question;
  String answer;
  QuestionsModel({
    required this.question,
    required this.answer,
  });
}

class OptionsModel {
  List<String> option;
  OptionsModel({required this.option});
}
