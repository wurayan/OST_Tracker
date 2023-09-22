import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ost_tracker_og/components/appbar/appbar_custom.dart';
import 'package:ost_tracker_og/components/drawer/drawer_custom.dart';
import 'package:ost_tracker_og/components/empty_screen.dart';
import 'package:ost_tracker_og/components/fab.dart';
import 'package:ost_tracker_og/components/loading.dart';
import 'package:ost_tracker_og/cubit/playlist_cubit.dart';
import 'package:ost_tracker_og/screens/playlist/assets/playlist_list.dart';
import 'package:ost_tracker_og/screens/playlist/create_playlist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PlaylistCubit _playlist = PlaylistCubit();

  @override
  void initState() {
    _playlist.getPlaylists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(
        title: "OST-Tracker",
        activeSearch: true,
        onChanged: (value) {
          _playlist.searchPlaylists(value);
        },
        onFieldSubmitted: (value) {
          _playlist.searchPlaylists(value);
        },
        cancelSearch: () {
          _playlist.getPlaylists();
        },
      ),
      drawer: const DrawerCustom(),
      floatingActionButton: Fab(
        title: 'PLAYLIST',
        function: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreatePlaylist(),
          ),
        ).then((value) => _playlist.getPlaylists()),
      ),
      body: BlocBuilder<PlaylistCubit, PlaylistStates>(
        bloc: _playlist,
        builder: (context, state) {
          if (state is PLaylistLoading) {
            return const Loading();
          } else if (state is PlaylistSuccess) {
            return PlaylistList(playlists: state.playlists);
          } else if (state is PlaylistEmpty) {
            return Empty(msg: state.msg);
          } else if (state is PlaylistError) {
            return Empty(msg: state.msg);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
