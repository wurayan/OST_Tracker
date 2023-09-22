import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ost_tracker_og/components/appbar/appbar_custom.dart';
import 'package:ost_tracker_og/components/drawer/drawer_custom.dart';
import 'package:ost_tracker_og/components/empty_screen.dart';
import 'package:ost_tracker_og/components/fab.dart';
import 'package:ost_tracker_og/components/loading.dart';
import 'package:ost_tracker_og/cubit/generic_state.dart';
import 'package:ost_tracker_og/cubit/tag_cubit.dart';
import 'package:ost_tracker_og/models/tag_model.dart';
import 'package:ost_tracker_og/screens/tags/assets/create_tag.dart';
import 'package:ost_tracker_og/screens/tags/assets/tag_item.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  final TagCubit _tag = TagCubit();

  @override
  void initState() {
    _tag.getTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(
        title: "Tags",
        activeSearch: true,
        onChanged: (value) {
          _tag.searchTag(value);
        },
        onFieldSubmitted: (value) {
          _tag.searchTag(value);
        },
        cancelSearch: () {
          _tag.getTags();
        },
      ),
      drawer: const DrawerCustom(),
      floatingActionButton: Fab(
        title: "CRIAR TAG",
        function: () =>
            showDialog(context: context, builder: (context) => CreateTag())
                .then((value) {
          if (value == true) _tag.getTags();
        }),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<TagCubit, GenericState>(
            bloc: _tag,
            builder: (context, state) {
              if (state is TagLoading) {
                return const Loading();
              } else if (state is TagEmpty) {
                return Empty(msg: state.msg);
              } else if (state is TagError) {
                return Empty(msg: state.msg);
              } else if (state is TagSuccess) {
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [..._tagBuilder(state.tags)],
                );
              } else {
                return const SizedBox();
              }
            },
          )),
    );
  }

  List<Widget> _tagBuilder(List<Tag> tags) {
    return List.from(tags.map((e) => TagItem(
          tag: e,
          callback: () => _tag.getTags(),
        )));
  }
}
