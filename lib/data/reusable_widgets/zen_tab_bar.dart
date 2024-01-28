import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:e_commerce/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class ZenTabBar extends StatelessWidget {
  final List<String> tabs;
  final Function(String) onTabPressed;
  final String selectedTab;

  const ZenTabBar({
    super.key,
    required this.tabs,
    required this.onTabPressed,
    required this.selectedTab,
  });

  @override
  Widget build(BuildContext context) {
    return tabs.isNotEmpty
        ? Container(
            width: double.infinity,
            height: 36.0,
            margin: const EdgeInsets.only(left: 16.0, top: 16.0),
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: ColorConstants.light,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: tabs.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              separatorBuilder: (context, index) => const SizedBox(width: 20.0),
              itemBuilder: (context, index) {
                return tabItem(tabs[index]);
              },
            ),
          )
        : const SizedBox();
  }

  Widget tabItem(String tab) => InkWell(
        onTap: () => onTabPressed(tab),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color:
                selectedTab == tab ? ColorConstants.main : Colors.transparent,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: Center(
            child: Text(
              tab.capitalize(),
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: selectedTab == tab
                    ? ColorConstants.light
                    : ColorConstants.main,
                letterSpacing: -0.24,
                height: 1.0,
              ),
            ),
          ),
        ),
      );
}
