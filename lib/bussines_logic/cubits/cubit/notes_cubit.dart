import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/data/models/note_model.dart';

part 'notes_cubit_state.dart';

class NotesCubit extends Cubit<NotesCubitState> {
  NotesCubit() : super(NotesCubitInitial());

  Future<void> addNote(NoteModel note) async {
    emit(NotesActionInProgress());
    try {
      var notesBox = Hive.box<NoteModel>('notes_box');
      await notesBox.add(note);

      emit(NotesActionSuccess("تمت الإضافة بنجاح"));

      emit(NotesCubitSuccess(List.from(notesBox.values)));
    } catch (e) {
      emit(NotesActionError("فشل في الإضافة"));
    }
  }

  Future<void> getNotes() async {
    emit(NotesCubitLoading());
    try {
      var notesBox = Hive.box<NoteModel>('notes_box');
      emit(NotesCubitSuccess(List.from(notesBox.values)));
    } catch (e) {
      emit(NotesCubitError("فشل في جلب البيانات"));
    }
  }

  Future<void> deleteNote(NoteModel note) async {
    emit(NotesActionInProgress());
    try {
      var notesBox = Hive.box<NoteModel>('notes_box');
      await notesBox.delete(note.key);
      emit(NotesActionSuccess("تم الحذف بنجاح"));
      emit(NotesCubitSuccess(List.from(notesBox.values)));
    } catch (e) {
      emit(NotesActionError("فشل في الحذف"));
    }
  }

  Future<void> updateNote(NoteModel note) async {
    emit(NotesActionInProgress());
    try {
      await note.save(); // ✅ يحدث النوت مباشرة
      emit(NotesActionSuccess("تم التحديث بنجاح"));
      emit(
        NotesCubitSuccess(List.from(Hive.box<NoteModel>('notes_box').values)),
      );
    } catch (e) {
      emit(NotesActionError("فشل في التحديث"));
    }
  }
}
