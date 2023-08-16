import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:three_connects/presentation/widgets/custom_widgets.dart';
import 'package:three_connects/utils/app_color.dart';

enum ContentDisplayMode {
  hidden,
  numbers,
  dropdown,
}

/// Holds all the relevant information for the configuration of how the
/// [NumberPaginator] should look like.
class NumberPaginatorUIConfig {
  /// The height of the number paginator.
  final double height;

  /// The shape of the [PaginatorButton]s.
  final OutlinedBorder? buttonShape;

  /// The [PaginatorButton]'s foreground color (text/icon color) when selected.
  ///
  /// Defaults to [Colors.white].
  final Color? buttonSelectedForegroundColor;

  /// The [PaginatorButton]'s foreground color (text/icon color) when unselected.
  ///
  /// Defaults to `null`.
  final Color? buttonUnselectedForegroundColor;

  /// The [PaginatorButton]'s background color when selected.
  ///
  /// Defaults to the [Theme]'s accent color.
  final Color? buttonSelectedBackgroundColor;

  /// The [PaginatorButton]'s background color when unselected.
  ///
  /// Defaults to `null`.
  final Color? buttonUnselectedBackgroundColor;

  /// The [ContentDisplayMode] for the center content of the number paginator.
  final ContentDisplayMode mode;

  /// The [MainAxisAlignment] of the [Row] that holds the prev/next buttons and
  /// the page number buttons. This property only takes effect [mode] is set to
  /// [ContentDisplayMode.hidden].
  ///
  /// Defaults to [MainAxisAlignment.start].
  final MainAxisAlignment mainAxisAlignment;

  /// The [EdgeInsets] that should be used as padding for the number paginator's
  /// content.
  final EdgeInsets? contentPadding;

  const NumberPaginatorUIConfig({
    this.height = 48.0,
    this.buttonShape,
    this.buttonSelectedForegroundColor,
    this.buttonUnselectedForegroundColor,
    this.buttonSelectedBackgroundColor,
    this.buttonUnselectedBackgroundColor,
    this.mode = ContentDisplayMode.numbers,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.contentPadding,
  });
}

typedef NumberPaginatorContentBuilder = Widget Function(int index);

class NumberPaginators extends StatefulWidget {
  final int numberPages;

  final int initialPage;

  final Function(int)? onPageChange;

  final NumberPaginatorUIConfig config;

  final NumberPaginatorContentBuilder? contentBuilder;

  final NumberPaginatorController? controller;

  const NumberPaginators({
    Key? key,
    required this.numberPages,
    this.initialPage = 0,
    this.onPageChange,
    this.config = const NumberPaginatorUIConfig(),
    this.contentBuilder,
    this.controller,
  })  : assert(initialPage >= 0),
        assert(initialPage <= numberPages - 1),
        super(key: key);

  @override
  NumberPaginatorsState createState() => NumberPaginatorsState();
}

