import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ost_tracker_og/components/appbar/appbar_custom.dart';
import 'package:ost_tracker_og/components/drawer/drawer_custom.dart';
import 'package:ost_tracker_og/components/empty_screen.dart';
import 'package:ost_tracker_og/components/fab.dart';
import 'package:ost_tracker_og/components/loading.dart';
import 'package:ost_tracker_og/cubit/artista_cubit.dart';
import 'package:ost_tracker_og/cubit/generic_state.dart';
import 'package:ost_tracker_og/screens/artistas/assets/artista_card.dart';
import 'package:ost_tracker_og/screens/artistas/create_artista.dart';

class ArtistaScreen extends StatefulWidget {
  const ArtistaScreen({super.key});

  @override
  State<ArtistaScreen> createState() => _ArtistaScreenState();
}

class _ArtistaScreenState extends State<ArtistaScreen> {
  final ArtistaCubit _artista = ArtistaCubit();

  @override
  void initState() {
    _artista.getArtistas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCustom(
        title: "Artistas",
        activeSearch: true,
      ),
      floatingActionButton: Fab(
          title: "ADD ARTISTA",
          function: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateArtista(),
              ))),
      drawer: const DrawerCustom(),
      body: BlocBuilder<ArtistaCubit, GenericState>(
        bloc: _artista,
        builder: (context, state) {
          if (state is ArtistaLoading) {
            return const Loading();
          } else if (state is ArtistaError) {
            return Empty(msg: state.msg);
          } else if (state is ArtistaEmpty) {
            return Empty(msg: state.msg);
          } else if (state is ArtistaSuccess) {
            return ListView.builder(
              itemCount: state.artistas.length,
              itemBuilder: (context, index) =>
                  ArtistaCard(artista: state.artistas[index]),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
