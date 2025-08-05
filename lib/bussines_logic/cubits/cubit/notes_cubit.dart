import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../data/models/note_model.dart';

part 'notes_cubit_state.dart';

class NotesCubit extends Cubit<NotesCubitState> {
  NotesCubit() : super(NotesCubitInitial());

  List<NoteModel> allNotes = [];

  Future<void> addNote(NoteModel note) async {
    emit(NotesActionInProgress());
    try {
      var notesBox = Hive.box<NoteModel>('notes_box');
      await notesBox.add(note);

      emit(NotesActionSuccess("Note Added Successfully"));

      emit(NotesCubitSuccess(List.from(notesBox.values)));
    } catch (e) {
      emit(NotesActionError("Failed To Add Note"));
    }
  }

  Future<void> getNotes() async {
    emit(NotesCubitLoading());
    try {
      var notesBox = Hive.box<NoteModel>('notes_box');
      allNotes = List.from(notesBox.values);
      emit(NotesCubitSuccess(allNotes));
    } catch (e) {
      emit(NotesCubitError("Failed To Get Notes"));
    }
  }

  Future<void> deleteNote(NoteModel note) async {
    emit(NotesActionInProgress());
    try {
      var notesBox = Hive.box<NoteModel>('notes_box');
      await notesBox.delete(note.key);
      emit(NotesActionSuccess("Note Deleted Successfully"));
      emit(NotesCubitSuccess(List.from(notesBox.values)));
    } catch (e) {
      emit(NotesActionError("Failed To Delete Note"));
    }
  }

  Future<void> updateNote(NoteModel note) async {
    emit(NotesActionInProgress());
    try {
      await note.save();
      emit(NotesActionSuccess("Note Updated Successfully"));
      emit(
        NotesCubitSuccess(List.from(Hive.box<NoteModel>('notes_box').values)),
      );
    } catch (e) {
      emit(NotesActionError("Failed To Update Note"));
    }
  }

  Future<void> searchNotes(String query) async {
    emit(NotesCubitLoading());
    var notesBox = Hive.box<NoteModel>('notes_box');
    var searchResults = notesBox.values
        .where(
          (note) =>
              note.title.toLowerCase().contains(query) ||
              note.content.toLowerCase().contains(query),
        )
        .toList();
    emit(NotesSearchActionSuccess(searchResults));
    emit(NotesCubitSuccess(searchResults));
  }
}
