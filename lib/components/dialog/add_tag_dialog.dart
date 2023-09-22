import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ost_tracker_og/components/button_row.dart';
import 'package:ost_tracker_og/components/empty_screen.dart';
import 'package:ost_tracker_og/components/loading.dart';
import 'package:ost_tracker_og/components/oneline_textformfield.dart';
import 'package:ost_tracker_og/components/tag_chip.dart';
import 'package:ost_tracker_og/cubit/generic_state.dart';
import 'package:ost_tracker_og/cubit/tag_cubit.dart';
import 'package:ost_tracker_og/decoration/shadows.dart';
import 'package:ost_tracker_og/models/tag_model.dart';
import 'package:ost_tracker_og/service/tag.dart';

class AddTagDialog extends StatefulWidget {
  final List<Tag> tags;
  const AddTagDialog({super.key, required this.tags});

  @override
  State<AddTagDialog> createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {
  final TagCubit _tag = TagCubit();
  final TextEditingController _searchController = TextEditingController();

  getTags() {
    _tag.searchTag(_searchController.text);
  }

  @override
  void initState() {
    _tag.getTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    return Dialog(
      child: Container(
        height: height * 0.5,
        width: width * 0.9,
        decoration: BoxDecoration(
            boxShadow: const [Shadows.shadowBig],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 3,
              color: Colors.black,
            ),
            color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.62,
                  height: height * 0.06,
                  child: OnelineTextformfield(
                    controller: _searchController,
                    onChanged: (p0) => getTags(),
                    onFieldSubmitted: (p0) => getTags(),
                  ),
                ),
                GestureDetector(
                  onTap: () => _criarTag(),
                  child: const Icon(
                    Icons.add_circle_outline,
                    size: 32,
                  ),
                )
              ],
            ),
            BlocBuilder<TagCubit, GenericState>(
              bloc: _tag,
              builder: (context, state) {
                if (state is TagLoading) {
                  return const Loading();
                } else if (state is TagEmpty) {
                  return Empty(msg: state.msg);
                } else if (state is TagError) {
                  return Empty(msg: state.msg);
                } else if (state is TagSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      runSpacing: 6,
                      children: [..._chipBuilder(state.tags)],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            const Expanded(child: SizedBox()),
            ButtonRow(function: () => Navigator.pop(context, true))
          ],
        ),
      ),
    );
  }

  List<Widget> _chipBuilder(List<Tag> lista) {
    return List.from(lista.map((e) => GestureDetector(
        onTap: () => _addTag(e),
        child: TagChip(
          tag: e,
          selected: widget.tags.contains(e),
        ))));
  }

  _addTag(Tag tag) {
    if (widget.tags.contains(tag)) {
      widget.tags.removeWhere((element) => element == tag);
    } else {
      widget.tags.add(tag);
    }
    if (mounted) setState(() {});
  }

  _criarTag() async {
    if (_searchController.text.isEmpty) return;
    final TagFirestore firestore = TagFirestore();
    firestore.saveTag(Tag(
        id: "",
        nome: _searchController.text,
        descricao: "Sem Descrição",
        dono: "",
        publico: false));
  }
}
