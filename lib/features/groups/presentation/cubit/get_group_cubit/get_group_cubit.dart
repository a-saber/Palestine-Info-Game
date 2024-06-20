import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/core/models/response_model.dart';
import 'package:word_game/features/groups/data/repo/group_repo/group_repo_imp.dart';
import 'package:word_game/features/groups/presentation/cubit/get_group_cubit/get_group_state.dart';

class GetGroupCubit extends Cubit<GetGroupState> {
  GetGroupCubit(this.groupRepoImp) : super(GetGroupInitialState());
  final GroupRepoImp groupRepoImp;
  static GetGroupCubit get(context) => BlocProvider.of(context);

  GroupResponse? groupResponse;

  Future getCurrentGroup() async {
    emit(GetGroupLoadingState());
    var response = await groupRepoImp.getGroup();
    response.fold((error) => emit(GetGroupErrorState(error: error)), (result) {
      groupResponse = result;
      emit(result!.getGroupState);
    });
  }
}
