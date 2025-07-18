import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';


class DatabaseService {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: 'https://generalizeddpp-default-rtdb.europe-west1.firebasedatabase.app/');

  // Create (Update)
  Future<void> create({
    required String path,
    required String data,
  }) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.set(data);
  }

  // Read
  Future<DataSnapshot?> read({
    required String path
    }) async {
      final DatabaseReference ref = _firebaseDatabase.ref().child(path);
      final DataSnapshot snapshot = await ref.get();
      return snapshot.exists ? snapshot : null;
    }
  
  // Update
  Future<void> update({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.update(data);
  }

  // Delet
  Future<void> delete({
    required String path
  }) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.remove();
  }
}