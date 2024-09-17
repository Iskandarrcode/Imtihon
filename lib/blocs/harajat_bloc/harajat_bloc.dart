import 'package:bloc/bloc.dart';
import 'package:exem_6/data/models/harajat_model.dart';
import 'package:exem_6/data/services/harajat_services.dart';

part 'harajat_event.dart';
part 'harajat_state.dart';

class HarajatBloc extends Bloc<HarajatEvent, HarajatState> {
  final harajatServices = HarajatServices();
  HarajatBloc() : super(InitialHarajatState()) {
    on<GetHarajatEvent>(_getHarajat);
    on<AddHarajatEvent>(_addHarajat);
    on<EditHarajatEvent>(_editHarjat);
    on<DeleteHarajatEvent>(_deleteHarajat);
  }

  void _getHarajat(GetHarajatEvent event, emit) async {
    emit(LoadingHarajatState());
    try {
      await harajatServices.getHarajat();
      emit(LoadedHarajatState(harajat: event.harjatlar));
    } catch (e) {
      print("Get qilishda hatolik: $e");
      emit(ErrorHarajatState(message: e.toString()));
    }
  }

  void _addHarajat(AddHarajatEvent event, emit) async {
    emit(LoadingHarajatState());
    try {
      final harajat = HarajatModel(
        id: 0,
        summa: event.summa,
        category: event.category,
        sana: event.sana,
        izoh: event.izoh,
      );
      await harajatServices.addHarajat(harajat);
      InitialHarajatState();
    } catch (e) {
      print("Add Harajat Error: $e");
      emit(ErrorHarajatState(message: e.toString()));
    }
  }

  void _editHarjat(EditHarajatEvent event, emit) async {
    emit(LoadingHarajatState());
    try {
      final harajat = HarajatModel(
        id: 0,
        summa: event.newSumma,
        category: event.newCategory,
        sana: event.newSana,
        izoh: event.newIzoh,
      );
      await harajatServices.editHarajat(harajat);
      InitialHarajatState();
    } catch (e) {
      print("Edit Harajat Error: $e");
      emit(ErrorHarajatState(message: e.toString()));
    }
  }

  void _deleteHarajat(DeleteHarajatEvent event, emit) async {
    emit(LoadingHarajatState());
    try {
      await harajatServices.deleteHarajat(event.id);
      InitialHarajatState();
    } catch (e) {
      print("Delete Harajat Error: $e");
      emit(ErrorHarajatState(message: e.toString()));
    }
  }
}
