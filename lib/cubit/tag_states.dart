part of 'tag_cubit.dart';

class TagLoading extends GenericState {}

class TagSuccess extends GenericState {
  final List<Tag> tags;
  TagSuccess(this.tags);
}

class TagError extends GenericState {
  final String msg;
  TagError(this.msg);
}

class TagEmpty extends GenericState {
  final String msg;
  TagEmpty(this.msg);
}