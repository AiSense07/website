import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_color.dart';

class FilterContainer extends StatefulWidget {
  const FilterContainer({Key? key}) : super(key: key);

  @override
  State<FilterContainer> createState() => _FilterContainerState();
}

class _FilterContainerState extends State<FilterContainer> {

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Manufacturers",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: AppColor.primary,
              fontSize: 18,
            ),
          ),
          Container(
            width: 250,
            height: 1,
            color: Colors.black,
            margin: const EdgeInsets.only(bottom: 10),
          ),
          SizedBox(
            height: 300,
            child: Scrollbar(
              controller: controller,
              interactive: true,
              thumbVisibility: true,
              child: ListView.builder(
                controller: controller,
                itemCount: 15,
                itemBuilder: (context, index) {
                  return InkWell(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.primary),
                              borderRadius: BorderRadius.circular(3),
                              color: index % 2 == 0 ? AppColor.primary : Colors.transparent,
                            ),
                          ),
                          Text(
                            "PLA + ( ${index + 2} )",
                            style: GoogleFonts.poppins(
                              color: AppColor.primary,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
