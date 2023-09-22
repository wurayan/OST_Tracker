part of 'artista_cubit.dart';

class ArtistaSuccess extends GenericState {
  final List<Artista> artistas;
  ArtistaSuccess(this.artistas);
}

class ArtistaEmpty extends GenericState {
  final String msg;
  ArtistaEmpty(this.msg);
}

class ArtistaError extends GenericState {
  final String msg;
  ArtistaError(this.msg);
}

class ArtistaLoading extends GenericState{
  
}