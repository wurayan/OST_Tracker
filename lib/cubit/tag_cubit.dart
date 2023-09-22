import 'package:bloc/bloc.dart';
import 'package:ost_tracker_og/cubit/generic_state.dart';
import 'package:ost_tracker_og/models/tag_model.dart';
import 'package:ost_tracker_og/service/tag.dart';

part 'tag_states.dart';

class TagCubit extends Cubit<GenericState> {
  TagCubit() : super(TagLoading());
  final TagFirestore _tag = TagFirestore();

  List<Tag> allTags = [];

  Future<void> getTags() async {
    try {
      final List<Tag> tags = await _tag.getTags();
      if (tags.isEmpty) {
        emit(TagEmpty("Não encontramos nenhuma TAG"));
      } else {
        allTags = tags;
        emit(TagSuccess(tags));
      }
    } catch (e) {
      emit(TagError(e.toString()));
    }
  }

  void searchTag(String search) {
    List<Tag> tags = allTags
        .where((e) => e.nome.toUpperCase().contains(search.toUpperCase()))
        .toList();
    if (tags.isEmpty) {
      emit(TagEmpty("Não encontramos nenhuma Tag com essa busca"));
    } else {
      emit(TagSuccess(tags));
    }
  }
}
