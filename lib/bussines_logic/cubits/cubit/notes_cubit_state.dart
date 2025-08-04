part of 'notes_cubit.dart';

sealed class NotesCubitState extends Equatable {
  const NotesCubitState();

  @override
  List<Object> get props => [];
}

final class NotesCubitInitial extends NotesCubitState {}

final class NotesCubitSuccess extends NotesCubitState {
  final List<NoteModel> notes;
  const NotesCubitSuccess(this.notes);
}

final class NotesActionInProgress extends NotesCubitState {}

final class NotesActionSuccess extends NotesCubitState {
  final String message;
  const NotesActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class NotesSearchActionSuccess extends NotesCubitState {
  final List<NoteModel> filteredNotes;
  const NotesSearchActionSuccess(this.filteredNotes);

  @override
  List<Object> get props => [filteredNotes];
}

final class NotesActionError extends NotesCubitState {
  final String message;
  const NotesActionError(this.message);
}

final class NotesCubitError extends NotesCubitState {
  final String message;
  const NotesCubitError(this.message);

  @override
  List<Object> get props => [message];
}

final class NotesCubitLoading extends NotesCubitState {}
