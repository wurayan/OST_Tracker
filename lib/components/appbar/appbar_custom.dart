import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/appbar/leading_appbar.dart';
import 'package:ost_tracker_og/decoration/theme.dart';

class AppbarCustom extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool activeSearch;
  final Function(String value)? onChanged;
  final Function(String value)? onFieldSubmitted;
  final VoidCallback? cancelSearch;
  const AppbarCustom(
      {super.key,
      required this.title,
      required this.activeSearch,
      this.onChanged,
      this.onFieldSubmitted,
      this.cancelSearch});

  @override
  State<AppbarCustom> createState() => _AppbarCustomState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _AppbarCustomState extends State<AppbarCustom> {
  bool searchBar = false;
  changeAppbar() {
    searchBar = !searchBar;
    if (!searchBar && widget.cancelSearch != null) widget.cancelSearch!();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return searchBar
        ? SearchAppbar(
            callback: changeAppbar,
            onChanged: (value) {
              widget.onChanged != null ? widget.onChanged!(value) : null;
            },
            onFieldSubmitted: (value) {
              widget.onFieldSubmitted != null
                  ? widget.onFieldSubmitted!(value)
                  : null;
            },
          )
        : TitleAppBar(
            title: widget.title,
            activeSearch: widget.activeSearch,
            callback: changeAppbar);
  }
}

class TitleAppBar extends StatelessWidget {
  final String title;
  final bool activeSearch;
  final VoidCallback callback;
  const TitleAppBar(
      {super.key,
      required this.title,
      required this.activeSearch,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: CustomTextTheme.appbar,
      ),
      leading: const LeadingAppbar(),
      actions: [
        Visibility(
          visible: activeSearch,
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => callback(),
              child: SizedBox(
                width: 28,
                height: 28,
                child: Image.asset("assets/icons/lupa.png"),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SearchAppbar extends StatelessWidget {
  final VoidCallback callback;
  final Function(String value) onChanged;
  final Function(String value) onFieldSubmitted;
  SearchAppbar(
      {super.key,
      required this.callback,
      required this.onChanged,
      required this.onFieldSubmitted});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          enabledBorder: null,
          focusedBorder: null,
          hintText: "Buscar...",
          hintStyle: TextStyle(color: ColorTheme.disable),
          contentPadding: const EdgeInsets.all(12),
        ),
        onChanged: (value) {
          print("TESTANBDO UM DOI RTRES $value");
          onChanged(value);
        },
        onFieldSubmitted: (value) => onFieldSubmitted(value),
        onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: SizedBox(
          child: Image.asset("assets/icons/lupa.png"),
        ),
      ),
      leadingWidth: 44,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () => callback(),
            child: const Icon(
              Icons.close,
              size: 32,
            ),
          ),
        ),
      ],
    );
  }
}
