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
      'Albania',
      'Andorra',
      'Armenia',
      'Austria',
      'Azerbaijan',
      'Belarus',
      'Belgium',
      'Bosnia and Herzegovina',
      'Bulgaria',
      'Croatia',
      'Cyprus',
      'Czech Republic',
      'Denmark',
      'Estonia',
      'Finland',
      'France',
      'Georgia',
      'Germany',
      'Greece',
      'Hungary',
      'Iceland',
      'Ireland',
      'Italy',
      'Kazakhstan',
      'Kosovo',
      'Latvia',
      'Liechtenstein',
      'Lithuania',
      'Luxembourg',
      'Macedonia',
      'Malta',
      'Moldova',
      'Monaco',
      'Montenegro',
      'Netherlands',
      'Norway',
      'Poland',
      'Portugal',
      'Romania',
      'Russia',
      'San Marino',
      'Serbia',
      'Slovakia',
      'Slovenia',
      'Spain',
      'Sweden',
      'Switzerland',
      'Turkey',
      'Ukraine',
      'United Kingdom',
      'Vatican City'
    ];
    final europeanFlags = [
      'https://cdn.britannica.com/00/6200-004-42B7690E/Flag-Albania.jpg',
      'https://cdn.britannica.com/83/5583-004-FCE4E901/Flag-Andorra.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Flag_of_Armenia.svg/1280px-Flag_of_Armenia.svg.png',
      'https://cdn.britannica.com/73/6073-004-B0B9EBEE/Flag-Austria.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Flag_of_Azerbaijan.svg/255px-Flag_of_Azerbaijan.svg.png',
      'https://cdn.britannica.com/01/6401-004-FAEACB4E/Flag-Belarus.jpg',
      'https://cdn.britannica.com/08/6408-004-405E272F/Flag-Belgium.jpg',
      'https://cdn.britannica.com/w:400,h:300,c:crop/02/6202-050-E13D91F5/Flag-Bosnia-and-Herzegovina.jpg',
      'https://cdn.britannica.com/04/6204-004-DC5CFE4F/Flag-Bulgaria.jpg',
      'https://cdn.britannica.com/06/6206-004-14730C28/Flag-Croatia.jpg',
      'https://cdn.britannica.com/83/7883-004-D09910C5/Flag-Cyprus.jpg',
      'https://cdn.britannica.com/86/7886-004-323985BD/Flag-Czech-Republic.jpg',
      'https://cdn.britannica.com/07/8007-004-8CF0B1A9/Flag-Denmark.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Flag_of_Estonia.svg/2560px-Flag_of_Estonia.svg.png',
      'https://cdn.britannica.com/79/579-004-0EA4217C/Flag-Finland.jpg',
      'https://cdn.britannica.com/82/682-004-F0B47FCB/Flag-France.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag_of_Georgia.svg/1200px-Flag_of_Georgia.svg.png',
      'https://upload.wikimedia.org/wikipedia/en/thumb/b/ba/Flag_of_Germany.svg/1200px-Flag_of_Germany.svg.png',
      'https://cdn.britannica.com/49/1049-004-AE4BAD3E/Flag-Greece.jpg',
      'https://cdn.britannica.com/55/1455-004-5897143C/Flag-Hungary.jpg',
      'https://cdn.britannica.com/85/1485-004-94C3DEDA/Flag-Iceland.jpg',
      'https://cdn.britannica.com/33/1733-004-5BA407D6/FLAG-Ireland.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Flag_of_Italy_%282003%E2%80%932006%29.svg/1280px-Flag_of_Italy_%282003%E2%80%932006%29.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Flag_of_Kazakhstan.svg/1000px-Flag_of_Kazakhstan.svg.png',
      'https://cdn.britannica.com/18/114418-004-2A12F087/Flag-Kosovo.jpg',
      'https://cdn.britannica.com/49/6249-004-D8906A92/Flag-Latvia.jpg',
      'https://cdn.britannica.com/02/2102-050-2976AFDD/Flag-Liechtenstein.jpg',
      'https://cdn.britannica.com/52/6252-004-88DCF537/Flag-Lithuania.jpg',
      'https://cdn.britannica.com/23/2223-050-6771361A/Flag-Luxembourg.jpg',
      'https://cdn.britannica.com/08/6208-004-61460B40/Flag-North-Macedonia.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Flag_of_Malta.svg/255px-Flag_of_Malta.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Flag_of_Moldova.svg/2560px-Flag_of_Moldova.svg.png',
      'https://cdn.britannica.com/50/2750-050-688E6E49/Flag-Monaco.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Flag_of_Montenegro.svg/2560px-Flag_of_Montenegro.svg.png',
      'https://cdn.britannica.com/82/2982-050-4A783E03/flag-prototype-Netherlands-countries-European-flags.jpg',
      'https://cdn.britannica.com/01/3101-004-506325BB/Flag-Norway.jpg',
      'https://upload.wikimedia.org/wikipedia/en/thumb/1/12/Flag_of_Poland.svg/1200px-Flag_of_Poland.svg.png',
      'https://www.worldatlas.com/img/flag/pt-flag.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Flag_of_Romania.svg/1200px-Flag_of_Romania.svg.png',
      'https://cdn.britannica.com/42/3842-004-F47B77BC/Flag-Russia.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Flag_of_San_Marino.svg/2560px-Flag_of_San_Marino.svg.png',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Flag_of_Serbia.svg/2560px-Flag_of_Serbia.svg.png',
      'https://cdn.britannica.com/88/7888-004-FD4BC606/Flag-Slovakia.jpg',
      'https://cdn.britannica.com/15/6215-004-B8508AEB/Flag-Slovenia.jpg',
      'https://cdn.britannica.com/36/4336-004-6BD81071/Flag-Spain.jpg',
      'https://upload.wikimedia.org/wikipedia/en/thumb/4/4c/Flag_of_Sweden.svg/1200px-Flag_of_Sweden.svg.png',
      'https://cdn.britannica.com/43/4543-004-C0D5C6F4/Flag-Switzerland.jpg',
      'https://cdn.britannica.com/82/4782-004-4119489D/Flag-Turkey.jpg',
      'https://cdn.britannica.com/14/4814-004-7C0DF1BB/Flag-Ukraine.jpg',
      'https://upload.wikimedia.org/wikipedia/en/thumb/a/ae/Flag_of_the_United_Kingdom.svg/1200px-Flag_of_the_United_Kingdom.svg.png',
      'https://i.pinimg.com/originals/80/42/22/804222772c546f30332dbc11871e932e.jpg'
    ];
    return Scaffold(
      body: SafeArea(
        child: BackgroundGradient(
          childView : ListView(
            physics: ScrollPhysics(),
            children: [
              SizedBox(height: 8,),
              Container(
                height: 100,
                child: ListView.builder(
                 physics: ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: europeanCountries.length,
                  itemBuilder: (context, index) {
                    return ListCards(
                        text: europeanCountries[index],
                        images:CachedNetworkImage(
                          key: UniqueKey(),
                          fit: BoxFit.fill,
                          imageUrl: europeanFlags[index],
                          width: 50,
                          height: 50,
                        ),
                        onClicks: (){
                          Navigator.pushNamed(context, '/image_pickers');
                      print('click at ${europeanCountries[index]}');
                    });
                  },
                ),
              ),
              SizedBox(height: 8,),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: europeanFlags.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap:(){
                        Navigator.pushNamed(context, '/share_file');
                      } ,
                      child: Card(
                        child: ListTile(
                          leading:CachedNetworkImage(
                            width: 50,
                            height: 50,
                            key: UniqueKey(),
                            imageUrl: europeanFlags[index],
                          ),
                          title: Text(europeanCountries[index]),
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
}
/*

ListCards(
text: ,
images:
onClicks: (){
print('click at ${europeanCountries[index]}');
});*/
