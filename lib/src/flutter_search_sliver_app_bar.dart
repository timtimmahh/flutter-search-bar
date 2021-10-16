import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'flutter_search_bar_base.dart';
import 'types.dart';

class SearchSliverAppBar extends StatelessWidget with SearchBarMixin {
  SearchSliverAppBar({
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
    this.forceElevated = false,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.collapsedHeight,
    this.expandedHeight,
    this.floating = false,
    this.pinned = false,
    this.snap = false,
    this.stretch = false,
    this.stretchTriggerOffset = 100.0,
    this.onStretchTrigger,
    this.shape,
    this.toolbarHeight = kToolbarHeight,
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

  @override
  final bool? centerTitle;

  final double? collapsedHeight;

  @override
  final double? elevation;

  @override
  final bool excludeHeaderSemantics;

  final double? expandedHeight;

  @override
  final Widget? flexibleSpace;

  final bool floating;

  final bool forceElevated;

  @override
  final Color? foregroundColor;

  @override
  final IconThemeData? iconTheme;

  @override
  final Widget? customLeading;

  @override
  final double? leadingWidth;

  final AsyncCallback? onStretchTrigger;

  final bool pinned;

  @override
  final bool primary;

  @override
  final Color? shadowColor;

  @override
  final ShapeBorder? shape;

  final bool snap;

  final bool stretch;

  final double stretchTriggerOffset;

  @override
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  final Widget? customTitle;

  @override
  final double? titleSpacing;

  @override
  final TextStyle? titleTextStyle;

  @override
  final double toolbarHeight;

  @override
  final TextStyle? toolbarTextStyle;

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
  Widget buildSearchBar(BuildContext context, RxBool isSearching) => SliverAppBar(
      leading: getLeading(context, isSearching),
      automaticallyImplyLeading: automaticallyImplyLeading,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      shadowColor: shadowColor,
      forceElevated: forceElevated,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      centerTitle: centerTitle,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: titleSpacing,
      collapsedHeight: collapsedHeight,
      expandedHeight: expandedHeight,
      floating: floating,
      pinned: pinned,
      snap: snap,
      stretch: stretch,
      stretchTriggerOffset: stretchTriggerOffset,
      onStretchTrigger: onStretchTrigger,
      shape: shape,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      toolbarTextStyle: toolbarTextStyle,
      titleTextStyle: titleTextStyle,
      systemOverlayStyle: systemOverlayStyle,
      title: getTitle(context, isSearching),
      actions: getActions(context, isSearching)
  );

}
