import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_academy/provider/quiz_provider.dart';
import 'package:quiz_academy/style/app_colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_academy/ui/Home%20Screen/quiz_screen.dart';
import '../../model/Quiz_model.dart';
import '../../model/user_profile_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Color> colorList = [
    const Color(0xFFFF7288),
    const Color(0xFF8555EA),
    const Color(0xFF2F81E8),
    const Color(0xFFFF8244),
  ];

  bool isBalanceShow = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, watch) {
      AsyncValue<UserProfileModel> userInfo = ref.watch(personalProfileProvider);
      AsyncValue<QuizModel> allQuiz = ref.watch(quizProvider);
      return userInfo.when(data: (info) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 90,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
              ),
            ),
            backgroundColor: AppColor.mainColor,
            elevation: 0.0,
            title: const Text(
              'Quiz',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: allQuiz.when(data: (quiz) {
            return quiz.data!.categoryQuiz!.isNotEmpty ? RefreshIndicator(
              onRefresh: () async => ref.refresh(quizProvider),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10.0),
                      ListView.builder(
                          itemCount: quiz.data?.categoryQuiz?.length ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, i) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: ExpansionTile(
                                initiallyExpanded: i == 0 ? true : false,
                                iconColor: Colors.white,
                                collapsedBackgroundColor: colorList[i % 4],
                                backgroundColor: colorList[i % 4],
                                title: Text(
                                  quiz.data!.categoryQuiz![i].name ?? '',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                    quiz.data!.categoryQuiz![i].image ?? '',
                                  ),
                                ),
                                children: [
                                  ListView.builder(
                                      itemCount: quiz.data?.categoryQuiz?[i].quizzes?.length ?? 0,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, index) {
                                        return Container(
                                          color: Colors.white,
                                          child: ListTile(
                                            onTap: () {
                                              QuizScreen(quizzes: quiz.data!.categoryQuiz![i].quizzes![index]).launch(context);
                                            },
                                            contentPadding: EdgeInsets.zero,
                                            leading: CircleAvatar(
                                              backgroundColor: AppColor.mainColor.withOpacity(0.1),
                                              radius: 20,
                                              backgroundImage: NetworkImage(
                                                quiz.data!.categoryQuiz![i].quizzes![index].image ?? '',
                                              ),
                                            ),
                                            title: Text(
                                              quiz.data!.categoryQuiz![i].quizzes![index].name ?? '',
                                              style: const TextStyle(color: AppColor.titleColor, fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              'Entry Fee: ${quiz.data!.categoryQuiz![i].quizzes![index].paidStatus == 0 ? 'Free' : quiz.data!.categoryQuiz![i].quizzes![index].freeOrPaid.toString()} || Reward Point: ${quiz.data!.categoryQuiz![i].quizzes![index].rewardPoint}',
                                              style: const TextStyle(color: AppColor.subTitleColor),
                                            ),
                                            trailing: const Icon(FeatherIcons.chevronRight, color: AppColor.subTitleColor),
                                          ),
                                        );
                                      },),
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
            ) : const Center(child: Text('No Quiz Found'),);
          }, error: (e, stack) {
            return Center(
              child: Text(e.toString()),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        );
      }, error: (e, stack) {
        return Center(
          child: Text(e.toString()),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
    });
  }
}
