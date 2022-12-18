
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quiz_academy/style/app_colors.dart';

import 'home.dart';


class Victory extends StatefulWidget {
  const Victory({Key? key, required this.score, required this.questions, required this.point}) : super(key: key);
  final String score, questions,point;
  @override
  State<Victory> createState() => _VictoryState();
}

class _VictoryState extends State<Victory> {
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
              const Text(
                'Congratulation',
                style: TextStyle(color: AppColor.subTitleColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5.0),
              const Text(
                'VICTORY',
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
                    image: AssetImage('images/victory.png'),
                  ),
                ),
              ),
              Text(
                'Winner',
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
                                '${widget.questions}/${widget.questions}',
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
                                '0/${widget.questions}',
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
                      percent: 1,
                      center: const Text(
                        "100%",
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
                                widget.point,
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
                                widget.questions,
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
                  onTap: () {
                  },
                  title: Text(
                    'Share Score',
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
                    setState(() {
                      const Home().launch(context);
                    });
                  },
                  title: Text(
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
