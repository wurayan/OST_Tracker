import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/dialog/form_dialog.dart';
import 'package:ost_tracker_og/components/multiline_textformfield.dart';
import 'package:ost_tracker_og/components/oneline_textformfield.dart';
import 'package:ost_tracker_og/models/tag_model.dart';
import 'package:ost_tracker_og/service/tag.dart';

class CreateTag extends StatelessWidget {
  CreateTag({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      save: _salvar,
      formKey: _formKey,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: OnelineTextformfield(
            controller: _nomeController,
            hintText: "Nome da Tag",
            validator: (e) =>
                e == null || e.isEmpty ? "Campo Obrigatório" : null,
          ),
        ),
        MultilineTextformfield(
          controller: _descricaoController,
          hintText: "Descrição da Tag...",
        ),
      ],
    );
  }

  Future<void> _salvar(context) async {
    final TagFirestore tag = TagFirestore();
    if (_formKey.currentState!.validate()) {
      await tag.saveTag(Tag(
          id: "",
          nome: _nomeController.text,
          descricao: _descricaoController.text,
          dono: "",
          publico: false));
      Navigator.pop(context, true);
    }
  }
}
