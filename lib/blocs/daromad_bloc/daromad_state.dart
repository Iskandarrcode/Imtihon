part of "daromad_bloc.dart";

sealed class DaromadState {}

final class InitialDaromadState extends DaromadState {}

final class LoadingDaromadState extends DaromadState {}

final class LoadedDaromadState extends DaromadState {
  final List<DaromadModels> harajat;
  LoadedDaromadState({required this.harajat});
}

final class ErrorDaromadState extends DaromadState {
  final String message;
  ErrorDaromadState({required this.message});
}
