import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:home_shield/domain/post/entities/comment.dart';
import 'package:home_shield/domain/post/entities/post.dart';
import 'package:home_shield/domain/post/repository/post_repository.dart';
import 'package:home_shield/domain/post/use_cases/get_post.dart';
import 'package:home_shield/service_locator.dart';
import 'package:meta/meta.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {

  NewsBloc() : super(NewsInitial()) {
    on<LoadData>(_onLoadData);
  }

  _onLoadData(LoadData event, Emitter<NewsState> emit) async {
    emit(NewsLoading());

    var data = await sl<GetPostUseCase>().call();
    data.fold((e) {
      emit(NewsError(e));
    }, (data) {
      print(data);
      emit(NewsShowData(data));
    });
  }
}
