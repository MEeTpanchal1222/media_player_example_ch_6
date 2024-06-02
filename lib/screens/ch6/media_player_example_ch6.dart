import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

final themeMode = ValueNotifier(2);

class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, value,g) {
        return MaterialApp(
          initialRoute: '/',
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.values.toList()[value as int],
          debugShowCheckedModeBanner: false,
          home: CarouselWithIndicatorDemo(),
        );
      },
      valueListenable: themeMode,
    );
  }
}






final List<Widget> imageSliders = imgList.map((item) => Container(
  child: Container(
    height: 550,
    width: 500,
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: Stack(
          children: <Widget>[
            Image.asset(item['IMAGE'], fit: BoxFit.cover,width: double.infinity,height: double.infinity),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  '${item['WORD']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )),
  ),
)
)
    .toList();




class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('India Today'),
        actions: [
          IconButton(
              icon: Icon(Icons.nightlight_round),
              onPressed: () {
                themeMode.value = themeMode.value == 1 ? 2 : 1;
              })
        ],
      ),
      body: Column(children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 0.9,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                enlargeFactor: 0.5,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}



