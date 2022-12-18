
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quiz_academy/style/app_colors.dart';
import 'package:quiz_academy/ui/Home%20Screen/quiz_screen.dart';



import '../../model/Quiz_model.dart';
import 'home.dart';

class MtLoser extends StatefulWidget {
  const MtLoser({Key? key, required this.quizzes, required this.score}) : super(key: key);
  final Quizzes quizzes;
  final String score;
  @override
  State<MtLoser> createState() => _MtLoserState();
}

class _MtLoserState extends State<MtLoser> {
  void showPopUp(String retakePoint) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: 320,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Are you agree?',
                    style: TextStyle(
                        color: AppColor.titleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'If you retake then $retakePoint points will be deducted!',
                    style: TextStyle(color: AppColor.subTitleColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    height: 150,
                    width: 140,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/coin.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: AppColor.mainColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ).onTap(
                                  () async{
                                try{
                                  EasyLoading.show(status: 'Loading');
                                  if(mounted){
                                    EasyLoading.showSuccess('Successful');
                                    QuizScreen(quizzes: widget.quizzes,).launch(context);
                                  }else{
                                    EasyLoading.showError('Not Enough Coin');
                                  }
                                }catch(e){
                                  EasyLoading.showError(e.toString());
                                }
                              }
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.subTitleColor.withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.transparent),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'No',
                                style:
                                    TextStyle(color: AppColor.subTitleColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ).onTap(() => finish(context)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String select = '';

  List<String> option = [
    'Share Score',
    'Rate Us',
    'Home',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: context.width() / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                'Sorry',
                style: TextStyle(color: AppColor.subTitleColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5.0),
              Text(
                'You Lose',
                style: TextStyle(
                    color: AppColor.titleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 170,
                width: 170,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/lose.png'),
                  ),
                ),
              ),
              Text(
                'Loser',
                style: TextStyle(
                    color: AppColor.titleColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(6.0),
                            color: const Color(0xFF8555EA),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              const Icon(FeatherIcons.check,
                                  size: 16.0, color: Colors.white),
                              const SizedBox(width: 4.0),
                              Text(
                                '${widget.score}/${widget.quizzes.questions!.length}',
                                style: TextStyle(
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(6.0),
                            color: const Color(0xFF2F81E8),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              const Icon(FeatherIcons.x,
                                  color: Colors.white, size: 16.0),
                              const SizedBox(width: 4.0),
                              Text(
                                '${widget.quizzes.questions!.length - widget.score.toInt()}/${widget.quizzes.questions!.length}',
                                style: TextStyle(
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: CircularPercentIndicator(
                      radius: 40.0,
                      progressColor: AppColor.mainColor,
                      circularStrokeCap: CircularStrokeCap.round,
                      lineWidth: 5.0,
                      animation: true,
                      percent: (widget.score.toInt()/widget.quizzes.questions!.length),
                      center: Text(
                        "${((widget.score.toInt()/widget.quizzes.questions!.length)* 100).toInt()}%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(6.0),
                            color: const Color(0xFFFF8244),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              const Icon(FeatherIcons.award,
                                  color: Colors.white, size: 16.0),
                              const SizedBox(width: 4.0),
                              Text(
                                widget.quizzes.rewardPoint.toString(),
                                style: TextStyle(
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(6.0),
                            color: const Color(0xFF4EB000),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              const Icon(FeatherIcons.database,
                                  color: Colors.white, size: 16.0),
                              const SizedBox(width: 4.0),
                              Text(
                                widget.quizzes.questions!.length.toString(),
                                style: TextStyle(
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Card(
                elevation: 1.0,
                color: AppColor.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ListTile(
                  onTap: (() => showPopUp(widget.quizzes.retakePoint.toString())),
                  title: Text(
                    'Play again',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Card(
                elevation: 1.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ListTile(
                  onTap: () {
                  },
                  title: const Text(
                    'Share Score',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.titleColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Card(
                elevation: 1.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ListTile(
                  onTap: () {
                    setState(() {
                      const Home().launch(context);
                    });
                  },
                  title: const Text(
                    'Home',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.titleColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
