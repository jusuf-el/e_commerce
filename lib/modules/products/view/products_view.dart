import 'package:e_commerce/data/constants/assets.dart';
import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/data/reusable_widgets/input_field.dart';
import 'package:e_commerce/data/reusable_widgets/primary_app_bar.dart';
import 'package:e_commerce/data/reusable_widgets/primary_button.dart';
import 'package:e_commerce/modules/product_details/product_details_view.dart';
import 'package:e_commerce/modules/products/blocs/categories_bloc.dart';
import 'package:e_commerce/modules/products/blocs/products_bloc.dart';
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

  final List<String> priceSorting = ['Highest price', 'Lowest price'];
  final List<int> resultNumbers = [10, 20, 30, 50];

  @override
  void initState() {
    super.initState();
    categoriesBloc.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
                  borderRadius: const BorderRadius.all(Radius.circular(22)),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0,
                                right: 16.0,
                                left: 16.0,
                                bottom: 48.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: SvgPicture.asset(Assets.dragHandle),
                                ),
                                const SizedBox(height: 24.0),
                                const Text(
                                  'Filter',
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
                                const SizedBox(height: 24.0),
                                const Text(
                                  'Category',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.dark,
                                    letterSpacing: -0.34,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                StreamBuilder<List<String>>(
                                    stream: categoriesBloc.categoriesStream,
                                    initialData: categoriesBloc.categories,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<String>> snapshot) {
                                      List<String> categories =
                                          snapshot.data ?? [];
                                      return Wrap(
                                        direction: Axis.horizontal,
                                        spacing: 8.0,
                                        runSpacing: 8.0,
                                        children: List.generate(
                                          categories.length,
                                          (index) {
                                            return Container(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              decoration: BoxDecoration(
                                                color: ColorConstants.light,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(4.0)),
                                                border: index == 1
                                                    ? Border.all(
                                                        color: ColorConstants
                                                            .third,
                                                        width: 1.0,
                                                        strokeAlign: BorderSide
                                                            .strokeAlignInside,
                                                      )
                                                    : const Border
                                                        .fromBorderSide(
                                                        BorderSide.none),
                                              ),
                                              child: Text(
                                                categories[index],
                                                style: const TextStyle(
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstants.dark,
                                                  letterSpacing: -0.26,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }),
                                const SizedBox(height: 16.0),
                                const Text(
                                  'Sort by price',
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
                                    priceSorting.length,
                                    (index) {
                                      return Container(
                                        padding: const EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          color: ColorConstants.light,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(4.0)),
                                          border: index == 0
                                              ? Border.all(
                                                  color: ColorConstants.third,
                                                  width: 1.0,
                                                  strokeAlign: BorderSide
                                                      .strokeAlignInside,
                                                )
                                              : const Border.fromBorderSide(
                                                  BorderSide.none),
                                        ),
                                        child: Text(
                                          priceSorting[index],
                                          style: const TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w400,
                                            color: ColorConstants.dark,
                                            letterSpacing: -0.26,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                const Text(
                                  'Number of results',
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
                                    resultNumbers.length,
                                    (index) {
                                      return Container(
                                        padding: const EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          color: ColorConstants.light,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(4.0)),
                                          border: index == 0
                                              ? Border.all(
                                                  color: ColorConstants.third,
                                                  width: 1.0,
                                                  strokeAlign: BorderSide
                                                      .strokeAlignInside,
                                                )
                                              : const Border.fromBorderSide(
                                                  BorderSide.none),
                                        ),
                                        child: Text(
                                          '${resultNumbers[index]}',
                                          style: const TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w400,
                                            color: ColorConstants.dark,
                                            letterSpacing: -0.26,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 32.0),
                                const Divider(
                                  color: ColorConstants.neutral,
                                  thickness: 1.0,
                                  height: 1.0,
                                ),
                                const SizedBox(height: 24.0),
                                const PrimaryButton(text: 'Apply Filter'),
                                const SizedBox(height: 16.0),
                                const PrimaryButton(
                                    text: 'Cancel', filled: false),
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
                    );
                  },
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
          StreamBuilder<List<String>>(
              stream: categoriesBloc.categoriesStream,
              initialData: categoriesBloc.categories,
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
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
                        onTap: () =>
                            categoriesBloc.onCategoryChanged(categories[index]),
                        child: StreamBuilder<String>(
                            stream: categoriesBloc.selectedCategoryStream,
                            initialData: categoriesBloc.selectedCategory,
                            builder: (BuildContext context,
                                AsyncSnapshot<String>
                                    selectedCategorySnapshot) {
                              String selectedCategory =
                                  selectedCategorySnapshot.data ?? '';
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0)),
                                  color: selectedCategory == categories[index]
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
                                    color: selectedCategory == categories[index]
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
              }),
          Expanded(
            child: StreamBuilder<List<Product>>(
              stream: productsBloc.productsStream,
              initialData: productsBloc.products,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Product>> productsSnapshot) {
                List<Product> products = productsSnapshot.data ?? [];
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
                            builder: (BuildContext context) =>
                                ProductDetailsView(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: ColorConstants.lightGrey,
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 70.0,
                              width: 70.0,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 7.0),
                              child: Image.network(products[index].image),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        products[index].category.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 8.0,
                                          fontWeight: FontWeight.w400,
                                          color: ColorConstants.baseBlack,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        products[index].title,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: ColorConstants.main,
                                          letterSpacing: -0.24,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    products[index].price,
                                    // '\$109.95',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.baseBlack,
                                      letterSpacing: -0.32,
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
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16.0,
                                            right: 16.0,
                                            left: 16.0,
                                            bottom: 48.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: SvgPicture.asset(
                                                  Assets.dragHandle),
                                            ),
                                            const SizedBox(height: 24.0),
                                            Text(
                                              products[index].title,
                                              style: const TextStyle(
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
                                            const SizedBox(height: 24.0),
                                            const PrimaryButton(
                                              text: 'Edit product',
                                              icon: Assets.edit,
                                            ),
                                            const SizedBox(height: 16.0),
                                            const PrimaryButton(
                                              text: 'Delete product',
                                              filled: false,
                                              icon: Assets.delete,
                                            ),
                                          ],
                                        ),
                                      ),
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
                                );
                              },
                              style: const ButtonStyle(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              constraints: const BoxConstraints(),
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
                  itemCount: products.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
