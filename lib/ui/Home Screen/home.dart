import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_academy/provider/quiz_provider.dart';
import 'package:quiz_academy/style/app_colors.dart';

import '../../model/Quiz_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Academy'),
        centerTitle: true,
        backgroundColor: AppColor.mainColor,
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          AsyncValue<QuizModel> quizList = ref.watch(quizProvider);
          return quizList.when(data: (quiz) {
            return ListView.builder(
                itemCount: quiz.data?.categoryQuiz?.length ?? 0,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: AppColor.mainColor,
                        radius: 50.0,
                        backgroundImage: NetworkImage(quiz.data?.categoryQuiz?[index].image?.toString() ?? ''),
                      ),
                      title: Text(
                        quiz.data?.categoryQuiz?[index].name?.toString() ?? '',
                        style: const TextStyle(color: AppColor.titleColor, fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      subtitle: Text(
                        quiz.data?.categoryQuiz?[index].description?.toString() ?? '',
                        style: const TextStyle(color: AppColor.subTitleColor),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${quiz.data?.categoryQuiz?[index].quizzes?.length.toString() ?? ''} Quizzes',
                            style: const TextStyle(color: AppColor.subTitleColor),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: AppColor.secondaryColor,
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }, error: (e, stack) {
            return Center(
              child: Text(e.toString()),
            );
          }, loading: () {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.mainColor,
              ),
            );
          });
        },
      ),
    );
  }
}
