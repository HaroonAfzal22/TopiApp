import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_card_pager/card_item.dart';
import 'package:horizontal_card_pager/horizontal_card_pager.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/ListCards.dart';

class SongsList extends StatefulWidget {
  const SongsList({Key? key}) : super(key: key);

  @override
  _SongsListState createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  @override
  Widget build(BuildContext context) {
    final europeanCountries = [
      'Popular',
      'TikTok',
      'Bollywood',
      'English',
    ];
    final europeanFlags = [
      'https://st2.depositphotos.com/1023173/6070/v/950/depositphotos_60708117-stock-illustration-red-hash-on-yellow.jpg',
      'https://st3.depositphotos.com/6736296/33335/v/1600/depositphotos_333352716-stock-illustration-tik-tok-logo-editorial-vector.jpg',
      'https://st2.depositphotos.com/4017237/6536/i/950/depositphotos_65367503-stock-photo-crumpled-flag-of-india.jpg',
      'https://img.freepik.com/free-vector/flag-usa-united-states-america-background_53500-169.jpg?size=626&ext=jpg',
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        brightness: Brightness.dark,
        elevation: 0.0,
        title: Text(
          'Topi',
          style: TextStyle(
              color: Color(0xffFCCC44),
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BackgroundGradient(
          childView: ListView(
            physics: ScrollPhysics(),
            children: [
              SizedBox(
                height: 8,
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ListCards(
                        text: europeanCountries[index],
                        images: CachedNetworkImage(
                          key: UniqueKey(),
                          fit: BoxFit.fill,
                          imageUrl: europeanFlags[index],
                          width: 50,
                          height: 50,
                        ),
                        onClicks: () {
                          Navigator.pushNamed(context, '/image_pickers');
                          print('click at ${europeanCountries[index]}');
                        });
                  },
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    if(isClick.length!=4){
                      isClick.add(false);
                    }
                    return GestureDetector(
                      onTap: () {
                        //   Navigator.pushNamed(context, '/share_file');
                        setState(() {
                          if(isClick[index]==true){
                              isClick[index]=false;
                          }else{
                          isClick[index]=true;
                          }
                          print('down card click $isClick');
                        });

                      },
                      child: Card(
                        child: ListTile(
                          leading: Icon(clickIcon(index)),
                          title: Center(child: Text(europeanCountries[index])),
                          subtitle:
                              Center(child: Text(europeanCountries[index])),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<bool> isClick = [];

  clickIcon(index) {
    if (isClick[index]==true) {
      return Icons.pause;
    } else {
      return Icons.play_arrow;
    }
  }
}
