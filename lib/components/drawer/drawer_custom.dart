import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/drawer/drawer_item.dart';
import 'package:ost_tracker_og/cubit/usuario_cubit.dart';
import 'package:ost_tracker_og/decoration/shadows.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/screens/about_screen.dart';
import 'package:ost_tracker_og/screens/artistas/teste.dart';
import 'package:ost_tracker_og/screens/generos/genero_screen.dart';
import 'package:ost_tracker_og/screens/home_screen.dart';
import 'package:ost_tracker_og/screens/musica/musica_screen.dart';
import 'package:ost_tracker_og/screens/tags/tags_screen.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width * 0.7;
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      width: width,
      child: Container(
        width: width,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [Shadows.shadowBig],
          borderRadius:
              const BorderRadius.horizontal(right: Radius.circular(4)),
          border: Border.all(color: Colors.black, width: 2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 60),
        child: Column(
          children: [
            DrawerItem(
              title: "Home",
              function: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              ),
            ),
            DrawerItem(
              title: "Músicas",
              function: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicaScreen(),
                ),
              ),
            ),
            DrawerItem(
                title: "Artistas",
                function: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Teste(),
                    ))),
            DrawerItem(
              title: "Tags",
              function: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TagsScreen(),
                ),
              ),
            ),
            DrawerItem(
              title: "Gêneros",
              function: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GeneroScreen(),
                ),
              ),
            ),
            DrawerItem(title: "Sugestões", function: () {}),
            DrawerItem(
              title: "Sobre nós",
              function: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                UsuarioCubit user = UsuarioCubit();
                user.logout();
              },
              child: Text(
                "SAIR",
                style: CustomTextTheme.botoes,
              ),
            )
          ],
        ),
      ),
    );
  }
}
