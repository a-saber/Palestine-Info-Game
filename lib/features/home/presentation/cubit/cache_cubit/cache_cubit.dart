import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/features/home/data/models/cache_model.dart';
import 'package:word_game/features/home/data/repo/home_repo/home_repo_imp.dart';
import 'package:word_game/features/home/presentation/cubit/cache_cubit/cache_state.dart';

class CacheCubit extends Cubit<CacheState> {
  CacheCubit(this.homeRepoImp) : super(CacheInitialState());
  HomeRepoImp homeRepoImp;
  static CacheCubit get(context) => BlocProvider.of(context);

  CacheModel? cacheModel;

  Future initCachData() async {
    emit(CacheLoadingState());
    var response = await homeRepoImp.initCachData();
    response.fold((error) => emit(CacheErrorState(error: error)), (result) {
      cacheModel = result;
      emit(CacheSuccessState());
    });
  }

  void assignCacheModel({required CacheModel cacheModel}) {
    this.cacheModel = cacheModel;
    emit(CacheSuccessState());
  }
}
