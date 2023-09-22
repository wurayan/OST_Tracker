import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/appbar/appbar_custom.dart';
import 'package:ost_tracker_og/components/button_row.dart';
import 'package:ost_tracker_og/components/drawer/drawer_custom.dart';
import 'package:ost_tracker_og/components/multiline_textformfield.dart';
import 'package:ost_tracker_og/components/oneline_textformfield.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/genero_model.dart';
import 'package:ost_tracker_og/models/musica_model.dart';
import 'package:ost_tracker_og/models/tag_model.dart';
import 'package:ost_tracker_og/screens/musica/assets/add_genero.dart';
import 'package:ost_tracker_og/screens/musica/assets/add_tag.dart';
import 'package:ost_tracker_og/service/musica.dart';

class CreateMusica extends StatelessWidget {
  CreateMusica({super.key});

  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _artistaController = TextEditingController();
  final TextEditingController _anotacaoController = TextEditingController();
  final List<Genero> generos = [];
  final List<Tag> tags = [];
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar:
          const AppbarCustom(title: "Adicionar Música", activeSearch: false),
      drawer: const DrawerCustom(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
                    child: Container(
                      width: double.infinity,
                      height: height * 0.25,
                      color: ColorTheme.blackberry,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: OnelineTextformfield(
                      controller: _linkController,
                      hintText: "Link do YouTube",
                      validator: (value) => value == null || value.isEmpty
                          ? "Link é obrigatório!"
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: OnelineTextformfield(
                      controller: _nomeController,
                      hintText: "Nome da Música",
                      validator: (p0) => p0 == null || p0.isEmpty
                          ? "Nome é obrigatório!"
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: OnelineTextformfield(
                      controller: _artistaController,
                      hintText: "Artista/Banda",
                    ),
                  ),
                  MultilineTextformfield(
                    controller: _anotacaoController,
                    hintText: "Anotação...",
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: GeneroList(
                        generos: generos,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TagList(tags: tags),
                  ),
                  ButtonRow(function: () {
                    _salvar().then((value) => Navigator.pop(context));
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _salvar() async {
    if (_formkey.currentState!.validate()) {
      Musica musica = Musica(
          id: "",
          nome: _nomeController.text,
          artista: _artistaController.text,
          link: _linkController.text,
          generos: generos,
          tags: tags,
          anotacoes: _anotacaoController.text,
          dono: "",
          publico: false);
      final MusicaFirestore firestore = MusicaFirestore();
      await firestore.saveMusica(musica);
    }
  }
}
