import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../modules/auth/data/models/user_model.dart';

class FirebaseGeneralServices {
  static Future<UserModel> getUserById(String userId) async {
    try {
      final userRef =
          getIt<FirebaseFirestore>().collection('users').doc(userId);
      final userSnapshot = await userRef.get();
      return UserModel.fromMap(userSnapshot.data()!);
    } catch (e) {
      print('error getting user model ------>>>>>> ${e.toString()}');
      rethrow;
    }
  }

static  Future<String> getAppVar(
      {required String docName, required String varName}) async {
    final String variable = await getIt<FirebaseFirestore>()
        .collection('appVars')
        .doc(docName)
        .get()
        .then((value) {
      return value.data()![varName];
    });
    return variable;
  }

  static Future<void> logout() async {
    await getIt<FirebaseAuth>().signOut();
  }
}
