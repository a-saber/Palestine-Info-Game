abstract class CacheState {}

class CacheInitialState extends CacheState {}

class CacheLoadingState extends CacheState {}

class CacheSuccessState extends CacheState {}

class CacheErrorState extends CacheState {
  String error;
  CacheErrorState({required this.error});
}
