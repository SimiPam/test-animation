import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../image_data.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Color(0xFFF3F5F7),
          borderRadius: BorderRadius.circular(isDrawOpen ? 40 : 0)),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30, left: 6, right: 6, bottom: 15),
            // margin: EdgeInsets.symmetric(vertical: 25, horizontal: 6 ),
            child: Row(
              children: [
                isDrawOpen
                    ? IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          setState(() {
                            xOffset = 0;
                            yOffset = 0;
                            scaleFactor = 1;
                            isDrawOpen = false;
                          });
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          setState(() {
                            xOffset = 200;
                            yOffset = 130;
                            scaleFactor = 0.7;
                            isDrawOpen = true;
                          });
                        },
                      ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Todos",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(child: PinterestGrid()),
        ],
      ),
    );
  }
}

class PinterestGrid extends StatelessWidget {
  const PinterestGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      StaggeredGridView.countBuilder(
        padding: EdgeInsets.only(left: 10, right: 10),
        crossAxisCount: 2,
        itemCount: imageList.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        itemBuilder: (context, index) => ImageCard(
          imageData: imageList[index],
          index: index,
        ),
      ),
      Positioned(
        bottom: 10,
        left: 177,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    ]);
  }
}

final _lightColors = [
  // Colors.amber.shade300.withOpacity(0.2),
  Colors.lightGreen.shade300.withOpacity(0.3),
  // Colors.lightBlue.shade300.withOpacity(0.2),
  // Colors.orange.shade300.withOpacity(0.2),
  // Colors.pinkAccent.shade100.withOpacity(0.2),
  Colors.tealAccent.shade100.withOpacity(0.2),
  Color(0xff092E34).withOpacity(0.3),
  Color(0xff489FB5).withOpacity(0.3),
  Color(0xffFFA62B).withOpacity(0.3),
  Color(0xffCC7700).withOpacity(0.3)
];

class ImageCard extends StatelessWidget {
  const ImageCard({this.imageData, this.index});

  final ImageData imageData;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = _lightColors[index % _lightColors.length];

    return Card(
      elevation: 0,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        child: Container(
          // height: 100,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: color, width: 5),
            ),
          ),
          child: Text(
            "testing 123wertgggggggggggg"
            ""
            ""
            ""
            "edrg",
          ),
        ),
      ),
    );
  }
}

// constraints: BoxConstraints(minHeight: minHeight),

// final minHeight = getMinHeight(index);
// double getMinHeight(int index) {
//   switch (index % 4) {
//     case 0:
//       return 100;
//     case 1:
//       return 150;
//     case 2:
//       return 150;
//     case 3:
//       return 100;
//     default:
//       return 100;
//   }
// }
// @override
// Widget build(BuildContext context) {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(16.0),
//     child: Image.network(imageData.imageUrl, fit: BoxFit.cover),
//   );
// }
