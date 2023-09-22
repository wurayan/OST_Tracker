import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/appbar/appbar_custom.dart';
import 'package:ost_tracker_og/components/button_row.dart';
import 'package:ost_tracker_og/components/drawer/drawer_custom.dart';
import 'package:ost_tracker_og/components/genero_chip.dart';
import 'package:ost_tracker_og/components/oneline_textformfield.dart';
import 'package:ost_tracker_og/models/genero_model.dart';
import 'package:ost_tracker_og/screens/artistas/assets/genero_wrap.dart';
import 'package:ost_tracker_og/screens/musica/assets/add_genero.dart';

class CreateArtista extends StatelessWidget {
  CreateArtista({super.key});

  final TextEditingController _nomeController = TextEditingController();
  final List<Genero> generos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const AppbarCustom(title: "Adicionar Artista", activeSearch: false),
      drawer: const DrawerCustom(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 16),
              child: OnelineTextformfield(
                controller: _nomeController,
                hintText: "Artista",
                validator: (e) =>
                    e == null || e.isEmpty ? "Campo Obrigatório" : null,
              ),
            ),
            GeneroWrap(generos: generos),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ButtonRow(function: () {}),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _salvar() async {}
}
