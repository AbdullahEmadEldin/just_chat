import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../modules/auth/data/models/user_model.dart';

class FirebaseGeneralServices {
  static Future<UserModel> getUserById(String userId) async {
    try {
      final userRef =
          getIt<FirebaseFirestore>().collection('users').doc(userId);
      final userSnapshot = await userRef.get();
      print('10000 A7A');
      return UserModel.fromMap(userSnapshot.data()!);
    } catch (e) {
      print('error getting user model ------>>>>>> ${e.toString()}');
      rethrow;
    }
  }
}
