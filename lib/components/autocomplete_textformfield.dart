import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ost_tracker_og/cubit/artista_cubit.dart';
import 'package:ost_tracker_og/cubit/generic_state.dart';
import 'package:ost_tracker_og/decoration/common.dart';
import 'package:ost_tracker_og/decoration/shadows.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/artista_model.dart';

class AutocompleteTextformfield extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final double? width;
  const AutocompleteTextformfield({
    super.key,
    required this.controller,
    this.hintText,
    this.width,
  });

  @override
  State<AutocompleteTextformfield> createState() =>
      _AutocompleteTextformfieldState();
}

class _AutocompleteTextformfieldState extends State<AutocompleteTextformfield> {
  final ArtistaCubit _artista = ArtistaCubit();

  @override
  void initState() {
    _artista.getArtistas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    return BlocBuilder<ArtistaCubit, GenericState>(
      bloc: _artista,
      builder: (context, state) {
        return Autocomplete<Artista>(
          displayStringForOption: (option) => option.nome,
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<Artista>.empty();
            } else if (state is ArtistaSuccess) {
              return state.artistas.where((e) => e.nome
                  .toLowerCase()
                  .startsWith(textEditingValue.text.toLowerCase()));
            } else if (state is ArtistaEmpty) {
              return const Iterable.empty();
            } else {
              return [
                Artista(
                    id: "",
                    nome: "carregando...",
                    generos: [],
                    dono: "",
                    publico: false)
              ].map((e) => e);
            }
          },
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) =>
                  TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus!.unfocus(),
                      onChanged: (value) => widget.controller.text = value,
                      decoration: InputDecoration(
                        enabledBorder: outline,
                        focusedBorder: outline,
                        errorBorder: error,
                        focusedErrorBorder: error,
                        hintText: widget.hintText,
                        hintStyle: CustomTextTheme.hintText,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      style: CustomTextTheme.hintText
                          .copyWith(color: ColorTheme.text)),
          onSelected: (option) {
            widget.controller.text = option.nome;
          },
          optionsViewBuilder: (context, onSelected, options) => Material(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: const [Shadows.shadowMid],
                    border: Border.all(color: ColorTheme.blackberry, width: 3),
                    color: ColorTheme.white,
                    borderRadius: BorderRadius.circular(4)),
                width: widget.width ?? MediaQuery.sizeOf(context).width * 0.9,
                height: options.isEmpty ? height * 0.05 : height * 0.3,
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final Artista artista = options.elementAt(index);
                    return GestureDetector(
                      onTap: () => onSelected(artista),
                      child: Text(
                        artista.nome,
                        style: CustomTextTheme.hintText,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
