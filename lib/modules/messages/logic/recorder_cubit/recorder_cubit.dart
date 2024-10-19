import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'recorder_state.dart';

class RecorderCubit extends Cubit<RecorderState> {
  RecorderCubit() : super(RecorderInitial());

  //! ============================================================
  //! ================= Handling UI Logic ========================
  //! ============================================================

  void triggerRecordingView(){
    emit(RecorderViewTrigger());
  }
  void closeRecordingView(){
    emit(RecorderViewClose());
  }
}
