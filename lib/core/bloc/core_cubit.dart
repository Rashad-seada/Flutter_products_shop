import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';

part 'core_state.dart';

class CoreCubit extends Cubit<CoreState> {

  static init() async {
    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  CoreCubit() : super(CoreInitial());
}
