import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UpdateImageProfile {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  updateImageProfile(imgUrl, context) async {
    var userInfo = UserUpdateInfo();

    userInfo.photoUrl = imgUrl;
    auth.currentUser().then((user){
      user.updateProfile(userInfo);
      firestore.collection('users')
      .where('uid', isEqualTo: user.uid)
      .getDocuments()
      .then((docs){
        firestore.document('users/${docs.documents[0].documentID}')
        .updateData({
          'imgpro': imgUrl
        }).then((_){
          debugPrint('update image profile success');
        }).catchError((e){

          debugPrint('update image profile err: $e');
        });
      });
    });
  }
}