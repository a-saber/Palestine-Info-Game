import 'package:word_game/features/home/data/models/cache_model.dart';

abstract class RestartState {}

class RestartInitialState extends RestartState {}

class RestartLoadingState extends RestartState {}

class RestartSuccessState extends RestartState {
  CacheModel cacheModel;
  RestartSuccessState({required this.cacheModel});
}

class RestartErrorState extends RestartState {
  String error;
  RestartErrorState({required this.error});
}
