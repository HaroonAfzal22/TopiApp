
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:topi/ListCards.dart';
import 'constants.dart';

class CategoryLists extends StatefulWidget {
  var europeanCountries;

  CategoryLists({required this.europeanCountries,required this.isLoading,required this.getSongsList});

  bool isLoading;
  Function getSongsList;
  @override
  _CategoryListsState createState() => _CategoryListsState();
}

class _CategoryListsState extends State<CategoryLists> {

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Center(
      child: spinkit,
    ) :SizedBox(
      height: 80,
      child: Container(
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: widget.europeanCountries.length,
          itemBuilder: (context, index) {
            return ListCards(
                text: widget.europeanCountries[index]
                ['category_name'],
                images: CachedNetworkImage(
                  key: UniqueKey(),
                  fit: BoxFit.fill,
                  imageUrl: widget.europeanCountries[index]
                  ['category_image'],
                  width: 50,
                  height: 50,
                ),
                onClicks: () {
                  setState(() {
                    widget.isLoading = true;
                  });
                  widget.getSongsList(
                      widget.europeanCountries[index]['id']);
                });
          },
        ),
      ),
    );
  }
}