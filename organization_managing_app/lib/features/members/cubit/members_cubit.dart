import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organization_managing_app/core/error/failure.dart';
import 'package:organization_managing_app/core/locator/locator.dart';
import 'package:organization_managing_app/data/model/member_model.dart';
import 'package:organization_managing_app/data/provider/repository/members_repository.dart';

part 'members_state.dart';

class MembersCubit extends Cubit<MembersState> {
  final MembersRepository _membersRepository = locator<MembersRepository>();

  MembersCubit() : super(MembersInitial());

  void addMember({
    required MemberModel memberModel,
  }) async {
    emit(MembersLoading());

    final res = await _membersRepository.addMember(
      memberModel: memberModel,
    );

    res.fold((failure) => emit(MembersError(failure: failure)),
        (document) => emit(MembersAddEditDeleteSuccess()));
  }

  void getAllMembers() async {
    emit(MembersLoading());

    final res = await _membersRepository.getAllMembers();

    res.fold((failure) => emit(MembersError(failure: failure)),
        (membersList) => emit(MembersFetchSuccess(membersList: membersList)));
  }

  void editMember({
    required MemberModel memberModel,
  }) async {
    emit(MembersLoading());

    final res = await _membersRepository.editMember(
      memberModel: memberModel,
    );

    res.fold((failure) => emit(MembersError(failure: failure)),
        (document) => emit(MembersAddEditDeleteSuccess()));
  }
}