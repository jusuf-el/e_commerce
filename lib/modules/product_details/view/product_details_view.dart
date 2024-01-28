import 'package:e_commerce/data/constants/assets.dart';
import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/data/reusable_widgets/zen_app_bar.dart';
import 'package:e_commerce/modules/product_details/blocs/product_details_bloc.dart';
import 'package:e_commerce/modules/product_details/widgets/edit_product_modal.dart';
import 'package:e_commerce/modules/products/blocs/filter_bloc.dart';
import 'package:e_commerce/utils/bloc/bloc_provider.dart';
import 'package:e_commerce/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class ProductDetailsView extends StatefulWidget {
  final FilterBloc filterBloc;
  final int? productId;

  const ProductDetailsView({
    super.key,
    required this.filterBloc,
    required this.productId,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController priceEditingController = TextEditingController();
  final TextEditingController descriptionEditingController =
      TextEditingController();

  late ProductDetailsBloc productDetailsBloc;

  @override
  void initState() {
    super.initState();
    productDetailsBloc = BlocProvider.of<ProductDetailsBloc>(context);
    productDetailsBloc.getProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
        stream: productDetailsBloc.loadingStream,
        initialData: productDetailsBloc.loading,
        builder: (BuildContext context, AsyncSnapshot<bool> loadingSnapshot) {
          bool loading = loadingSnapshot.data ?? true;
          return loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.main,
                  ),
                )
              : StreamBuilder<Product>(
                  stream: productDetailsBloc.productStream,
                  initialData: productDetailsBloc.product,
                  builder: (BuildContext context,
                      AsyncSnapshot<Product> productSnapshot) {
                    Product product = productSnapshot.data ?? Product();
                    return Stack(
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
                                    product.image,
                                    loadingBuilder: (context, widget, event) {
                                      if (event?.expectedTotalBytes !=
                                          event?.cumulativeBytesLoaded) {
                                        return const Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: CircularProgressIndicator(
                                              color: ColorConstants.main,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return widget;
                                      }
                                    },
                                    errorBuilder: (context, object, trace) {
                                      return const Icon(
                                        Icons.image_not_supported_outlined,
                                        color: ColorConstants.baseBlack,
                                        size: 75.0,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            ZenAppBar(
                              leadingIcon: Assets.arrowBack,
                              onLeadingPressed: () =>
                                  Navigator.of(context).pop(),
                              trailingIcon: Assets.edit,
                              onTrailingPressed: () {
                                titleEditingController.text = product.title;
                                priceEditingController.text = product.price;
                                descriptionEditingController.text =
                                    product.description;
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return EditProductModal(
                                      product: product,
                                      titleEditingController:
                                          titleEditingController,
                                      priceEditingController:
                                          priceEditingController,
                                      descriptionEditingController:
                                          descriptionEditingController,
                                      categories: widget.filterBloc.categories,
                                    );
                                  },
                                  constraints: BoxConstraints(
                                    minWidth: double.infinity,
                                    maxHeight:
                                        MediaQuery.of(context).size.height,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.title,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                            color: ColorConstants.main,
                                            letterSpacing: -0.4,
                                          ),
                                        ),
                                        const SizedBox(height: 16.0),
                                        Text(
                                          '\$${product.price}',
                                          style: const TextStyle(
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Category'.toUpperCase(),
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: ColorConstants
                                                          .baseBlack,
                                                      letterSpacing: 1.4,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  Text(
                                                    product.category
                                                        .capitalize(),
                                                    style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          ColorConstants.main,
                                                      letterSpacing: -0.32,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Rating'.toUpperCase(),
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: ColorConstants
                                                          .baseBlack,
                                                      letterSpacing: 1.4,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 16.0,
                                                        child:
                                                            ListView.separated(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          shrinkWrap: true,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return SvgPicture
                                                                .asset(
                                                              Assets.star,
                                                              width: 16.0,
                                                              height: 16.0,
                                                              colorFilter:
                                                                  ColorFilter
                                                                      .mode(
                                                                index + 1 <=
                                                                        product
                                                                            .rating
                                                                            .rate
                                                                            .round()
                                                                    ? ColorConstants
                                                                        .main
                                                                    : ColorConstants
                                                                        .baseBlack,
                                                                BlendMode.srcIn,
                                                              ),
                                                            );
                                                          },
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return const SizedBox(
                                                                width: 4.0);
                                                          },
                                                          itemCount: 5,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width: 8.0),
                                                      Text(
                                                        '(${product.rating.count})',
                                                        style: const TextStyle(
                                                          fontSize: 10.0,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: ColorConstants
                                                              .main,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                            Text(
                                              product.description,
                                              style: const TextStyle(
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
                    );
                  },
                );
        },
      ),
    );
  }
}
