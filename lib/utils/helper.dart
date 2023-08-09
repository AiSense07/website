import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Horizontal padding of the whole app
const double appPaddingX = 10;

int getColorCode(String color) {
  return int.parse(color.replaceAll("#", "0xff"));
}

pushReplacement(BuildContext context, Widget destination) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => destination),
  );
}

push(BuildContext context, Widget destination) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => destination),
  );
}

pop(BuildContext context) {
  Navigator.pop(context);
}

void commonToast(BuildContext context, String msg, {Color? color}) {
  Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      msg: msg,
      timeInSecForIosWeb: 2,
      backgroundColor: color ?? Colors.black,
      textColor: Colors.white);
}

void logLongString(String s) {
  if (s.isEmpty) return;
  const int n = 1000;
  int startIndex = 0;
  int endIndex = n;
  while (startIndex < s.length) {
    if (endIndex > s.length) endIndex = s.length;
    print(s.substring(startIndex, endIndex));
    startIndex += n;
    endIndex = startIndex + n;
  }
}

double responsivePaddingWidth(BoxConstraints constraints, BuildContext context) {
  if (constraints.maxWidth <= 500) {
    return appPaddingX;
  } else {
    return MediaQuery.of(context).size.width * 0.09;
  }
}

double responsivePaddingWidthAppBar(BoxConstraints constraints, BuildContext context) {
  if (constraints.maxWidth <= 500) {
    return appPaddingX;
  } else {
    return MediaQuery.of(context).size.width * 0.08;
  }
}

double responsivePaddingWidthForCategory(BoxConstraints constraints, BuildContext context) {
  if (constraints.maxWidth <= 500) {
    return appPaddingX;
  } else {
    return MediaQuery.of(context).size.width * 0.05;
  }
}

double responsivePaddingWidthForSafety(BoxConstraints constraints, BuildContext context) {
  if (constraints.maxWidth <= 500) {
    return appPaddingX;
  } else {
    return MediaQuery.of(context).size.width * 0.02;
  }
}

bool responsiveBoolean(BoxConstraints constraints, BuildContext context) {
  if (constraints.maxWidth <= 500) {
    return true;
  } else {
    return false;
  }
}

double footerHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

List<String> images = [
  "https://c-3d.niceshops.com/upload/image/product/large/default/6766_771aaeea.512x512.jpg",
  "https://c-3d.niceshops.com/upload/image/product/large/default/6767_800196d5.512x512.jpg",
  "https://c-3d.niceshops.com/upload/image/product/large/default/6814_561c87b7.512x512.jpg",
  "https://c-3d.niceshops.com/upload/image/product/large/default/6815_05ede6bb.512x512.jpg",
  "https://c-3d.niceshops.com/upload/image/product/large/default/6816_4d3d1b4a.512x512.jpg",
  "https://c-3d.niceshops.com/upload/image/product/large/default/6817_ffa0f748.512x512.jpg",
  "https://c-3d.niceshops.com/upload/image/product/large/default/6892_220548d6.512x512.jpg"
];
List<String> product = [
  "https://c-3d.niceshops.com/upload/image/product/large/default/23783_.256x256.jpg",
  "https://c-3d.niceshops.com/upload/image/product/large/default/30155_a9ec5c37.256x256.webp",
  "https://c-3d.niceshops.com/upload/image/product/large/default/4641_bfd3f562.256x256.jpg",
  "https://c-3d.niceshops.com/upload/image/banner_element/original/default/27499_3943cd44.363x0.jpg",
  "https://c-3d.niceshops.com/upload/image/product/large/default/23996_d99798e7.256x256.jpg",
  "https://c-3d.niceshops.com/upload/image/banner_element/original/default/22810_b0d71d74.363x0.jpg",
  "https://c-3d.niceshops.com/upload/image/product/large/default/17465_f939d6e4.256x256.jpg",
  "https://c-3d.niceshops.com/upload/image/product/large/default/8028_e388a5c2.256x256.jpg",
  "https://danhaive.com/assets/img/05_shoe3.png",
  "https://prototypeinfo.com/wp-content/uploads/sites/75/2021/07/5-3d-printed-products-qualities-of-3D-printing.jpg",
  "https://3dprintingindustry.com/wp-content/uploads/2014/11/SUPER3DM_Designed-Products.jpg",
  "https://images.squarespace-cdn.com/content/v1/54d135aae4b0553df777d404/143205"
      "2394765-PL9655XZNX0S59LUM1KS/iphone-3d-printed-heels-3.jpg?format=1000w",
];
List<String> color = [
  "https://c-3d.niceshops.com/upload/image/product/original/default/19880_5d4ec8b0.128x128.jpg",
  "https://c-3d.niceshops.com/upload/image/product/original/default/19863_61946e10.128x128.jpg",
  "https://c-3d.niceshops.com/upload/image/product/original/default/28238_220097ca.128x128.webp",
  "https://c-3d.niceshops.com/upload/image/product/original/default/28235_b8c757bd.128x128.webp",
  "https://c-3d.niceshops.com/upload/image/product/original/default/28237_73d895c4.128x128.webp",
  "https://c-3d.niceshops.com/upload/image/product/original/default/28239_d6c7619d.128x128.webp",
  "https://c-3d.niceshops.com/upload/image/product/original/default/19855_a4dbfd73.128x128.jpg",
  "https://c-3d.niceshops.com/upload/image/product/original/default/28240_e2139371.128x128.webp",
  "https://c-3d.niceshops.com/upload/image/product/original/default/28232_6bf67e72.128x128.webp",
  "https://c-3d.niceshops.com/upload/image/product/original/default/19872_37a1d15d.128x128.jpg",
  "https://c-3d.niceshops.com/upload/image/product/original/default/28080_5d65a09c.128x128.png",
  "https://c-3d.niceshops.com/upload/image/product/original/default/19884_5789b194.128x128.jpg",
  "https://c-3d.niceshops.com/upload/image/product/original/default/19876_7c3d94fa.128x128.jpg",
  "https://c-3d.niceshops.com/upload/image/product/original/default/21693_66aea7ae.128x128.jpg",
  "https://c-3d.niceshops.com/upload/image/product/original/default/23619_411f64e4.128x128.jpg",
];
List<String> brand = [
  "https://diy3d.in/cdn/shop/files/Untitled_design_23_185x.png?v=1665140621",
  "https://diy3d.in/cdn/shop/files/Untitled_design_22_185x.png?v=1665140565",
  "https://diy3d.in/cdn/shop/files/Untitled_design_24_185x.png?v=1665140684",
  "https://diy3d.in/cdn/shop/files/3_185x.png?v=1663738850",
  "https://diy3d.in/cdn/shop/files/Untitled_design_19_185x.png?v=1665140303",
  "https://diy3d.in/cdn/shop/files/Untitled_design_18_185x.png?v=1665140198",
  "https://diy3d.in/cdn/shop/files/Untitled_design_25_185x.png?v=1665140831",
  "https://diy3d.in/cdn/shop/files/Untitled_design_16_185x.png?v=1665139898",
  "https://diy3d.in/cdn/shop/files/Untitled_design_17_185x.png?v=1665140062",
  "https://diy3d.in/cdn/shop/files/Untitled_design_20_185x.png?v=1665140371",
];