class NumberPaginatorsState extends State<NumberPaginators> {
  late NumberPaginatorController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? NumberPaginatorController();
    _controller.currentPage = widget.initialPage;
    _controller.addListener(() {
      widget.onPageChange?.call(_controller.currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedNumberPaginator(
      numberPages: widget.numberPages,
      initialPage: widget.initialPage,
      onPageChange: _controller.navigateToPage,
      config: widget.config,
      child: SizedBox(
        height: widget.config.height,
        child: Row(
          mainAxisAlignment: widget.config.mainAxisAlignment,
          children: [
            icon(
              () {
                _controller.navigateToPage(0);
              },
              Icons.keyboard_double_arrow_left,
            ),
            icon(
              _controller.currentPage > 0 ? _controller.prev : () {},
              Icons.chevron_left,
            ),
            const SizedBox(width: 10),
            ..._buildCenterContent(),
            const SizedBox(width: 10),
            icon(
              _controller.currentPage < widget.numberPages - 1 ? _controller.next : () {},
              Icons.chevron_right,
            ),
            icon(
              () {
                _controller.navigateToPage(widget.numberPages - 1);
              },
              Icons.keyboard_double_arrow_right_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget icon(Function() onTap, IconData icon) {
    return CustomInkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: CircleAvatar(
          backgroundColor: AppColor.btnColor,
          radius: 15,
          child: Icon(icon, size: 18, color: Colors.white),
        ),
      ),
    );
  }

  List<Widget> _buildCenterContent() {
    return [
      if (widget.contentBuilder != null)
        Container(
          padding: widget.config.contentPadding,
          child: widget.contentBuilder!(_controller.currentPage),
        )
      else if (widget.config.mode != ContentDisplayMode.hidden)
        Expanded(
          child: Container(
            padding: widget.config.contentPadding,
            child: PaginatorContent(
              currentPage: _controller.currentPage,
            ),
          ),
        ),
    ];
  }
}

class NumberPaginatorController extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  /// Decreases page by 1 and notifies listeners
  prev() {
    _currentPage--;
    notifyListeners();
  }

  /// Increases page by 1 and notifies listeners
  next() {
    _currentPage++;
    notifyListeners();
  }

  /// Alias for setter
  navigateToPage(int index) {
    currentPage = index;
  }
}

class PaginatorContent extends StatelessWidget {
  final int currentPage;

  const PaginatorContent({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberContent(
      currentPage: currentPage,
    );
  }
}

class NumberContent extends StatelessWidget {
  final int currentPage;

  const NumberContent({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var buttonWidth = constraints.maxHeight;
        var availableSpots = (constraints.maxWidth / buttonWidth).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // if(currentPage < 2)
            if (!_frontDotsShouldShow(context, availableSpots)) _buildPageButton(context, 0),
            // if (_frontDotsShouldShow(context, availableSpots)) _buildDots(context),
            if (InheritedNumberPaginator.of(context).numberPages > 1)
              ..._generateButtonList(context, availableSpots),
            // if (_backDotsShouldShow(context, availableSpots)) _buildDots(context),
            // if (InheritedNumberPaginator.of(context).numberPages > 1)
            if (!_backDotsShouldShow(context, availableSpots))
              _buildPageButton(context, InheritedNumberPaginator.of(context).numberPages - 1),
          ],
        );
      },
    );
  }

  /// Generates the variable button list which is at the center of the (optional)
  /// dots. The very last and first pages are shown independently of this list.
  List<Widget> _generateButtonList(BuildContext context, int availableSpots) {
    // if dots shown: available minus (2 for first and last pages + 2 for dots)
    var shownPages = availableSpots - 1;

    var numberPages = InheritedNumberPaginator.of(context).numberPages;

    int minValue, maxValue;
    minValue = max(1, currentPage - shownPages ~/ 2);
    maxValue = min(minValue + shownPages, numberPages - 1);
    if (maxValue - minValue < shownPages) {
      minValue = (maxValue - shownPages).clamp(1, numberPages - 1);
    }

    return List.generate(
        maxValue - minValue, (index) => _buildPageButton(context, minValue + index));
  }

  /// Builds a button for the given index.
  Widget _buildPageButton(BuildContext context, int index) => PaginatorButton(
        onPressed: () => InheritedNumberPaginator.of(context).onPageChange?.call(index),
        selected: _selected(index),
        child: Text(
          (index + 1).toString(),
          maxLines: 1,
          style: TextStyle(
            fontSize: 13,
            color: _foregroundColor(
              context,
              _selected(index),
            ),
          ),
        ),
      );

  Color? _foregroundColor(BuildContext context, bool selected) => selected
      ? (InheritedNumberPaginator.of(context).config.buttonSelectedForegroundColor ?? Colors.white)
      : InheritedNumberPaginator.of(context).config.buttonUnselectedForegroundColor;

  /// Checks if pages don't fit in available spots and dots have to be shown.
  bool _backDotsShouldShow(BuildContext context, int availableSpots) =>
      availableSpots < InheritedNumberPaginator.of(context).numberPages &&
      currentPage < InheritedNumberPaginator.of(context).numberPages - availableSpots ~/ 2;

  bool _frontDotsShouldShow(BuildContext context, int availableSpots) =>
      availableSpots < InheritedNumberPaginator.of(context).numberPages &&
      currentPage > availableSpots ~/ 2 - 1;

  /// Checks if the given index is currently selected.
  bool _selected(index) => index == currentPage;
}

class PaginatorButton extends StatelessWidget {
  /// Callback for button press.
  final VoidCallback? onPressed;

  /// The child of the button.
  final Widget child;

  /// Whether the button is currently selected.
  final bool selected;

  /// Creates an instance of [PaginatorButton].
  const PaginatorButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: CustomInkWell(
          onTap: (){
            if(onPressed != null) {
              onPressed!();
            }
          },
          child: CircleAvatar(
            radius: 15,
            backgroundColor: _backgroundColor(context, selected),
            child: child,
          ),
        ));
  }

  Color? _backgroundColor(BuildContext context, bool selected) => selected
      ? (InheritedNumberPaginator.of(context).config.buttonSelectedBackgroundColor ??
          Theme.of(context).colorScheme.secondary)
      : InheritedNumberPaginator.of(context).config.buttonUnselectedBackgroundColor;
}

class InheritedNumberPaginator extends InheritedWidget {
  /// Total number of pages that should be shown.
  final int numberPages;

  /// Index of initially selected page.
  final int initialPage;

  /// This function is called when the user switches between pages. The received
  /// parameter indicates the selected index, starting from 0.
  final Function(int)? onPageChange;

  /// The UI config for the [NumberPaginator].
  final NumberPaginatorUIConfig config;

  const InheritedNumberPaginator({
    Key? key,
    required this.numberPages,
    this.initialPage = 0,
    this.onPageChange,
    required this.config,
    required Widget child,
  }) : super(key: key, child: child);

  static InheritedNumberPaginator of(BuildContext context) {
    final InheritedNumberPaginator? result =
        context.dependOnInheritedWidgetOfExactType<InheritedNumberPaginator>();
    assert(result != null, "No NumberPaginatorConfig found in context");
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedNumberPaginator old) => true;
}
