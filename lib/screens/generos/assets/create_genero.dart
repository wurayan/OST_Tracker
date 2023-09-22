import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/dialog/form_dialog.dart';
import 'package:ost_tracker_og/components/oneline_textformfield.dart';
import 'package:ost_tracker_og/models/genero_model.dart';
import 'package:ost_tracker_og/service/genero.dart';

class CreateGenero extends StatelessWidget {
  CreateGenero({super.key});

  final TextEditingController _generoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      save: _salvar,
      formKey: _formKey,
      children: [
        OnelineTextformfield(
          controller: _generoController,
          hintText: "Gênero",
          validator: (value) =>
              value == null || value.isEmpty ? "Campo Obrigatório!" : null,
        ),
      ],
    );
  }

  Future<void> _salvar(context) async {
    final GeneroFirestore genero = GeneroFirestore();
    if (_formKey.currentState!.validate()) {
      await genero.saveGenero(Genero(
          id: "", nome: _generoController.text, dono: "", publico: false));
      Navigator.pop(context);
    }
  }
}
