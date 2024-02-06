import 'package:flutter/material.dart';
import 'package:flutter_app/models/category_model.dart';
import 'package:flutter_app/models/diet_model.dart';
import 'package:flutter_app/models/popular_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popularDiets = [];

  void _getInitialinfo() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialinfo();
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _searchField(),
          // the SizedBox widget is used to add space between the widgets.
          const SizedBox(
            height: 40,
          ),
          categoriesSection(),
          const SizedBox(
            height: 40,
          ),
          _dietSection(),
          const SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Popular',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.separated(
                itemCount: popularDiets.length,
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
                padding: const EdgeInsets.only(left: 20, right: 20),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: popularDiets[index].boxIsSelected
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: popularDiets[index].boxIsSelected
                          ? [
                        BoxShadow(
                          color: const Color(0xff1d1617).withOpacity(0.07),
                          offset: const Offset(0, 10),
                          blurRadius: 40,
                          spreadRadius: 0.0,
                        ),
                      ] : [],
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            popularDiets[index].iconPath,
                            width: 65,
                            height: 65,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                popularDiets[index].name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${popularDiets[index].level} | ${popularDiets[index].duration} | ${popularDiets[index].calorie}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            child: SvgPicture.asset(
                              'assets/icons/button.svg',
                              width: 30,
                              height: 30,
                            ),
                          )
                        ]),
                  );
                },
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Column _dietSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Text(
          'Recomendation\nfor Diet',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      SizedBox(
          height: 240,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 20, right: 20),
            scrollDirection: Axis.horizontal,
            itemCount: diets.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 25,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 210,
                decoration: BoxDecoration(
                  color: diets[index].boxColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      diets[index].iconPath,
                    ),
                    Column(
                      children: [
                        Text(diets[index].name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            )),
                        Text(
                          '${diets[index].level} | ${diets[index].duration} | ${diets[index].calorie}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 130,
                      height: 45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            diets[index].viewIsSelected
                                ? const Color(0xff9dceff)
                                : Colors.transparent,
                            diets[index].viewIsSelected
                                ? const Color(0xff92a3fd)
                                : Colors.transparent
                          ],
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'View',
                          style: TextStyle(
                            color: diets[index].viewIsSelected
                                ? Colors.white
                                : const Color(0xffc5bbf2),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ))
    ]);
  }

  Column categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The Padding widget is used to add padding around the text widget.
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Category',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
            itemCount: categories.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 25,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 100,
                decoration: BoxDecoration(
                  color: categories[index].boxColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  // For columns, the main axis is vertical and the cross axis is horizontal.
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          categories[index].iconPath,
                        ),
                      ),
                    ),
                    Text(
                      categories[index].name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // This is the search field widget extracted from the build method.
  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: const Color(0xff1d1617).withOpacity(0.11),
              blurRadius: 40,
              spreadRadius: 0.0),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(15.0),
            hintText: 'Search for recipes',
            hintStyle: const TextStyle(
              color: Color(0xffdddada),
              fontSize: 14.0,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                'assets/icons/Search.svg',
              ),
            ),
            suffixIcon: SizedBox(
              width: 100,
              child: IntrinsicHeight(
                child: Row(
                  // For rows, the main axis is horizontal and the cross axis is vertical.
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // A vertical needs to be wrapped in an IntrinsicHeight widget
                    // so that the vertical divider can take the height of the parent widget.
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 0.2,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 8, 14, 8),
                      child: SvgPicture.asset(
                        'assets/icons/Filter.svg',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none)),
      ),
    );
  }

  // This is the app bar widget extracted from the build method.
  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Breakfast',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
      leading: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xfff7f8f8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            height: 20,
            width: 20,
          )),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: 37,
              decoration: BoxDecoration(
                color: const Color(0xfff7f8f8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                'assets/icons/dots.svg',
                height: 5,
                width: 5,
              )),
        ),
      ],
    );
  }
}
