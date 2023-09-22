import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/dialog/add_genero_dialog.dart';
import 'package:ost_tracker_og/components/genero_chip.dart';
import 'package:ost_tracker_og/models/genero_model.dart';

class GeneroList extends StatefulWidget {
  final List<Genero> generos;
  const GeneroList({super.key, required this.generos});

  @override
  State<GeneroList> createState() => _GeneroListState();
}

class _GeneroListState extends State<GeneroList> {
  List<Genero> generos = [];
  @override
  void initState() {
    generos = widget.generos;
    // generos.add(Genero.addGenero);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: generos.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return GestureDetector(
                onTap: () => showDialog(
                      context: context,
                      builder: (context) => AddGeneroDialog(generos: generos),
                    ).then((value) {
                      if (value==true) setState(() {});
                    }),
                child: GeneroChip(
                  genero: Genero.addGenero,
                ));
          } else {
            return GeneroChip(
              genero: generos[index],
            );
          }
        },
      ),
    );
  }
}
