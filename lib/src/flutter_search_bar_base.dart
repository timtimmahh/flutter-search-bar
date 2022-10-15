// Copyright (c) 2017, Spencer. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'types.dart';

mixin SearchBarMixin on StatelessWidget {
  /// Whether the search should take place "in the existing search bar", meaning whether it has the same background or a flipped one. Defaults to true.
  bool get inBar;

  /// Whether or not the search bar should close on submit. Defaults to false.
  bool get closeOnSubmit;

  /// Whether the text field should be cleared when it is submitted. Defaults to false.
  bool get clearOnSubmit;

  /// A void callback which takes a string as an argument, this is fired every time the search is submitted. Do what you want with the result.
  TextFieldSubmitCallback? get onSubmitted;

  /// A void callback which gets fired on close button press.
  VoidCallback? get onClosed;

  /// A callback which is fired when clear button is pressed.
  VoidCallback? get onCleared;

  /// Since this should be inside of a State class, just pass setState to this.
  // final SetStateCallback setState;

  /// Whether or not the search bar should add a clear input button, defaults to true.
  bool get showClearButton;

  /// What the hintText on the search bar should be. Defaults to 'Search'.
  String get hintText;

  /// Whether search is currently active.
  RxBool get isSearching;

  /// A callback which is invoked each time the text field's value changes
  TextFieldChangeCallback? get onChanged;

  /// The type of keyboard to use for editing the search bar text. Defaults to 'TextInputType.text'.
  TextInputType get keyboardType;

  /// The controller to be used in the textField.
  TextEditingController get textController => TextEditingController();

  /// Whether the clear button should be active (fully colored) or inactive (greyed out)
  final RxBool _clearActive = false.obs;

  List<Widget>? get customActions;

  List<Widget>? getActions(BuildContext context, RxBool isSearching) =>
      isSearching.value
          ? (!showClearButton
              ? customActions
              : <Widget>[
                  // Show an icon if clear is not active, so there's no ripple on tap
                  ObxValue<RxBool>(
                      (data) => IconButton(
                          icon: Icon(Icons.clear, semanticLabel: "Clear"),
                          color: inBar ? null : Get.theme.iconTheme.color,
                          disabledColor: inBar ? null : Get.theme.disabledColor,
                          onPressed: data.isFalse
                              ? null
                              : () {
                                  onCleared?.call();
                                  textController.clear();
                                }),
                      _clearActive),
                  if (customActions != null) ...customActions!
                ])
          : <Widget>[
              IconButton(
                  icon: Icon(Icons.search, semanticLabel: "Search"),
                  onPressed: () {
                    beginSearch(context);
                  }),
              if (customActions != null) ...customActions!
            ];

  IconThemeData? get actionsIconTheme;

  bool get automaticallyImplyLeading;

  Color? get backgroundColor;

  PreferredSizeWidget? get bottom;

  bool? get centerTitle;

  double? get elevation;

  bool get excludeHeaderSemantics;

  Widget? get flexibleSpace;

  Color? get foregroundColor;

  IconThemeData? get iconTheme;

  Widget? get customLeading;

  Widget? getLeading(BuildContext context, RxBool isSearching) =>
      isSearching.value
          ? IconButton(
              icon: const BackButtonIcon(),
              color: Get.theme.iconTheme.color,
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: () {
                onClosed?.call();
                // textController.clear();
                Navigator.maybePop(context);
              })
          : customLeading;

  double? get leadingWidth;

  bool get primary;

  Color? get shadowColor;

  ShapeBorder? get shape;

  SystemUiOverlayStyle? get systemOverlayStyle;

  Widget? get customTitle;

  Widget? getTitle(BuildContext context, RxBool isSearching) =>
      isSearching.value
          ? Directionality(
              textDirection: Directionality.of(context),
              child: TextField(
                key: Key('SearchBarTextField'),
                keyboardType: keyboardType,
                decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: inBar
                        ? null
                        : TextStyle(
                            color: Get.theme.textTheme.headline4!.color,
                          ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none),
                onChanged: this.onChanged,
                onSubmitted: (String val) async {
                  if (closeOnSubmit) {
                    await Navigator.maybePop(context);
                  }

                  if (clearOnSubmit) {
                    textController.clear();
                  }
                  onSubmitted?.call(val);
                },
                autofocus: true,
                controller: textController,
              ),
            )
          : customTitle;

  double? get titleSpacing;

  TextStyle? get titleTextStyle;

  double? get toolbarHeight;

  TextStyle? get toolbarTextStyle;

  void initSearchBar() {
    // Don't waste resources on listeners for the text controller if the dev
    // doesn't want a clear button anyways in the search bar
    if (!this.showClearButton) return;

    this.textController.addListener(() {
      if (this.textController.text.isEmpty) {
        // If clear is already disabled, don't disable it
        if (_clearActive.isTrue) {
          _clearActive.value = false;
        }

        return;
      }

      // If clear is already enabled, don't enable it
      if (_clearActive.isFalse) {
        _clearActive.value = true;
      }
    });
  }

  /// Initializes the search bar.
  ///
  /// This adds a route that listens for onRemove (and stops the search when that happens), and then calls [setState] to rebuild and start the search.
  void beginSearch(context) {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: () {
      isSearching.value = false;
    }));

    isSearching.value = true;
  }

  Widget buildSearchBar(BuildContext context, RxBool isSearching);

  @override
  Widget build(BuildContext context) =>
      Obx(() => buildSearchBar(context, isSearching));
}
/*
class SearchBar {
  /// Whether the search should take place "in the existing search bar", meaning whether it has the same background or a flipped one. Defaults to true.
  final bool inBar;

  /// Whether or not the search bar should close on submit. Defaults to true.
  final bool closeOnSubmit;

  /// Whether the text field should be cleared when it is submitted
  final bool clearOnSubmit;

  /// A callback which should return an AppBar that is displayed until search is started. One of the actions in this AppBar should be a search button which you obtain from SearchBar.getSearchAction(). This will be called every time search is ended, etc. (like a build method on a widget)
  final AppBarCallback buildAppBar;

  final AppBarCallback? buildSearchBar;

  /// A void callback which takes a string as an argument, this is fired every time the search is submitted. Do what you want with the result.
  final TextFieldSubmitCallback? onSubmitted;

  /// A void callback which gets fired on close button press.
  final VoidCallback? onClosed;

  /// A callback which is fired when clear button is pressed.
  final VoidCallback? onCleared;

  /// Since this should be inside of a State class, just pass setState to this.
  // final SetStateCallback setState;

  /// Whether or not the search bar should add a clear input button, defaults to true.
  final bool showClearButton;

  /// What the hintText on the search bar should be. Defaults to 'Search'.
  final String hintText;

  /// Whether search is currently active.
  final RxBool isSearching = false.obs;

  /// A callback which is invoked each time the text field's value changes
  final TextFieldChangeCallback? onChanged;

  /// The type of keyboard to use for editing the search bar text. Defaults to 'TextInputType.text'.
  final TextInputType keyboardType;

  /// The controller to be used in the textField.
  late TextEditingController controller;

  /// Whether the clear button should be active (fully colored) or inactive (greyed out)
  final RxBool _clearActive = false.obs;

  SearchBar({
    // required this.setState,
    required this.buildAppBar,
    this.buildSearchBar,
    this.onSubmitted,
    TextEditingController? controller,
    this.hintText = 'Search',
    this.inBar = true,
    this.closeOnSubmit = true,
    this.clearOnSubmit = true,
    this.showClearButton = true,
    this.onChanged,
    this.onClosed,
    this.onCleared,
    this.keyboardType = TextInputType.text,
  }) {
    this.controller = controller ?? new TextEditingController();

    // Don't waste resources on listeners for the text controller if the dev
    // doesn't want a clear button anyways in the search bar
    if (!this.showClearButton) {
      return;
    }

    this.controller.addListener(() {
      if (this.controller.text.isEmpty) {
        // If clear is already disabled, don't disable it
        if (_clearActive.isTrue) {
          _clearActive.value = false;
        }

        return;
      }

      // If clear is already enabled, don't enable it
      if (_clearActive.isFalse) {
        _clearActive.value = true;
      }
    });
  }

  /// Initializes the search bar.
  ///
  /// This adds a route that listens for onRemove (and stops the search when that happens), and then calls [setState] to rebuild and start the search.
  void beginSearch(context) {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: () {
      isSearching.value = false;
    }));

    isSearching.value = true;
  }

  /// Builds, saves and returns the default app bar.
  ///
  /// This calls the [buildAppBar] provided in the constructor.
  */ /*AppBar buildAppBar(BuildContext context) {
    return buildDefaultAppBar(context) as AppBar;
  }*/ /*

  /// Builds the search bar!
  ///
  /// The leading will always be a back button.
  /// backgroundColor is determined by the value of inBar
  /// title is always a [TextField] with the key 'SearchBarTextField', and various text stylings based on [inBar]. This is also where [onSubmitted] has its listener registered.
  ///
  AppBarCallback get _defaultSearchBar =>
          (context) {
        ThemeData theme = Theme.of(context);
        Color? buttonColor = inBar ? null : theme.iconTheme.color;

        return AppBar(
          leading: IconButton(
              icon: const BackButtonIcon(),
              color: buttonColor,
              tooltip: MaterialLocalizations
                  .of(context)
                  .backButtonTooltip,
              onPressed: () {
                onClosed?.call();
                controller.clear();
                Navigator.maybePop(context);
              }),
          backgroundColor: inBar ? null : theme.canvasColor,
          title: Directionality(
            textDirection: Directionality.of(context),
            child: TextField(
              key: Key('SearchBarTextField'),
              keyboardType: keyboardType,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: inBar
                      ? null
                      : TextStyle(
                    color: theme.textTheme.headline4!.color,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none),
              onChanged: this.onChanged,
              onSubmitted: (String val) async {
                if (closeOnSubmit) {
                  await Navigator.maybePop(context);
                }

                if (clearOnSubmit) {
                  controller.clear();
                }
                onSubmitted?.call(val);
              },
              autofocus: true,
              controller: controller,
            ),
          ),
          actions: !showClearButton
              ? null
              : <Widget>[
            // Show an icon if clear is not active, so there's no ripple on tap
            IconButton(
                icon: Icon(Icons.clear, semanticLabel: "Clear"),
                color: inBar ? null : buttonColor,
                disabledColor: inBar ? null : theme.disabledColor,
                onPressed: _clearActive.isFalse
                    ? null
                    : () {
                  onCleared?.call();
                  controller.clear();
                }),
          ],
        );
      };

  /// Returns an [IconButton] suitable for an Action
  ///
  /// Put this inside your [buildAppBar] method!
  IconButton getSearchAction(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.search, semanticLabel: "Search"),
        onPressed: () {
          beginSearch(context);
        });
  }

  /// Returns an AppBar based on the value of [isSearching]
  AppBar build(BuildContext context) {
    return isSearching.value
        ? (buildSearchBar ?? _defaultSearchBar).call(context)
        : buildAppBar(context);
  }
}*/
