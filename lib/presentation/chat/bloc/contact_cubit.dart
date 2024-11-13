import 'package:bloc/bloc.dart';
import 'package:home_shield/domain/chat/entities/group.dart';
import 'package:home_shield/domain/chat/use_case/get_contact.dart';
import 'package:home_shield/service_locator.dart';
import 'package:meta/meta.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());

  loadContact() async {
    emit(ContactLoading());

    var useCase = sl<GetContactUseCase>();

    var data = await useCase.call();
    data.fold((e) {
      emit(ContactError(e));
    }, (data) {
      emit(ContactSuccess(data));
    });
  }
}
