import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/dialog/add_genero_dialog.dart';
import 'package:ost_tracker_og/components/genero_chip.dart';
import 'package:ost_tracker_og/models/genero_model.dart';

class GeneroWrap extends StatefulWidget {
  final List<Genero> generos;
  const GeneroWrap({super.key, required this.generos});

  @override
  State<GeneroWrap> createState() => _GeneroWrapState();
}

class _GeneroWrapState extends State<GeneroWrap> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      children: [..._generoChipBuilder()],
    );
  }

  List<Widget> _generoChipBuilder() {
    List<Widget> widgets = [
      GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AddGeneroDialog(generos: widget.generos),
            ).then((value) {
              setState(() {});
            });
          },
          child: GeneroChip(genero: Genero.addGenero))
    ];
    widgets.addAll(widget.generos.map((e) => GeneroChip(genero: e)).toList());
    return widgets;
  }
}
