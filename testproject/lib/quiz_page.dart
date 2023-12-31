import 'package:flutter/material.dart';
import 'package:testproject/model.dart';
import 'package:testproject/result_page.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:testproject/utilities.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:testproject/screens/localAndWebObjectsview.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  static int dailyProgress = 0;

  @override
  // ignore: library_private_types_in_public_api
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool allQuestionsAnswered = false;
  late ArCoreController arCoreController;
  int correctAnswers = 0;
  double dailyProgress = 0.0;
  // final List<List<String>> options = [
  //   ['Paris', 'London', 'Berlin', 'Madrid'],
  //   ['English', 'Spanish', 'Portuguese', 'French'],
  //   ['Yen', 'Dollar', 'Euro', 'Pound'],
  //   ['Leonardo da Vinci', 'Pablo Picasso', 'Vincent van Gogh', 'Michelangelo'],
  //   ['Mars', 'Venus', 'Jupiter', 'Mercury'],
  // ];

  // final List<String?> questionARModels = [
  //   'https://ar-3d-viewer.cloudinary.com/main.js/dqiuau49t/wwnnsthl4k-LibertyStatue_bhahfj',
  //   null,
  //   null,
  //   null,
  //   'https://res.cloudinary.com/your-cloud-name/image/upload/your-model-url-2',
  // ];

  // Map<String, String> questions = {
  //   'What is the capital of France?': 'Paris',
  //   'Which language is spoken in Brazil?': 'Spanish',
  //   'What is the currency of Japan?': 'Yen',
  //   'Who painted the Mona Lisa?': 'Leonardo da vinci',
  //   'Which planet is known as the Red Planet?': 'Mars',
  // };

  int totalQuestions = 0;

  List<QuestionsModel> questions = Utilities.questionsContentList();
  List<OptionsModel> options = Utilities.optionsContentList();
  List<QuestionsARModels> questionARModels =
      Utilities.questionsArModelContentList();

  //String get keys =>  Iterable<String> qValues = questions.values;

  Future<bool> checkAnswer(String selectedOption, String correctAnswer) async {
    setState(() {
      if (selectedOption == correctAnswer) {
        correctAnswers++;
        String? arModelUrl = questionARModels[totalQuestions].arLink;
        //! ??? what is going on here
        //! why does this accept null values
        onLocalObjectButtonPressed(context, arModelUrl);
      }

      totalQuestions++;

      dailyProgress =
          totalQuestions > 0 ? correctAnswers / totalQuestions : 0.0;

      if (totalQuestions >= questions.length) {
        allQuestionsAnswered = true;
      }
    });

    return allQuestionsAnswered;
  }

  void onLocalObjectButtonPressed(BuildContext context, String arModelUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocalAndWebObjectsView(
          arModelUrl: arModelUrl,
        ),
      ),
    );
  }

  Future<void> launchARView(String arModelUrl) async {
    // Check if ARCore is available on the device
    bool isARCoreAvailable = await ArCoreController.checkArCoreAvailability();
    if (!isARCoreAvailable) {
      // ARCore is not supported on this device
      return;
    }

    // Create the ARCore session
    arCoreController = ArCoreController(
      id: DateTime.now().millisecondsSinceEpoch.toInt(),
    );

    // Load the 3D model from the Cloudinary URL
    ArCoreNode arModelNode = ArCoreNode(
      name: arModelUrl,
      scale: vector.Vector3(0.1, 0.1, 0.1), // Adjust the scale as needed
    );

    // Add the 3D model node to the AR scene
    arCoreController.addArCoreNodeWithAnchor(arModelNode);

    //

    // Present the AR view
    // ignore: use_build_context_synchronously
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArCoreViewPage(arCoreController),
      ),
    );

    // Perform any cleanup after the AR view is dismissed
    arCoreController.dispose();
  }

  void navigateToResultPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          correctAnswers: correctAnswers,
          totalQuestions: totalQuestions,
          average: correctAnswers / totalQuestions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: const Text('Quiz Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.9,
              height: size.height * 0.35,
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                //keys,
                questions[totalQuestions].question,
                //questions[totalQuestions].toString(),
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: size.height * 0.45,
              child: ListView.builder(
                itemCount: options.length - 1,
                // itemExtent: options.length.toDouble() - 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    //TODO: make this buttons white
                    child: ElevatedButton(
                      onPressed: () async {
                        bool allQuestionsAnswered = await checkAnswer(
                            options[totalQuestions].option[index],
                            questions[totalQuestions].answer);

                        if (allQuestionsAnswered) {
                          navigateToResultPage();
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(4)),
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(fontSize: 20))),
                      child: SizedBox(
                        width: size.width * 0.7,
                        height: size.height * 0.1,
                        child: Center(
                          child: Text(
                            options[totalQuestions].option[index],
                            style: const TextStyle(
                                fontSize: 18, color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(16.0),
        child: LinearProgressIndicator(
          value: dailyProgress,
        ),
      ),
    );
  }
}
// ArCoreView(
//           onArCoreViewCreated: _onArCoreViewCreated,
//         );

//   void _onArCoreViewCreated(ArCoreController controller) {
//     arCoreController = controller;
//     _ArCoreViewPage(arCoreController),
//     }

class ArCoreViewPage extends StatelessWidget {
  final ArCoreController arCoreController;

  const ArCoreViewPage(this.arCoreController, {Key? key}) : super(key: key);

  get onArCoreViewCreated => arCoreController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR View'),
      ),
      body: Center(
        child: ArCoreView(
          onArCoreViewCreated: onArCoreViewCreated,
          enableTapRecognizer: true,
        ),
      ),
    );
  }
}
