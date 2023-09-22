import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/appbar/appbar_custom.dart';
import 'package:ost_tracker_og/components/drawer/drawer_custom.dart';
import 'package:ost_tracker_og/decoration/theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: const AppbarCustom(title: "Sobre nós", activeSearch: false),
      drawer: const DrawerCustom(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.06),
              child: Text(
                "Olá, meu nome é Rayan Wu e eu fiz este projeto para aprender e aprimorar minhas habilidades, por isso talvez ele tenha comportamento inesperados (sinto muito por isso ;-;).",
                textAlign: TextAlign.center,
                style: CustomTextTheme.itemHeader,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.06),
              child: Text(
                "Meu objetivo era criar uma  biblioteca/organizador de músicas e trilhas sonoras, em parte porque minha memória é péssima, mas principalmente para eu criar e organizar a trilha sonora dos meu jogos de RPG.",
                textAlign: TextAlign.center,
                style: CustomTextTheme.itemHeader,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.06),
              child: Text(
                "Espero que o Aplicativo seja útil para você também e qualquer sugestão ou problema, fique a vontade para usar a aba 'Sugestões' no Menu.",
                textAlign: TextAlign.center,
                style: CustomTextTheme.itemHeader,
              ),
            )
          ],
        ),
      ),
    );
  }
}
