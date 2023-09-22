part of 'musica_cubit.dart';

abstract class MusicaStates {}

class MusicaLoading extends MusicaStates {}

class MusicaSuccess extends MusicaStates {
  final List<Musica> musicas;
  MusicaSuccess(this.musicas);
}

class MusicaEmpty extends MusicaStates {
  final String msg;
  MusicaEmpty(this.msg);
}

class MusicaError extends MusicaStates {
  final String error;
  MusicaError(this.error);
}
