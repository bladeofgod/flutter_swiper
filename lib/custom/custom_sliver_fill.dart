/*
* Author : LiJiqqi
* Date : 2020/6/29
*/



import 'package:flutter/material.dart';

//class CustomSliverFillViewport extends StatelessWidget {
//  /// Creates a sliver whose box children that each fill the viewport.
//  const CustomSliverFillViewport({
//    Key key,
//    @required this.delegate,
//    this.viewportFraction = 1.0,
//    this.padEnds = true,
//  }) : assert(viewportFraction != null),
//        assert(viewportFraction > 0.0),
//        assert(padEnds != null),
//        super(key: key);
//
//  /// The fraction of the viewport that each child should fill in the main axis.
//  ///
//  /// If this fraction is less than 1.0, more than one child will be visible at
//  /// once. If this fraction is greater than 1.0, each child will be larger than
//  /// the viewport in the main axis.
//  final double viewportFraction;
//
//  /// Whether to add padding to both ends of the list.
//  ///
//  /// If this is set to true and [viewportFraction] < 1.0, padding will be added
//  /// such that the first and last child slivers will be in the center of
//  /// the viewport when scrolled all the way to the start or end, respectively.
//  /// You may want to set this to false if this [SliverFillViewport] is not the only
//  /// widget along this main axis, such as in a [CustomScrollView] with multiple
//  /// children.
//  ///
//  /// This option cannot be [null]. If [viewportFraction] >= 1.0, this option has no
//  /// effect. Defaults to [true].
//  final bool padEnds;
//
//  /// {@macro flutter.widgets.sliverMultiBoxAdaptor.delegate}
//  final SliverChildDelegate delegate;
//
//  @override
//  Widget build(BuildContext context) {
//    return _SliverFractionalPadding(
//      viewportFraction: padEnds ? (1 - viewportFraction).clamp(0, 1) / 2 : 0,
//      sliver: _SliverFillViewportRenderObjectWidget(
//        viewportFraction: viewportFraction,
//        delegate: delegate,
//      ),
//    );
//  }
//}