part of 'notes_cubit_cubit.dart';

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

final class NotesCubitError extends NotesCubitState {
  final String message;
  const NotesCubitError(this.message);

  @override
  List<Object> get props => [message];
}

final class NotesCubitLoading extends NotesCubitState {}
