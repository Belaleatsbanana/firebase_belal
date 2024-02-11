import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_belal/cubit/profile_state.dart';
import 'package:firebase_belal/data_model/user_data_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> getUserDataFromFireStoreDataBase() async {
    try {
      emit(ProfileLoading());
      String uid = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((value) {
        emit(ProfileLoaded(userData: UserDataModel.fromDoc(value)));
      });
    } catch (error) {
      emit(ProfileError(error: 'Error: $error'));
    }
  }

  ImagePicker picker = ImagePicker();

  Future<void> pickImageAndUploadToFireStoreDataBase() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(ProfileUploading());
      await uploadImageToFireBase(image: File(image.path)).then((value) {
        getUserDataFromFireStoreDataBase();
      });
    }
  }

  Future<void> uploadImageToFireBase({
    required File image,
  }) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      final ref =
      FirebaseStorage.instance.ref().child('userImages').child('$uid.jpg');

      await ref.putFile(image);

      final imageUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        "userImage": imageUrl,
      });
    } catch (error) {
      emit(ProfileError(error: 'Error: $error'));
    }
  }
}
