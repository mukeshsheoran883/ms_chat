import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ms_chat/ms_chat/model/chat_user.dart';

class APIs {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //for accessing cloud fireStore database
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

//for accessing cloud fireStore database
  static FirebaseStorage storage = FirebaseStorage.instance;

  // for accessing cloud fireStore database
  static late ChatUser me;

  // to return current user
  static User get user => auth.currentUser!;

  // for checking if user exists or not ?
  static Future<bool> userExists() async {
    return (await fireStore.collection('users').doc(user.uid).get()).exists;
  }

  // for getting current user info
  static Future<void> getSelfInfo() async {
    await fireStore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        log("My Data: ${user.data()}");
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  //for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
      image: user.photoURL.toString(),
      name: user.displayName.toString(),
      about: "Hey I'm using Ms Chat!",
      createdAt: time,
      isOnline: false,
      id: user.uid,
      lastActive: time,
      email: user.email.toString(),
      pushToken: '',
    );
    return await fireStore.collection('users').doc(user.uid).set(
          chatUser.toJson(),
        );
  }

  // for getting all users from fireStore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return fireStore
        .collection('users')
        .where(
          'id',
          isNotEqualTo: user.uid,
        )
        .snapshots();
  }

  // for updating user information
  static Future<void> updateUserInfo() async {
    await fireStore.collection('users').doc(user.uid).update(
      {
        'name': me.name,
        'about': me.about,
      },
    );
  }

  // update profile picture of user
  static Future<void> updateProfilePicture(File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    log(
      'Extension: $ext',
    );
    //storage file ref with path
    final ref = storage.ref().child(
          'profile_pictures/${user.uid}.$ext',
        );
    //uploading image
    await ref
        .putFile(
      file,
      SettableMetadata(contentType: 'image/$ext'),
    )
        .then(
      (p0) {
        log('Data Transferred : ${p0.bytesTransferred / 1000} kb');
      },
    );
    // updating image in fireStore database
    me.image = await ref.getDownloadURL();
    await fireStore.collection('users').doc(user.uid).update(
      {
        'image': me.image,
      },
    );
  }
  /// ******* Chat Screen Related APIs ********

  // for getting all users from fireStore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages() {
    return fireStore
        .collection('messages')
        .snapshots();
  }
}
