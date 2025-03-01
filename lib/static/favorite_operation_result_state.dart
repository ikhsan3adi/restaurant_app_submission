sealed class FavoriteOperationResultState {}

class FavoriteOperationNoneState extends FavoriteOperationResultState {}

class FavoriteOperationLoadingState extends FavoriteOperationResultState {}

class FavoriteOperationErrorState extends FavoriteOperationResultState {
  final String error;

  FavoriteOperationErrorState(this.error);
}

class FavoriteOperationSuccessState extends FavoriteOperationResultState {
  final String message;

  FavoriteOperationSuccessState(this.message);
}
