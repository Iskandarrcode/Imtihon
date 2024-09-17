part of "harajat_bloc.dart";

sealed class HarajatEvent {}

final class GetHarajatEvent extends HarajatEvent {
  List<HarajatModel> harjatlar;
  GetHarajatEvent({required this.harjatlar});
}

final class AddHarajatEvent extends HarajatEvent {
  final double summa;
  final String category;
  final String sana;
  final String izoh;

  AddHarajatEvent({
    required this.summa,
    required this.category,
    required this.sana,
    required this.izoh,
  });
}

final class EditHarajatEvent extends HarajatEvent {
  final double newSumma;
  final String newCategory;
  final String newSana;
  final String newIzoh;

  EditHarajatEvent({
    required this.newSumma,
    required this.newCategory,
    required this.newSana,
    required this.newIzoh,
  });
}

final class DeleteHarajatEvent extends HarajatEvent {
  final int id;
  DeleteHarajatEvent({required this.id});
}
