

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_academy/repo/quiz_repo.dart';

final quizProvider = FutureProvider((ref) => QuizRepo().getQuiz());