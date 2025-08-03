import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/data/models/note_model.dart';

part 'notes_cubit_state.dart';

class NotesCubit extends Cubit<NotesCubitState> {
  NotesCubit() : super(NotesCubitInitial());

  List<NoteModel> notes = [];

  void addNote(NoteModel note) {
    notes.add(note);
    emit(NotesCubitSuccess(notes));
  }

  void deleteNote(NoteModel note) {
    notes.remove(note);
    emit(NotesCubitSuccess(notes));
  }

  void updateNote(NoteModel note) {
    notes[notes.indexOf(note)] = note;
    emit(NotesCubitSuccess(notes));
  }

  Future<List<NoteModel>> getAllNotes() async {
    return notes;
  }
}
