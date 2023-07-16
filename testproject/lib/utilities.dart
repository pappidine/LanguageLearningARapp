import 'package:testproject/model.dart';

class Utilities {
  static List<QuestionsModel> QuestionsContentList() {
    return [
      QuestionsModel(
        answer: 'Paris',
        question: 'What is the capital of France?',
      ),
      QuestionsModel(
        answer: 'Spanish',
        question: 'Which language is spoken in Brazil?',
      ),
      QuestionsModel(
        answer: 'yen',
        question: 'What is the currency of Japan?',
      ),
      QuestionsModel(
        answer: 'Leonardo da vinci',
        question: 'Who painted the Mona Lisa?',
      ),
      QuestionsModel(
        answer: 'Mars',
        question: 'Which planet is known as the Red Planet?',
      ),
    ];
  }
}
