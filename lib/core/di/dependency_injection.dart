import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;
void setUpGetIt() {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
}
