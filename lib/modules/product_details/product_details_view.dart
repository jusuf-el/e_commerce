import 'package:e_commerce/data/constants/assets.dart';
import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:e_commerce/data/reusable_widgets/input_field.dart';
import 'package:e_commerce/data/reusable_widgets/primary_button.dart';
import 'package:e_commerce/data/reusable_widgets/primary_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'dart:math' as math;

class ProductDetailsView extends StatelessWidget {
  ProductDetailsView({super.key});

  final double rating = 3.9;
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController priceEditingController = TextEditingController();
  final TextEditingController descriptionEditingController =
      TextEditingController();
  final String category = 'Electronics';
  final List<String> categories = [
    'All',
    'Electronics',
    'Jewerly',
    'Women’s clothing',
    // 'Men’s clothing'
  ];
  final List<String> images = [
    'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 380.0,
                width: double.infinity,
                color: Colors.white,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 22.0,
                      left: 85.5,
                      right: 85.5,
                      bottom: 74.0,
                    ),
                    child: Image.network(
                        'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg'),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 22.0, left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        constraints: const BoxConstraints(),
                        onPressed: () => Navigator.of(context).pop(),
                        icon: SvgPicture.asset(
                          Assets.arrowBack,
                          height: 24.0,
                          width: 24.0,
                        ),
                      ),
                      IconButton(
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          titleEditingController.text =
                              'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops';
                          priceEditingController.text = '109.95';
                          descriptionEditingController.text =
                              'Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday';
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, right: 16.0, left: 16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child:
                                            SvgPicture.asset(Assets.dragHandle),
                                      ),
                                      const SizedBox(height: 24.0),
                                      const Text(
                                        'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                          color: ColorConstants.main,
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      const Divider(
                                        color: ColorConstants.neutral,
                                        thickness: 1.0,
                                        height: 1.0,
                                      ),
                                      Expanded(
                                        child: ListView(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.only(
                                            top: 24.0,
                                            bottom: 48.0,
                                          ),
                                          physics:
                                              const ClampingScrollPhysics(),
                                          children: [
                                            const Text(
                                              'Title',
                                              style: TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w600,
                                                color: ColorConstants.dark,
                                                letterSpacing: -0.34,
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            InputField(
                                              hintText: '',
                                              textEditingController:
                                                  titleEditingController,
                                              borderColor: ColorConstants.third,
                                              borderRadius: 4.0,
                                            ),
                                            const SizedBox(height: 16.0),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 107.0,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Price',
                                                        style: TextStyle(
                                                          fontSize: 17.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: ColorConstants
                                                              .dark,
                                                          letterSpacing: -0.34,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 8.0),
                                                      InputField(
                                                        hintText: '',
                                                        textEditingController:
                                                            priceEditingController,
                                                        borderColor:
                                                            ColorConstants
                                                                .third,
                                                        borderRadius: 4.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 16.0),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Category',
                                                        style: TextStyle(
                                                          fontSize: 17.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: ColorConstants
                                                              .dark,
                                                          letterSpacing: -0.34,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 8.0),
                                                      PrimaryDropdown(
                                                        value: category,
                                                        items: categories,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16.0),
                                            const Text(
                                              'Description',
                                              style: TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w600,
                                                color: ColorConstants.dark,
                                                letterSpacing: -0.34,
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            InputField(
                                              hintText: '',
                                              textEditingController:
                                                  descriptionEditingController,
                                              borderColor: ColorConstants.third,
                                              borderRadius: 4.0,
                                              maxLines: null,
                                            ),
                                            const SizedBox(height: 16.0),
                                            const Text(
                                              'Image',
                                              style: TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w600,
                                                color: ColorConstants.dark,
                                                letterSpacing: -0.34,
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Wrap(
                                              direction: Axis.horizontal,
                                              spacing: 8.0,
                                              runSpacing: 8.0,
                                              children: List.generate(
                                                images.length + 1,
                                                (index) {
                                                  return Stack(
                                                    alignment:
                                                        Alignment.topRight,
                                                    children: [
                                                      CustomPaint(
                                                        painter:
                                                            DashRectPainter(
                                                          color: ColorConstants
                                                              .main,
                                                          strokeWidth: 1.0,
                                                          gap: 2.0,
                                                        ),
                                                        child: Container(
                                                          height: 103.0,
                                                          width: 103.0,
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 15.0,
                                                            bottom: 10.0,
                                                            left: 22.5,
                                                            right: 25.5,
                                                          ),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  6.0),
                                                            ),
                                                          ),
                                                          child: index ==
                                                                  images.length
                                                              ? SvgPicture
                                                                  .asset(
                                                                  Assets.add,
                                                                  height: 24.0,
                                                                  width: 24.0,
                                                                  fit: BoxFit
                                                                      .scaleDown,
                                                                )
                                                              : Image.network(
                                                                  images[
                                                                      index]),
                                                        ),
                                                      ),
                                                      if (index < images.length)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 6.0,
                                                            right: 6.0,
                                                          ),
                                                          child:
                                                              SvgPicture.asset(
                                                            Assets.delete,
                                                            height: 24.0,
                                                            width: 24.0,
                                                            fit: BoxFit
                                                                .scaleDown,
                                                          ),
                                                        )
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 27.0),
                                            const Divider(
                                              color: ColorConstants.neutral,
                                              thickness: 1.0,
                                              height: 1.0,
                                            ),
                                            const SizedBox(height: 24.0),
                                            PrimaryButton(
                                              text: 'Save',
                                              onPressed: () {},
                                            ),
                                            const SizedBox(height: 16.0),
                                            PrimaryButton(
                                              text: 'Cancel',
                                              filled: false,
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            constraints: BoxConstraints(
                              minWidth: double.infinity,
                              maxHeight: MediaQuery.of(context).size.height,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              side: BorderSide.none,
                            ),
                            isScrollControlled: true,
                            backgroundColor: ColorConstants.lightGrey,
                            useSafeArea: true,
                          );
                        },
                        icon: SvgPicture.asset(
                          Assets.edit,
                          height: 24.0,
                          width: 24.0,
                          colorFilter: const ColorFilter.mode(
                            ColorConstants.baseBlack,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 300.0),
              Expanded(
                child: SafeArea(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ColorConstants.lightGrey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.main,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
                            '\$109.95',
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.baseBlack,
                              letterSpacing: -0.64,
                            ),
                          ),
                          const SizedBox(height: 32.0),
                          const Divider(
                            color: ColorConstants.neutral,
                            thickness: 1.0,
                            height: 1.0,
                          ),
                          const SizedBox(height: 32.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Category'.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                        color: ColorConstants.baseBlack,
                                        letterSpacing: 1.4,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    const Text(
                                      'Electronics',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                        color: ColorConstants.main,
                                        letterSpacing: -0.32,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rating'.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                        color: ColorConstants.baseBlack,
                                        letterSpacing: 1.4,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 16.0,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return SvgPicture.asset(
                                                Assets.star,
                                                width: 16.0,
                                                height: 16.0,
                                                colorFilter: ColorFilter.mode(
                                                  index + 1 <= rating.round()
                                                      ? ColorConstants.main
                                                      : ColorConstants
                                                          .baseBlack,
                                                  BlendMode.srcIn,
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return const SizedBox(width: 4.0);
                                            },
                                            itemCount: 5,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Text(
                                          '($rating)',
                                          style: const TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w400,
                                            color: ColorConstants.main,
                                            letterSpacing: -0.2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description'.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstants.baseBlack,
                                  letterSpacing: 1.4,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              const Text(
                                'Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstants.main,
                                  letterSpacing: -0.32,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashRectPainter extends CustomPainter {
  double strokeWidth;
  Color color;
  double gap;

  DashRectPainter(
      {this.strokeWidth = 5.0, this.color = Colors.red, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path _topPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(x, 0),
      gap: gap,
    );

    Path _rightPath = getDashedPath(
      a: math.Point(x, 0),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _bottomPath = getDashedPath(
      a: math.Point(0, y),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _leftPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(0.001, y),
      gap: gap,
    );

    canvas.drawPath(_topPath, dashedPaint);
    canvas.drawPath(_rightPath, dashedPaint);
    canvas.drawPath(_bottomPath, dashedPaint);
    canvas.drawPath(_leftPath, dashedPaint);
  }

  Path getDashedPath({
    required math.Point<double> a,
    required math.Point<double> b,
    required gap,
  }) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    math.Point currentPoint = math.Point(a.x, a.y);

    num radians = math.atan(size.height / size.width);

    num dx = math.cos(radians) * gap < 0
        ? math.cos(radians) * gap * -1
        : math.cos(radians) * gap;

    num dy = math.sin(radians) * gap < 0
        ? math.sin(radians) * gap * -1
        : math.sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x.toDouble(), currentPoint.y.toDouble())
          : path.moveTo(currentPoint.x.toDouble(), currentPoint.y.toDouble());
      shouldDraw = !shouldDraw;
      currentPoint = math.Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
