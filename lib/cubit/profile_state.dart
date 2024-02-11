import 'package:finalicthub/data_model/user_data_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileUploading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  UserDataModel userData;

  ProfileLoaded({required this.userData});
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError({required this.error});
}
