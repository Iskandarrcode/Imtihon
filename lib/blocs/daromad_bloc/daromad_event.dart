part of "daromad_bloc.dart";

sealed class DaromadEvent {}

final class GetDaromadEvent extends DaromadEvent {
  List<DaromadModels> harjatlar;
  GetDaromadEvent({required this.harjatlar});
}

final class AddDaromadEvent extends DaromadEvent {
  final double summa;
  final String category;
  final String sana;
  final String izoh;

  AddDaromadEvent({
    required this.summa,
    required this.category,
    required this.sana,
    required this.izoh,
  });
}

final class EditDaromadEvent extends DaromadEvent {
  final double newSumma;
  final String newCategory;
  final String newSana;
  final String newIzoh;

  EditDaromadEvent({
    required this.newSumma,
    required this.newCategory,
    required this.newSana,
    required this.newIzoh,
  });
}

final class DeleteDaromadEvent extends DaromadEvent {
  final int id;
  DeleteDaromadEvent({required this.id});
}
