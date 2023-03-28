import 'package:flutter/widgets.dart';

typedef BoundaryWidgetBuilder = Widget Function(
    BuildContext context, dynamic error);

/// No `Boundary<valueType>` were found as an ancestor of a [Defer] was used.
class BoundaryNotFoundError extends Error {
  /// The type of the widget that tried (and failed) to access `Boundary<valueType>`.
  final Type valueType;

  /// Allows specifying [valueType]
  BoundaryNotFoundError(this.valueType);

  @override
  String toString() {
    return '''
Error: No Boundary<$valueType> found.
''';
  }
}

class _InheritedBoundary extends InheritedWidget {
  const _InheritedBoundary({
    final Key? key,
    required this.element,
    required final Widget child,
  }) : super(key: key, child: child);

  static _BoundaryElement? of(final BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<_InheritedBoundary>()
        ?.widget;

    if (widget is _InheritedBoundary) {
      return widget.element;
    }
    return null;
  }

  final _BoundaryElement element;

  @override
  bool updateShouldNotify(final _InheritedBoundary oldWidget) {
    return oldWidget.element != element;
  }
}

/// Defines a fallback behavior for [Defer] widget used inside `child`.
class Boundary extends StatelessWidget {
  /// [fallbackBuilder] and [child] must not be `null`.
  const Boundary({
    final Key? key,
    required this.fallbackBuilder,
    required this.child,
  }) : super(key: key);

  /// The subtree from which [Boundary] will capture errors.
  ///
  /// If [child] or any of its descendants throws when building the widget,
  /// then [fallbackBuilder] will be called with the exception.
  final Widget child;

  /// A callback used to create a fallback UI if [child] fails to build.
  ///
  /// It is fine for [fallbackBuilder] to throws too, in which case the error
  /// will be propagated to other boundaries.
  final BoundaryWidgetBuilder fallbackBuilder;

  @override
  _BoundaryElement createElement() => _BoundaryElement(this);

  @override
  Widget build(final BuildContext context) {
    return _Internal(
      showChild: true,
      element: context as _BoundaryElement,
      exception: context.exception,
      fallbackBuilder: fallbackBuilder,
      child: child,
    );
  }
}

/// A widget that asks the nearest [Boundary] in its ancestors to call
/// [Boundary.fallbackBuilder].
class Defer extends StatelessWidget {
  /// Allows specifying [details].
  const Defer(this.details, {final Key? key}) : super(key: key);

  /// The object that will be passed as parameter to [Boundary.fallbackBuilder].
  final Object details;

  @override
  _FallbackElement createElement() => _FallbackElement(this);

  @override
  Widget build(final BuildContext context) => const SizedBox();
}

class _FallbackElement extends StatelessElement {
  _FallbackElement(final Defer widget) : super(widget);

  @override
  Defer get widget => super.widget as Defer;

  _BoundaryElement? boundary;
  late _BoundaryElement didCatch;

  @override
  Element updateChild(
      final Element? child, final Widget? newWidget, final dynamic newSlot) {
    final res = super.updateChild(child, newWidget, newSlot);

    boundary = _InheritedBoundary.of(this);
    if (boundary == null) {
      FlutterError.reportError(
        FlutterErrorDetails(
          library: 'boundary',
          exception: BoundaryNotFoundError(widget.details.runtimeType),
        ),
      );
    } else {
      boundary?.markSubtreeFailed(widget.details);
    }
    return res!;
  }

  @override
  void deactivate() {
    if (boundary?.activated == true) {
      boundary?.markSubtreeFailed(Object());
    }
    super.deactivate();
  }
}

class _Internal extends StatelessWidget {
  const _Internal({
    final Key? key,
    required this.element,
    required this.child,
    required this.fallbackBuilder,
    this.exception,
    required this.showChild,
  }) : super(key: key);

  final _BoundaryElement element;
  final Widget child;
  final BoundaryWidgetBuilder fallbackBuilder;
  final dynamic exception;
  final bool showChild;

  @override
  Widget build(final BuildContext context) {
    if (exception != null) {
      if (!showChild) {
        element.errorWidget = _InheritedBoundary(
          element: _InheritedBoundary.of(context)!,
          child: Builder(
            builder: (final context) => fallbackBuilder(context, exception),
          ),
        );
      }
    } else {
      element.errorWidget = null;
    }

    final valid = Offstage(
      offstage: !showChild && exception != null,
      child: child,
    );

    return _InheritedBoundary(
      element: element,
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: element.errorWidget != null
            ? [valid, element.errorWidget!]
            : [valid],
      ),
    );
  }
}

class _BoundaryElement extends StatelessElement {
  _BoundaryElement(final Boundary widget) : super(widget);

  @override
  Boundary get widget => super.widget as Boundary;

  Object? failure;
  bool isBuilding = false;
  bool activated = false;
  dynamic exception;
  Widget? errorWidget;

  Element? _child;
  dynamic _slot;

  @override
  Element? updateChild(
    final Element? child,
    final Widget? newWidget,
    final dynamic newSlot,
  ) {
    _child ??= child;
    _slot = newSlot;
    return _child = super.updateChild(child, newWidget, newSlot);
  }

  @override
  void performRebuild() {
    isBuilding = true;
    final hadError = failure != null;
    failure = null;
    super.performRebuild();
    isBuilding = false;
    final hasError = failure != null;
    if (hasError != hadError) {
      exception = failure;
      rebuildWithError(exception);
    }
  }

  @override
  void mount(final Element? parent, final dynamic newSlot) {
    super.mount(parent, newSlot);
    activated = true;
  }

  @override
  void activate() {
    super.activate();
    activated = true;
  }

  @override
  void deactivate() {
    activated = false;
    super.deactivate();
  }

  void markSubtreeFailed(final Object failure) {
    this.failure = failure;
    exception = failure;
    if (!isBuilding) {
      rebuildWithError(exception);
    }
  }

  void rebuildWithError(final dynamic exception) {
    updateChild(
      _child,
      _Internal(
        element: this,
        showChild: false,
        fallbackBuilder: widget.fallbackBuilder,
        exception: exception,
        child: widget.child,
      ),
      _slot,
    );
  }
}
