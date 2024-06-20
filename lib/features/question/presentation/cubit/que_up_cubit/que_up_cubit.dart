import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/features/question/data/repo/question_repo/question_repo_imp.dart';
import 'package:word_game/features/question/presentation/cubit/que_up_cubit/que_up_state.dart';

class QueUpCubit extends Cubit<QueUpState> {
  QueUpCubit(this.questionRepoImp) : super(QueUpInitialState());
  QuestionRepoImp questionRepoImp;
  static QueUpCubit get(context) => BlocProvider.of(context);

  Future questionUp() async {
    emit(QueUpLoadingState());
    var response = await questionRepoImp.questionUp();
    response.fold((error) => emit(QueUpErrorState(error: error)),
        (result) => emit(result.queUpState));
  }
}
