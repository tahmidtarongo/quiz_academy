

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_academy/repo/quiz_repo.dart';

import '../repo/auth_repo.dart';
final personalProfileProvider = FutureProvider((ref) {
  return AuthRepo().userProfileInfo();
});
final quizProvider = FutureProvider((ref) => QuizRepo().getQuiz());