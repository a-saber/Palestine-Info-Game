import 'package:word_game/features/home/data/models/cache_model.dart';
import 'package:word_game/features/question/presentation/cubit/que_up_cubit/que_up_state.dart';

class QueUpResponse {
  CacheModel cacheModel;
  QueUpState queUpState;
  QueUpResponse({required this.cacheModel, required this.queUpState});
}

enum EditCoinsType { praise, question, help }
