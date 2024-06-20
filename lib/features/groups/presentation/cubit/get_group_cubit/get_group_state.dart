abstract class GetGroupState {}

class GetGroupInitialState extends GetGroupState {}

class GetGroupLoadingState extends GetGroupState {}

class GetGroupSuccessState extends GetGroupState {}

class GetGroupAllDoneState extends GetGroupState {}

class GetGroupErrorState extends GetGroupState {
  String error;
  GetGroupErrorState({required this.error});
}
