part of 'genero_cubit.dart';

class GeneroLoading extends GenericState {}

class GeneroSuccess extends GenericState {
  final List<Genero> generos;
  GeneroSuccess(this.generos);
}

class GeneroEmpty extends GenericState {
  final String msg;
  GeneroEmpty(this.msg);
}

class GeneroError extends GenericState {
  final String msg;
  GeneroError(this.msg);
}
