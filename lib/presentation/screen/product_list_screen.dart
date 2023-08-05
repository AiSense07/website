import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:number_paginator/number_paginator.dart';
import 'package:three_connects/presentation/widgets/filter_container.dart';
import 'package:three_connects/presentation/widgets/footer.dart';
import 'package:three_connects/presentation/widgets/product_container.dart';
import 'package:three_connects/utils/app_color.dart';
import '../widgets/appbar.dart';
import '../widgets/custom_widgets.dart';
import 'cart_modual/cart_screen.dart';

class ProductList extends StatefulWidget {
  final String path;

  const ProductList({Key? key, required this.path}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  String dropDown = "Relevance";
  final NumberPaginatorController _controller = NumberPaginatorController();

  int initial = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    log("==>>>> ${size.width}");
    return Scaffold(
      endDrawer: const CartScreen(),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (size.width > 1000)
                        const SizedBox(
                          width: 230,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FilterContainer(),
                              FilterContainer(),
                            ],
                          ),
                        ),
                      SizedBox(
                        width: contentSize(
                            size, 900, size.width > 1000 ? size.width - 300 : size.width - 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (size.width < 1000)
                              Text(
                                "${widget.path}: 150 products",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.primary,
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.primary,
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
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
                                            Text(
                                              "Filter",
                                              style:
                                                  TextStyle(color: AppColor.primary, fontSize: 12),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (size.width > 310)
                                      Text(
                                        "Sort by ",
                                        style: TextStyle(color: AppColor.primary, fontSize: 12),
                                      ),
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: AppColor.primary),
                                      ),
                                      child: DropdownButton(
                                          style: const TextStyle(
                                              fontSize: 13, color: AppColor.primary),
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
                              width: contentSize(size, 900,
                                  size.width > 1000 ? size.width - 230 : size.width - 30),
                            ),
                            GridView.builder(
                              itemCount: 12,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: size.width > 620
                                    ? 3
                                    : size.width > 350
                                        ? 2
                                        : 1,
                                childAspectRatio: size.width > 1250
                                    ? 0.65
                                    : size.width > 1150
                                        ? size.width * 0.00053
                                        : size.width > 1000
                                            ? size.width * 0.000505
                                            : size.width > 620
                                                ? size.width * 0.00068
                                                : size.width > 500
                                                    ? size.width * 0.001
                                                    : size.width > 350
                                                        ? size.width * 0.0014
                                                        : size.width * 0.0025,
                              ),
                              itemBuilder: (context, index) {
                                return ProductContainer(index: index, path: widget.path);
                              },
                            ),
                            Container(
                              color: AppColor.primary,
                              margin: const EdgeInsets.only(top: 20, bottom: 20),
                              height: 1,
                              width: contentSize(size, 900,
                                  size.width > 1000 ? size.width - 230 : size.width - 30),
                            ),
                            NumberPaginator(
                              numberPages: (150 / 12).round(),
                              controller: _controller,
                              initialPage: initial,
                              onPageChange: (int index) {
                                setState(() {
                                  initial = index;
                                });
                              },
                            ),
                          ],
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
