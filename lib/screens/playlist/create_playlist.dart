import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/appbar/appbar_custom.dart';
import 'package:ost_tracker_og/components/button_row.dart';
import 'package:ost_tracker_og/components/drawer/drawer_custom.dart';
import 'package:ost_tracker_og/components/multiline_textformfield.dart';
import 'package:ost_tracker_og/components/oneline_textformfield.dart';
import 'package:ost_tracker_og/models/playlist_model.dart';
import 'package:ost_tracker_og/service/playlist.dart';

class CreatePlaylist extends StatelessWidget {
  CreatePlaylist({super.key});

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCustom(title: "Criar Playlist", activeSearch: false),
      drawer: const DrawerCustom(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              OnelineTextformfield(
                controller: _nomeController,
                hintText: "Nome da Playlist",
                validator: (value) => value == null || value.isEmpty
                    ? "Nome da Playlist é obrigatório!"
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 48),
                child: MultilineTextformfield(
                  controller: _descricaoController,
                  hintText: "Descrição da Playlist...",
                ),
              ),
              ButtonRow(
                  function: () =>
                      _salvar().then((value) => Navigator.pop(context)))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _salvar() async {
    if (_formKey.currentState!.validate()) {
      Playlist playlist = Playlist(
          id: "",
          nome: _nomeController.text,
          descricao: _descricaoController.text,
          dono: "",
          idMusicas: []);
      final PlaylistFirestore firestore = PlaylistFirestore();
      await firestore.savePlaylist(playlist);
    }
  }
}
