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

      emit(
        NotesCubitSuccess(List.from(notesBox.values)),
      ); // هنا دي هي updatedNotes
    } catch (e) {
      emit(NotesCubitError("فشل في الإضافة"));
    }
  }

  // Future<void> deleteNote(NoteModel note) async {
  //   emit(NotesActionInProgress());
  //   try {
  //     await notesRepository.deleteNote(note); // حذف من الداتا

  //     notes.remove(note); // نحذفها من القائمة اللي عندنا
  //     emit(NotesActionSuccess("تم الحذف بنجاح"));

  //     emit(NotesCubitSuccess(List.from(notes))); // دي برضه updatedNotes
  //   } catch (e) {
  //     emit(NotesCubitError("فشل في الحذف"));
  //   }
  // }

  // Future<void> updateNote(NoteModel note) async {
  //   emit(NotesActionInProgress());
  //   try {
  //     await notesRepository.updateNote(note); // تحديث في الداتا سورس

  //     notes.remove(note); // نحذفها من القائمة اللي عندنا
  //     notes.add(note); // نضيفها للقائمة اللي عندنا
  //     emit(NotesActionSuccess("تم التحديث بنجاح"));

  //     emit(NotesCubitSuccess(List.from(notes))); // دي برضه updatedNotes
  //   } catch (e) {
  //     emit(NotesCubitError("فشل في التحديث"));
  //   }

  //   Future<void> getNotes() async {
  //     emit(NotesCubitLoading());
  //     try {
  //       notes = await notesRepository.getNotes(); // تحديث في الداتا سورس
  //       emit(NotesCubitSuccess(List.from(notes))); // دي برضه updatedNotes
  //     } catch (e) {
  //       emit(NotesCubitError("فشل في التحديث"));
  //     }
  //   }
  // }
}
