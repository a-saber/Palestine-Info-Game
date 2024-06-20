import 'package:get_it/get_it.dart';
import 'package:word_game/features/groups/data/repo/group_repo/group_repo_imp.dart';
import 'package:word_game/features/home/data/repo/home_repo/home_repo_imp.dart';
import 'package:word_game/features/question/data/repo/question_repo/question_repo_imp.dart';

final getIt = GetIt.instance;

void setupForgotPassSingleton() {
  getIt.registerSingleton<HomeRepoImp>(HomeRepoImp());
  getIt.registerSingleton<GroupRepoImp>(GroupRepoImp());
  getIt.registerSingleton<QuestionRepoImp>(QuestionRepoImp());
}
