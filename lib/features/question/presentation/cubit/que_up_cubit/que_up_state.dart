abstract class QueUpState {}

class QueUpInitialState extends QueUpState {}

class QueUpLoadingState extends QueUpState {}

class QueUpSuccessState extends QueUpState {}

class QueLevelUpSuccessState extends QueUpState {}

class QueGameDoneSuccessState extends QueUpState {}

class QueUpErrorState extends QueUpState {
  String error;
  QueUpErrorState({required this.error});
}
