import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/features/question/data/models/que_up_response.dart';
import 'package:word_game/features/question/data/repo/question_repo/question_repo_imp.dart';
import 'package:word_game/features/question/presentation/cubit/edit_coins_cubit/edit_coins_state.dart';

class EditCoinsCubit extends Cubit<EditCoinsState> {
  EditCoinsCubit(this.questionRepoImp) : super(EditCoinsInitialState());
  QuestionRepoImp questionRepoImp;
  static EditCoinsCubit get(context) => BlocProvider.of(context);

  Future editCoins({required EditCoinsType editCoinsType}) async {
    emit(EditCoinsLoadingState());
    var response =
        await questionRepoImp.editCoins(editCoinsType: editCoinsType);
    response.fold((error) => emit(EditCoinsErrorState(error: error)),
        (result) => emit(EditCoinsSuccessState(cacheModel: result)));
  }
}