List<Map<String, String>> tech = [
  {
    "title": "Item no.",
    "text": "PM-70820",
  },
  {
    "title": "Manufacturer no.",
    "text": "PM70820",
  },
  {
    "title": "Manufacturers",
    "text": "Polymaker",
  },
  {
    "title": "Product types",
    "text": "PLA Filaments",
  },
  {
    "title": "Filament colour",
    "text": "Black",
  },
  {
    "title": "Net weight",
    "text": "1000 g",
  },
  {
    "title": "Recommended heating temperature",
    "text": "25 - 60 °C",
  },
  {
    "title": "Recommended processing temperature",
    "text": "190 - 230 °C",
  },
  {
    "title": "Diameter",
    "text": "1,75 mm",
  },
];
List<Map<String, String>> desc = [
  {
    "title": "Reduced plastic content",
    "text": "PolyTerra PLA is a bioplastic 3D printing "
        "filament in which organic materials have been "
        "combined with PLA to reduce the plastic content "
        "and develop a more environmentally friendly filament.",
  },
  {
    "title": "Easy processing",
    "text":
        "PolyTerra prints just like PLA, so no print settings need to be changed and the overhang and bridging functions can even outperform PLA. With a wide printing temperature range from 190 to 230 ° C, PolyTerra can be processed on any extrusion-based 3D printer.",
  },
  {
    "title": "Versatile use",
    "text":
        "The mechanical properties of PolyTerra offer a wide range of possible applications as the material is tougher than normal PLA and still retains good rigidity. Both figures and fixtures can be printed with excellent results.",
  },
];

List<String> statesListTitles = [
  "Maharashtra",
  "Karnataka",
  "Andhra Pradesh",
  "Gujarat",
  "Andaman and Nicobar Island (UT)",
  "Arunachal Pradesh",
  "Assam",
  "Bihar",
  "Chandigarh (UT)",
  "Chhattisgarh",
  "Dadra and Nagar Haveli (UT)",
  "Daman and Diu (UT)",
  "Delhi (NCT)",
  "Goa",
  "Haryana",
  "Himachal Pradesh",
  "Jammu and Kashmir",
  "Jharkhand",
  "Kerala",
  "Lakshadweep (UT)",
  "Madhya Pradesh",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Puducherry (UT)",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttar Pradesh",
  "Uttarakhand",
  "West Bengal"
];
