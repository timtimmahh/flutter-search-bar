import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'flutter_search_bar_base.dart';
import 'types.dart';

class SearchAppBar extends StatelessWidget
    with SearchBarMixin
    implements PreferredSizeWidget {
  SearchAppBar({
    Key? key,
    this.onSubmitted,
    TextEditingController? textController,
    this.hintText = 'Search',
    this.inBar = true,
    this.closeOnSubmit = false,
    this.clearOnSubmit = false,
    this.showClearButton = true,
    this.onChanged,
    this.onClosed,
    this.onCleared,
    this.keyboardType = TextInputType.text,
    Widget? leading,
    this.automaticallyImplyLeading = true,
    Widget? title,
    List<Widget>? actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shadowColor,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.toolbarHeight,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
  })  : textController = textController ?? TextEditingController(),
        customLeading = leading,
        customTitle = title,
        customActions = actions,
        super(key: key) {
    initSearchBar();
  }

  @override
  final List<Widget>? customActions;

  @override
  final IconThemeData? actionsIconTheme;

  @override
  final bool automaticallyImplyLeading;

  @override
  final Color? backgroundColor;

  @override
  final PreferredSizeWidget? bottom;

  final double bottomOpacity;

  @override
  final bool? centerTitle;

  @override
  final double? elevation;

  @override
  final bool excludeHeaderSemantics;

  @override
  final Widget? flexibleSpace;

  @override
  final Color? foregroundColor;

  @override
  final IconThemeData? iconTheme;

  @override
  final Widget? customLeading;

  @override
  final double? leadingWidth;

  @override
  final bool primary;

  @override
  final Color? shadowColor;

  @override
  final ShapeBorder? shape;

  @override
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  final Widget? customTitle;

  @override
  final double? titleSpacing;

  @override
  final TextStyle? titleTextStyle;

  @override
  final double? toolbarHeight;

  final double toolbarOpacity;

  final TextStyle? toolbarTextStyle;

  @override
  Size get preferredSize => Size.fromHeight(
      (toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0));

  @override
  final bool clearOnSubmit;

  @override
  final bool closeOnSubmit;

  @override
  final String hintText;

  @override
  final bool inBar;

  @override
  final TextInputType keyboardType;

  @override
  final TextFieldChangeCallback? onChanged;

  @override
  final VoidCallback? onCleared;

  @override
  final VoidCallback? onClosed;

  @override
  final TextFieldSubmitCallback? onSubmitted;

  @override
  final bool showClearButton;

  @override
  final TextEditingController textController;

  @override
  Widget buildSearchBar(BuildContext context, RxBool isSearching) => AppBar(
      leading: getLeading(context, isSearching),
      automaticallyImplyLeading: automaticallyImplyLeading,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
      backgroundColor: backgroundColor ?? Get.theme.canvasColor,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      centerTitle: centerTitle,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: titleSpacing,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      toolbarTextStyle: toolbarTextStyle,
      titleTextStyle: titleTextStyle,
      systemOverlayStyle: systemOverlayStyle,
      title: getTitle(context, isSearching),
      actions: getActions(context, isSearching));
}
