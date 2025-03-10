import 'package:equatable/equatable.dart';

sealed class FavoriteOperationResultState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteOperationNoneState extends FavoriteOperationResultState {}

class FavoriteOperationLoadingState extends FavoriteOperationResultState {}

class FavoriteOperationErrorState extends FavoriteOperationResultState {
  final String error;

  FavoriteOperationErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class FavoriteOperationSuccessState extends FavoriteOperationResultState {
  final String message;

  FavoriteOperationSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}
