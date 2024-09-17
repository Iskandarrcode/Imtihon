import 'package:bloc/bloc.dart';
import 'package:exem_6/data/models/daromad_models.dart';
import 'package:exem_6/data/models/harajat_model.dart';
import 'package:exem_6/data/services/daromad_services.dart';

part 'daromad_event.dart';
part 'daromad_state.dart';

class DaromadBloc extends Bloc<DaromadEvent, DaromadState> {
  final daromadServices = DaromadServices();
  DaromadBloc() : super(InitialDaromadState()) {
    on<GetDaromadEvent>(_getDaromad);
    on<AddDaromadEvent>(_addDaromad);
    on<EditDaromadEvent>(_ediDaromad);
    on<DeleteDaromadEvent>(_deleteDaromad);
  }

  void _getDaromad(GetDaromadEvent event, emit) async {
    emit(LoadingDaromadState());
    try {
      await daromadServices.getDaromad();
      emit(LoadedDaromadState(harajat: event.harjatlar));
    } catch (e) {
      print("Get qilishda hatolik: $e");
      emit(ErrorDaromadState(message: e.toString()));
    }
  }

  void _addDaromad(AddDaromadEvent event, emit) async {
    emit(LoadingDaromadState());
    try {
      final harajat = HarajatModel(
        id: 0,
        summa: event.summa,
        category: event.category,
        sana: event.sana,
        izoh: event.izoh,
      );
      await daromadServices.addDaromad(harajat);
      InitialDaromadState();
    } catch (e) {
      print("Add Harajat Error: $e");
      emit(ErrorDaromadState(message: e.toString()));
    }
  }

  void _ediDaromad(EditDaromadEvent event, emit) async {
    emit(LoadingDaromadState());
    try {
      final harajat = HarajatModel(
        id: 0,
        summa: event.newSumma,
        category: event.newCategory,
        sana: event.newSana,
        izoh: event.newIzoh,
      );
      await daromadServices.editDaromad(harajat);
      InitialDaromadState();
    } catch (e) {
      print("Edit Harajat Error: $e");
      emit(ErrorDaromadState(message: e.toString()));
    }
  }

  void _deleteDaromad(DeleteDaromadEvent event, emit) async {
    emit(LoadingDaromadState());
    try {
      await daromadServices.deleteDaromad(event.id);
      InitialDaromadState();
    } catch (e) {
      print("Delete Harajat Error: $e");
      emit(ErrorDaromadState(message: e.toString()));
    }
  }
}
