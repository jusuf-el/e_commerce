import 'package:e_commerce/data/constants/assets.dart';
import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/data/reusable_widgets/input_field.dart';
import 'package:e_commerce/data/reusable_widgets/primary_app_bar.dart';
import 'package:e_commerce/data/reusable_widgets/primary_button.dart';
import 'package:e_commerce/modules/product_details/blocs/product_details_bloc.dart';
import 'package:e_commerce/modules/product_details/view/product_details_view.dart';
import 'package:e_commerce/modules/products/blocs/filter_bloc.dart';
import 'package:e_commerce/modules/products/blocs/products_bloc.dart';
import 'package:e_commerce/utils/bloc/bloc_provider.dart';
import 'package:e_commerce/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final TextEditingController searchInputController = TextEditingController();

  late FilterBloc filterBloc;
  late ProductsBloc productsBloc;

  @override
  void initState() {
    super.initState();
    filterBloc = BlocProvider.of<FilterBloc>(context);
    productsBloc = BlocProvider.of<ProductsBloc>(context);

    filterBloc.getCategories(productsBloc);

    searchInputController.addListener(() {
      productsBloc.onSearchChanged(searchInputController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: StreamBuilder<bool>(
          stream: filterBloc.loadingStream,
          initialData: filterBloc.loading,
          builder: (BuildContext context,
              AsyncSnapshot<bool> categoriesLoadingSnapshot) {
            bool categoriesLoading = categoriesLoadingSnapshot.data ?? true;
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InputField(
                          hintText: 'Search',
                          textEditingController: searchInputController,
                          prefixIcon: SvgPicture.asset(
                            Assets.search,
                            height: 24.0,
                            width: 24.0,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      const SizedBox(width: 11.0),
                      InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(22)),
                        onTap: () =>
                            productsBloc.onFilterPressed(context, filterBloc),
                        child: Container(
                          height: 48.0,
                          width: 48.0,
                          decoration: const BoxDecoration(
                            color: ColorConstants.light,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            Assets.filter,
                            height: 24.0,
                            width: 24.0,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Visibility(
                  visible: !categoriesLoading,
                  child: StreamBuilder<List<String>>(
                    stream: filterBloc.categoriesStream,
                    initialData: filterBloc.categories,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>> snapshot) {
                      List<String> categories = snapshot.data ?? [];
                      return Container(
                        height: 36.0,
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 16.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: ColorConstants.light,
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(4.0),
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 20.0),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => productsBloc.onCategoryChanged(
                                  categories[index], filterBloc),
                              child: StreamBuilder<String>(
                                  stream: productsBloc.selectedCategoryStream,
                                  initialData: productsBloc.selectedCategory,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<String>
                                          selectedCategorySnapshot) {
                                    String selectedCategory =
                                        selectedCategorySnapshot.data ?? '';
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20.0)),
                                        color: selectedCategory ==
                                                categories[index]
                                            ? ColorConstants.main
                                            : Colors.transparent,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 6.0),
                                      child: Text(
                                        categories[index].capitalize(),
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: selectedCategory ==
                                                  categories[index]
                                              ? ColorConstants.light
                                              : ColorConstants.main,
                                          letterSpacing: -0.24,
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder<bool>(
                      stream: productsBloc.loadingStream,
                      initialData: productsBloc.loading,
                      builder: (BuildContext context,
                          AsyncSnapshot<bool> loadingSnapshot) {
                        bool loading = loadingSnapshot.data ?? true;
                        return loading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: ColorConstants.main,
                                ),
                              )
                            : StreamBuilder<List<Product>>(
                                stream: productsBloc.productsStream,
                                initialData: productsBloc.products,
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Product>>
                                        productsSnapshot) {
                                  List<Product> products =
                                      productsSnapshot.data ?? [];
                                  return StreamBuilder<String>(
                                      stream: productsBloc.searchStream,
                                      initialData: productsBloc.search,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String>
                                              searchSnapshot) {
                                        String search =
                                            searchSnapshot.data ?? '';
                                        List<Product> filteredProducts =
                                            products
                                                .where((e) => e.title
                                                    .toLowerCase()
                                                    .contains(
                                                        search.toLowerCase()))
                                                .toList();
                                        return ListView.separated(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 19.0,
                                            horizontal: 16.0,
                                          ),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        BlocProvider(
                                                      bloc:
                                                          ProductDetailsBloc(),
                                                      child: ProductDetailsView(
                                                        filterBloc: filterBloc,
                                                        productId:
                                                            filteredProducts[
                                                                    index]
                                                                .id,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorConstants.lightGrey,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 70.0,
                                                      width: 70.0,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    6.0)),
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15.0,
                                                          vertical: 7.0),
                                                      child: Image.network(
                                                        filteredProducts[index]
                                                            .image,
                                                        loadingBuilder:
                                                            (context, widget,
                                                                event) {
                                                          if (event
                                                                  ?.expectedTotalBytes !=
                                                              event
                                                                  ?.cumulativeBytesLoaded) {
                                                            return const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color:
                                                                      ColorConstants
                                                                          .main,
                                                                ),
                                                              ),
                                                            );
                                                          } else {
                                                            return widget;
                                                          }
                                                        },
                                                        errorBuilder: (context,
                                                            object, trace) {
                                                          return const Icon(
                                                            Icons
                                                                .image_not_supported_outlined,
                                                            color:
                                                                ColorConstants
                                                                    .baseBlack,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(width: 16.0),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                filteredProducts[
                                                                        index]
                                                                    .category
                                                                    .toUpperCase(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 8.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: ColorConstants
                                                                      .baseBlack,
                                                                  letterSpacing:
                                                                      0.8,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 4.0),
                                                              Text(
                                                                filteredProducts[
                                                                        index]
                                                                    .title,
                                                                maxLines: 2,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      12.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color:
                                                                      ColorConstants
                                                                          .main,
                                                                  letterSpacing:
                                                                      -0.24,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            '\$${filteredProducts[index].price}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  ColorConstants
                                                                      .baseBlack,
                                                              letterSpacing:
                                                                  -0.32,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 16.0),
                                                    IconButton(
                                                      onPressed: () {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) {
                                                            return Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    top: 16.0,
                                                                    right: 16.0,
                                                                    left: 16.0,
                                                                    bottom:
                                                                        48.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Center(
                                                                      child: SvgPicture.asset(
                                                                          Assets
                                                                              .dragHandle),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            24.0),
                                                                    Text(
                                                                      filteredProducts[
                                                                              index]
                                                                          .title,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            20.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color: ColorConstants
                                                                            .main,
                                                                        letterSpacing:
                                                                            -0.4,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            16.0),
                                                                    const Divider(
                                                                      color: ColorConstants
                                                                          .neutral,
                                                                      thickness:
                                                                          1.0,
                                                                      height:
                                                                          1.0,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            24.0),
                                                                    PrimaryButton(
                                                                      text:
                                                                          'Edit product',
                                                                      icon: Assets
                                                                          .edit,
                                                                      onPressed:
                                                                          () {},
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            16.0),
                                                                    PrimaryButton(
                                                                      text:
                                                                          'Delete product',
                                                                      filled:
                                                                          false,
                                                                      icon: Assets
                                                                          .delete,
                                                                      onPressed: () => productsBloc.onDeleteProductPressed(
                                                                          context,
                                                                          filteredProducts[index]
                                                                              .id),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          constraints:
                                                              BoxConstraints(
                                                            minWidth:
                                                                double.infinity,
                                                            maxHeight:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                          ),
                                                          shape:
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      20.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20.0),
                                                            ),
                                                            side:
                                                                BorderSide.none,
                                                          ),
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              ColorConstants
                                                                  .lightGrey,
                                                        );
                                                      },
                                                      style: const ButtonStyle(
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                      ),
                                                      padding: EdgeInsets.zero,
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      constraints:
                                                          const BoxConstraints(),
                                                      icon: SvgPicture.asset(
                                                        Assets.moreVertical,
                                                        height: 24.0,
                                                        width: 24.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(height: 8.0);
                                          },
                                          itemCount: filteredProducts.length,
                                        );
                                      });
                                },
                              );
                      }),
                ),
              ],
            );
          }),
    );
  }
}
