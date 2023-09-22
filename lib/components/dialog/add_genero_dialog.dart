import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ost_tracker_og/components/button_row.dart';
import 'package:ost_tracker_og/components/empty_screen.dart';
import 'package:ost_tracker_og/components/genero_chip.dart';
import 'package:ost_tracker_og/components/loading.dart';
import 'package:ost_tracker_og/components/oneline_textformfield.dart';
import 'package:ost_tracker_og/cubit/generic_state.dart';
import 'package:ost_tracker_og/cubit/genero_cubit.dart';
import 'package:ost_tracker_og/decoration/shadows.dart';
import 'package:ost_tracker_og/models/genero_model.dart';
import 'package:ost_tracker_og/service/genero.dart';

class AddGeneroDialog extends StatefulWidget {
  final List<Genero> generos;
  const AddGeneroDialog({super.key, required this.generos});

  @override
  State<AddGeneroDialog> createState() => _AddGeneroDialogState();
}

class _AddGeneroDialogState extends State<AddGeneroDialog> {
  final GeneroCubit _genero = GeneroCubit();
  final TextEditingController _searchController = TextEditingController();

  searchGeneros() {
    _genero.searchGenero(_searchController.text);
  }

  @override
  void initState() {
    _genero.getGeneros();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    return Dialog(
        child: Container(
      height: height * 0.5,
      width: width * 0.9,
      decoration: BoxDecoration(
          boxShadow: const [Shadows.shadowBig],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 3,
            color: Colors.black,
          ),
          color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width * 0.62,
              height: height * 0.06,
              child: OnelineTextformfield(
                controller: _searchController,
                onChanged: (p0) => searchGeneros(),
                onFieldSubmitted: (p0) => searchGeneros(),
              ),
            ),
            GestureDetector(
              onTap: () => _criarGenero(),
              child: const Icon(
                Icons.add_circle_outline,
                size: 32,
              ),
            ),
          ],
        ),
        BlocBuilder<GeneroCubit, GenericState>(
          bloc: _genero,
          builder: (context, state) {
            if (state is GeneroLoading) {
              return const Loading();
            } else if (state is GeneroEmpty) {
              return Empty(msg: state.msg);
            } else if (state is GeneroError) {
              return Empty(msg: state.msg);
            } else if (state is GeneroSuccess) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  // spacing: 0,
                  runSpacing: 6,
                  children: [..._chipBuilder(state.generos)],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        const Expanded(child: SizedBox()),
        ButtonRow(function: () => Navigator.pop(context, true))
      ]),
    ));
  }

  _chipBuilder(List<Genero> lista) {
    return List.from(lista.map((e) => GestureDetector(
        onTap: () => _addGenero(e),
        child: GeneroChip(
          genero: e,
          selected: widget.generos.contains(e),
        ))));
  }

  _addGenero(Genero genero) {
    if (widget.generos.contains(genero)) {
      widget.generos.removeWhere((element) => element == genero);
    } else {
      widget.generos.add(genero);
    }
    if (mounted) setState(() {});
  }

  _criarGenero() async {
    if (_searchController.text.isEmpty) return;
    final GeneroFirestore firestore = GeneroFirestore();
    firestore.saveGenero(
        Genero(id: "", nome: _searchController.text, dono: "", publico: false));
  }
}
