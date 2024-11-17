import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/domain/auth/use_cases/get_user.dart';
import 'package:home_shield/domain/post/repository/post_repository.dart';
import 'package:home_shield/service_locator.dart';
import 'package:meta/meta.dart';

part 'create_news_state.dart';

class CreateNewsCubit extends Cubit<CreateNewsState> {
  CreateNewsCubit() : super(CreateNewsInitial());

  loadCurrentUser() async {
    var useCase = sl<GetUserUseCase>();
    var data = await useCase.call();

    data.fold((e) {
      emit(CreateNewsError(e.toString()));
    }, (data) {
      emit(CreateNewsShowData(data));
    });
  }

  createNews(String content, File? imageFile, String? image) async {
    emit(CreateNewsLoading());

    var data = await sl<PostRepository>().savePost(content, imageFile, image);
    data.fold((e) {
      emit(CreateNewsError(e.toString()));
    }, (data) {
      emit(CreateNewsSuccess());
    });
  }

  generateImage(String content) async {
    emit(CreateNewsLoading());

    try {
      var useCase = sl<GetUserUseCase>();
      var dataUser = await useCase.call();

      UserApp user = UserApp();
      dataUser.fold((e) {}, (dataUser) {
        user = dataUser;
      });

      var data = await sl<PostRepository>().getImageGenerateLink(content);

      data.fold((e) {
        emit(CreateNewsError(e.toString()));
      }, (data) {
        emit(CreateNewsShowData(user, data));
      });
    } catch (e) {
      emit(CreateNewsError(e.toString()));
    }
  }
}
