part of "harajat_bloc.dart";

sealed class HarajatState {}

final class InitialHarajatState extends HarajatState {}

final class LoadingHarajatState extends HarajatState {}

final class LoadedHarajatState extends HarajatState {
  final List<HarajatModel> harajat;
  LoadedHarajatState({required this.harajat});
}

final class ErrorHarajatState extends HarajatState {
  final String message;
  ErrorHarajatState({required this.message});
}
