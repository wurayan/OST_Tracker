import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ost_tracker_og/components/appbar/appbar_custom.dart';
import 'package:ost_tracker_og/components/drawer/drawer_custom.dart';
import 'package:ost_tracker_og/components/empty_screen.dart';
import 'package:ost_tracker_og/components/fab.dart';
import 'package:ost_tracker_og/components/loading.dart';
import 'package:ost_tracker_og/cubit/musica_cubit.dart';
import 'package:ost_tracker_og/screens/musica/assets/musica_list.dart';
import 'package:ost_tracker_og/screens/musica/create_musica.dart';

class MusicaScreen extends StatefulWidget {
  const MusicaScreen({super.key});

  @override
  State<MusicaScreen> createState() => _MusicaScreenState();
}

class _MusicaScreenState extends State<MusicaScreen> {
  final MusicaCubit _musica = MusicaCubit();

  @override
  void initState() {
    _musica.getMusicas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(
        title: "Músicas",
        activeSearch: true,
        onFieldSubmitted: (value) {
          value.isEmpty ? _musica.getMusicas() : _musica.searchMusica(value);
        },
        onChanged: (value) {
          value.isEmpty ? _musica.getMusicas() : _musica.searchMusica(value);
        },
        cancelSearch: () {
          _musica.getMusicas();
        },
      ),
      floatingActionButton: Fab(
        title: "MÚSICA",
        function: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateMusica(),
          ),
        ),
      ),
      drawer: const DrawerCustom(),
      body: BlocBuilder<MusicaCubit, MusicaStates>(
        bloc: _musica,
        builder: (context, state) {
          if (state is MusicaLoading) {
            return const Loading();
          } else if (state is MusicaSuccess) {
            return MusicaList(musicas: state.musicas);
          } else if (state is MusicaEmpty) {
            return Empty(msg: state.msg);
          } else if (state is MusicaError) {
            return Empty(msg: state.error);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
