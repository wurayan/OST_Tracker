import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ost_tracker_og/components/appbar/appbar_custom.dart';
import 'package:ost_tracker_og/components/drawer/drawer_custom.dart';
import 'package:ost_tracker_og/components/empty_screen.dart';
import 'package:ost_tracker_og/components/fab.dart';
import 'package:ost_tracker_og/components/loading.dart';
import 'package:ost_tracker_og/cubit/genero_cubit.dart';
import 'package:ost_tracker_og/models/genero_model.dart';
import 'package:ost_tracker_og/screens/generos/assets/create_genero.dart';
import 'package:ost_tracker_og/screens/generos/assets/genero_item.dart';

class GeneroScreen extends StatefulWidget {
  const GeneroScreen({super.key});

  @override
  State<GeneroScreen> createState() => _GeneroScreenState();
}

class _GeneroScreenState extends State<GeneroScreen> {
  final GeneroCubit _genero = GeneroCubit();

  @override
  void initState() {
    _genero.getGeneros();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(
        title: "Gêneros",
        activeSearch: true,
        onChanged: (value) {
          _genero.searchGenero(value);
        },
        onFieldSubmitted: (value) {
          _genero.searchGenero(value);
        },
        cancelSearch: () {
          _genero.getGeneros();
        },
      ),
      floatingActionButton: Fab(
          title: "ADD GÊNERO",
          function: () => showDialog(
                context: context,
                builder: (context) => CreateGenero(),
              ).then((value) => _genero.getGeneros())),
      drawer: const DrawerCustom(),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder(
            bloc: _genero,
            builder: (context, state) {
              if (state is GeneroLoading) {
                return const Loading();
              } else if (state is GeneroError) {
                return Empty(msg: state.msg);
              } else if (state is GeneroEmpty) {
                return Empty(msg: state.msg);
              } else if (state is GeneroSuccess) {
                return Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [..._generoBuilder(state.generos)],
                );
              } else {
                return const SizedBox();
              }
            },
          )),
    );
  }

  List<Widget> _generoBuilder(List<Genero> generos) {
    return List.from(generos.map((e) => GeneroItem(
          genero: e,
          callback: () => _genero.getGeneros(),
        )));
  }
}
