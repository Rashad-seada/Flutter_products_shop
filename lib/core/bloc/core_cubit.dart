import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

part 'core_state.dart';

class CoreCubit extends Cubit<CoreState> {

  static init() async {
    await EasyLocalization.ensureInitialized();
  }

  CoreCubit() : super(CoreInitial());
}
