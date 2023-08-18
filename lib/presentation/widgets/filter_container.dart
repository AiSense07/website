import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';


import '../../utils/app_color.dart';
import '../../utils/navigation_string.dart';

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
          const Text(
            "Manufacturers",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
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
                    onTap: () {
                      context.beamToNamed("/3d-printed-parts?subcategory=$index&page=0");
                    },
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
                            style: const TextStyle(
                              color: Colors.black,
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
