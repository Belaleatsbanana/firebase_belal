abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}

class CategoryLoaded extends CategoryState {}
