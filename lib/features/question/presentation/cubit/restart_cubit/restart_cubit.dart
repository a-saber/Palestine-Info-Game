import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/features/question/data/repo/question_repo/question_repo_imp.dart';
import 'package:word_game/features/question/presentation/cubit/restart_cubit/restart_state.dart';

class RestartCubit extends Cubit<RestartState> {
  RestartCubit(this.questionRepoImp) : super(RestartInitialState());
  QuestionRepoImp questionRepoImp;
  static RestartCubit get(context) => BlocProvider.of(context);

  void restart() async {
    emit(RestartLoadingState());
    var response = await questionRepoImp.restart();
    response.fold((error) => emit(RestartErrorState(error: error)),
        (result) => emit(RestartSuccessState(cacheModel: result)));
  }
}
