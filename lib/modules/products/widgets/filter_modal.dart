import 'package:e_commerce/data/constants/assets.dart';
import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:e_commerce/data/constants/filter_constants.dart';
import 'package:e_commerce/data/models/sort.dart';
import 'package:e_commerce/data/reusable_widgets/primary_button.dart';
import 'package:e_commerce/modules/products/blocs/categories_bloc.dart';
import 'package:e_commerce/modules/products/blocs/products_bloc.dart';
import 'package:e_commerce/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class FilterModal extends StatelessWidget {
  final CategoriesBloc categoriesBloc;
  final ProductsBloc productsBloc;

  const FilterModal(
      {super.key, required this.categoriesBloc, required this.productsBloc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 16.0, right: 16.0, left: 16.0, bottom: 48.0),
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
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                List<String> categories = snapshot.data ?? [];
                return Wrap(
                  direction: Axis.horizontal,
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List.generate(
                    categories.length,
                    (index) {
                      return StreamBuilder<String>(
                        stream: categoriesBloc.filterCategoryStream,
                        initialData: categoriesBloc.filterCategory,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> filterCategorySnapshot) {
                          String selectedCategory =
                              filterCategorySnapshot.data ?? '';
                          return InkWell(
                            onTap: () => categoriesBloc
                                .onFilterCategoryChanged(categories[index]),
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: ColorConstants.light,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                                border: selectedCategory == categories[index]
                                    ? Border.all(
                                        color: ColorConstants.third,
                                        width: 1.0,
                                        strokeAlign:
                                            BorderSide.strokeAlignInside,
                                      )
                                    : const Border.fromBorderSide(
                                        BorderSide.none),
                              ),
                              child: Text(
                                categories[index].capitalize(),
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstants.dark,
                                  letterSpacing: -0.26,
                                ),
                              ),
                            ),
                          );
                        },
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
              FilterConstants.priceSorting.length,
              (index) {
                return StreamBuilder<Sort>(
                  stream: productsBloc.filterSortStream,
                  initialData: productsBloc.filterSort,
                  builder: (BuildContext context,
                      AsyncSnapshot<Sort> filterSortSnapshot) {
                    Sort selectedSort = filterSortSnapshot.data ?? Sort();
                    return InkWell(
                      onTap: () => productsBloc.onFilterSortChanged(
                          FilterConstants.priceSorting[index]),
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: ColorConstants.light,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          border: selectedSort.value ==
                                  FilterConstants.priceSorting[index].value
                              ? Border.all(
                                  color: ColorConstants.third,
                                  width: 1.0,
                                  strokeAlign: BorderSide.strokeAlignInside,
                                )
                              : const Border.fromBorderSide(BorderSide.none),
                        ),
                        child: Text(
                          FilterConstants.priceSorting[index].title,
                          style: const TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: ColorConstants.dark,
                            letterSpacing: -0.26,
                          ),
                        ),
                      ),
                    );
                  },
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
              FilterConstants.resultNumbers.length,
              (index) {
                return StreamBuilder<int>(
                  stream: productsBloc.filterLimitStream,
                  initialData: productsBloc.filterLimit,
                  builder: (BuildContext context,
                      AsyncSnapshot<int> filterLimitSnapshot) {
                    int selectedLimit = filterLimitSnapshot.data ?? 10;
                    return InkWell(
                      onTap: () => productsBloc.onFilterLimitChanged(
                          FilterConstants.resultNumbers[index]),
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: ColorConstants.light,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          border: selectedLimit ==
                                  FilterConstants.resultNumbers[index]
                              ? Border.all(
                                  color: ColorConstants.third,
                                  width: 1.0,
                                  strokeAlign: BorderSide.strokeAlignInside,
                                )
                              : const Border.fromBorderSide(BorderSide.none),
                        ),
                        child: Text(
                          '${FilterConstants.resultNumbers[index]}',
                          style: const TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: ColorConstants.dark,
                            letterSpacing: -0.26,
                          ),
                        ),
                      ),
                    );
                  },
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
          PrimaryButton(
            text: 'Apply Filter',
            onPressed: () =>
                productsBloc.onApplyFilterPressed(context, categoriesBloc),
          ),
          const SizedBox(height: 16.0),
          PrimaryButton(
            text: 'Cancel',
            filled: false,
            onPressed: () =>
                productsBloc.onCancelFilterPressed(context, categoriesBloc),
          ),
        ],
      ),
    );
  }
}
