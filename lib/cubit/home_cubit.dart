import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalicthub/cubit/home_state.dart';
import 'package:finalicthub/data_model/category_data_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<CategoryDataModel> categorise = [];

  Future<void> getCategoriseFromDatabase() async {
    try {
      emit(HomeLoading());

      await FirebaseFirestore.instance
          .collection('categories')
          .get()
          .then((value) {
        for (var c in value.docs) {
          categorise.add(CategoryDataModel.fromDoc(c.data()));
        }
        emit(HomeLoaded());
      });
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
