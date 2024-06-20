import 'package:word_game/features/home/data/models/cache_model.dart';

abstract class EditCoinsState {}

class EditCoinsInitialState extends EditCoinsState {}

class EditCoinsLoadingState extends EditCoinsState {}

class EditCoinsSuccessState extends EditCoinsState {
  CacheModel cacheModel;
  EditCoinsSuccessState({required this.cacheModel});
}

class EditCoinsErrorState extends EditCoinsState {
  String error;
  EditCoinsErrorState({required this.error});
}
