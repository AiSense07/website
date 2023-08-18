import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:three_connects/presentation/widgets/enddrawer.dart';
import 'package:three_connects/presentation/widgets/filter_container.dart';
import 'package:three_connects/presentation/widgets/footer.dart';
import 'package:three_connects/presentation/widgets/product_container.dart';
import 'package:three_connects/utils/app_color.dart';
import 'package:three_connects/utils/helper.dart';
import '../../utils/navigation_string.dart';
import '../widgets/appbar.dart';
import '../widgets/custom_widgets.dart';
import '../widgets/pagination.dart';

class ProductList extends StatefulWidget {
  final String path;
  final String? cat;
  final int? page;

  const ProductList({Key? key, required this.path, this.cat, this.page}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  String dropDown = "Relevance";

  int initial = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    log("message ${size.width}");
    return Scaffold(
      endDrawer: const EndDrawer(),
      body: ListView(
        children: [
          const CommonAppbar(),
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: contentSize(size, 1250, size.width),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemCount: spareCat.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: size.width > 950 ? 6 : size.width > 730 ? 5 : 4,
                          crossAxisSpacing: size.width > 950 ? 10 : 5,
                          mainAxisSpacing: size.width > 950 ? 10 : 5,
                          childAspectRatio: contentSize(
                            size,
                            0.8,
                            sizes(size, size.width * 0.0007, size.width * 0.0009),
                          ),
                        ),
                        itemBuilder: (context, index) {
                          return CustomInkWell(
                            onTap: () {
                              context.beamToNamed(
                                  "/3d-printed-parts?category=${spareCat[index]['name'] ?? ""}"
                                  "&page=$index");
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Image.asset(spareCat[index]['img'] ?? ""),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "spareCat[index]['name'] ?? """,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      if (size.width < 1000)
                        Text(
                          "${widget.path}: 150 products",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (size.width > 1000)
                            Text(
                              "${widget.path}: 150 products",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            )
                          else
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              onTap: () {},
                              child: Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: AppColor.primary),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.filter_list_rounded, size: 18),
                                    if (size.width > 310) const SizedBox(width: 5),
                                    if (size.width > 310)
                                      const Text(
                                        "Filter",
                                        style: TextStyle(color: Colors.black, fontSize: 12),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (size.width > 310)
                                const Text(
                                  "Sort by ",
                                  style: TextStyle(color: Colors.black, fontSize: 12),
                                ),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: AppColor.primary),
                                ),
                                child: DropdownButton(
                                    style: const TextStyle(fontSize: 13, color: Colors.black),
                                    underline: const SizedBox(),
                                    value: dropDown,
                                    isDense: false,
                                    focusColor: Colors.transparent,
                                    borderRadius: BorderRadius.circular(5),
                                    items: [
                                      "Relevance",
                                      "Price high to low",
                                      "Price low to high",
                                      "Best Sellers",
                                      "Customer Reviews",
                                    ]
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropDown = value!;
                                      });
                                    }),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        color: AppColor.primary,
                        margin: const EdgeInsets.only(top: 10, bottom: 20),
                        height: 1,
                        width: contentSize(
                            size, 900, size.width > 1000 ? size.width - 230 : size.width - 30),
                      ),
                      GridView.builder(
                        itemCount: 12,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: size.width > 620
                              ? 3
                              : size.width > 320
                                  ? 2
                                  : 1,
                          childAspectRatio: size.width > 1250
                              ? 0.58
                              : size.width > 1150
                                  ? size.width * 0.00048
                                  : size.width > 1000
                                      ? size.width * 0.00045
                                      : size.width > 620
                                          ? size.width * 0.0006
                                          : size.width > 500
                                              ? size.width * 0.0009
                                              : size.width > 320
                                                  ? size.width * 0.0012
                                                  : size.width * 0.0022,
                        ),
                        itemBuilder: (context, index) {
                          return ProductContainer(index: index, path: widget.path);
                        },
                      ),
                      Container(
                        color: AppColor.primary,
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        height: 1,
                        width: contentSize(
                            size, 900, size.width > 1000 ? size.width - 230 : size.width - 30),
                      ),
                      NumberPaginators(
                        numberPages: 10,
                        onPageChange: (int index) {
                          context.beamToNamed(
                              "/3d-printed-parts?subcategory=${widget.cat}&page=$index");
                        },
                        // initially selected index
                        initialPage: widget.page ?? 0,
                        config: const NumberPaginatorUIConfig(
                          contentPadding: EdgeInsets.zero,
                          mode: ContentDisplayMode.numbers,
                          height: 40,
                          buttonSelectedForegroundColor: Colors.white,
                          buttonUnselectedForegroundColor: Colors.black,
                          buttonUnselectedBackgroundColor: Colors.transparent,
                          buttonSelectedBackgroundColor: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const FooterBoard(false),
        ],
      ),
    );
  }
}
