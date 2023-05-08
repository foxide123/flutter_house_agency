import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../../../assets/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../search_state.dart';

class SearchWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function() onSubmitted;
  final Function() onClearPressed;
  final Function() onSearchPressed;
  final bool isSearchPressed;
  
  const SearchWidget({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
    required this.onClearPressed,
    required this.onSearchPressed,
    required this.isSearchPressed,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool searchPressed=false;

  @override
  void initState() {
    super.initState();
    searchPressed = widget.isSearchPressed; 
  }

  @override
  Widget build(BuildContext context) {
     return SizedBox(
      width: 320,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          onSubmitted: (_) => {
            widget.onSubmitted(),
            setState((){
              searchPressed = true;
            })
            },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search for a home',
            filled: true,
            fillColor: DesignSystemColors.darkGray,
            suffixIcon: IconButton(
              icon: widget.isSearchPressed && widget.controller.text.isNotEmpty
                  ? SvgPicture.asset("lib/assets/Icons/ic_close.svg")
                  : SvgPicture.asset(
                      "lib/assets/Icons/ic_search.svg",
                      color: DesignSystemColors.medium,
                    ),
              onPressed: widget.isSearchPressed ? widget.onClearPressed : widget.onSearchPressed,
            ),
          ),
        ),
      ),
    );
  }
}
