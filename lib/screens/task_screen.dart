import 'package:animated_login_fb_app/config/palette.dart';
import 'package:animated_login_fb_app/model/todo_model.dart';
import 'package:animated_login_fb_app/services/db_service.dart';
import 'package:animated_login_fb_app/utils/colors.dart';
import 'package:animated_login_fb_app/utils/sizes.dart';
import 'package:animated_login_fb_app/widgets/sign_in_up_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

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
  // TextEditingController todoTitleController = TextEditingController();

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
          Expanded(child: TaskGrid()),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskGrid extends StatelessWidget {
  TextEditingController todoTitleController = TextEditingController();
  TextEditingController todoDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(children: [
      StreamBuilder<List<Todo>>(
          stream: DatabaseService().listTodos(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LoadingIndicator(isLoading: true),
              );
            }
            List<Todo> todos = snapshot.data;
            return StaggeredGridView.countBuilder(
              padding: EdgeInsets.only(left: 10, right: 10),
              crossAxisCount: 2,
              itemCount: todos.length,
              staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              itemBuilder: (context, index) => ImageCard(
                taskData: todos[index],
                index: index,
              ),
            );
          }),
      Positioned(
        bottom: 10,
        left: MediaQuery.of(context).size.width / 2 - 28,
        child: FloatingActionButton(
          onPressed: () {
            todoDescriptionController.clear();
            todoTitleController.clear();
            showDialog(
              context: context,
              builder: (_) => SimpleDialog(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 20,
                ),
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Row(
                  children: [
                    Text(
                      "Add Todo",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.grey,
                        size: 30,
                      ),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
                children: [
                  Divider(),
                  TextFormField(
                    controller: todoTitleController,
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      color: Colors.white,
                    ),
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "eg. exercise",
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: Sizes.dimens_24),
                  Container(
                    padding: EdgeInsets.only(
                        left: Sizes.dimens_20,
                        right: Sizes.dimens_10,
                        bottom: Sizes.dimens_30),
                    margin: EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(
                      // color: AppColors.descriptionColor,
                      color: AppColors.greyColor,
                      borderRadius: new BorderRadius.circular(18.0),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.width,
                      ),
                      child: TextFormField(
                        controller: todoDescriptionController,
                        maxLines: null,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: Sizes.dimens_22,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: "Description",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: width,
                    height: 50,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("Add"),
                      color: Palette.lightBlue,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (todoTitleController.text.isNotEmpty) {
                          await DatabaseService().createNewTodo(
                            todoTitleController.text.trim(),
                            todoDescriptionController.text.trim(),
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
                  )
                ],
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    ]);
  }
}

final _lightColors = [
  Colors.lightGreen.shade300.withOpacity(0.3),
  Colors.tealAccent.shade100.withOpacity(0.2),
  Color(0xff092E34).withOpacity(0.3),
  Color(0xff489FB5).withOpacity(0.3),
  Color(0xffFFA62B).withOpacity(0.3),
  Color(0xffCC7700).withOpacity(0.3)
];

class ImageCard extends StatelessWidget {
  const ImageCard({this.taskData, this.index});

  final Todo taskData;
  final int index;

  @override
  Widget build(BuildContext context) {
    TextEditingController todoTitleController =
        TextEditingController(text: taskData.title);
    TextEditingController todoDescriptionController =
        TextEditingController(text: taskData.description);
    final color = _lightColors[index % _lightColors.length];

    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text(
                    "Delete",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                  content: new Text("Would you like to delete this note?"),
                  actions: [
                    FlatButton(
                      child: Text('Yes'),
                      onPressed: () async {
                        await DatabaseService().removeTodo(taskData.uid);
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      },
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => SimpleDialog(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 20,
            ),
            backgroundColor: Colors.grey[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Text(
                  "Edit Todo",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.grey,
                    size: 30,
                  ),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            children: [
              Divider(),
              TextFormField(
                controller: todoTitleController,

                // initialValue: taskData.title,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                  color: Colors.white,
                ),
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "eg. exercise",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: Sizes.dimens_24),
              Container(
                padding: EdgeInsets.only(
                    left: Sizes.dimens_20,
                    right: Sizes.dimens_10,
                    bottom: Sizes.dimens_30),
                margin: EdgeInsets.only(top: 0),
                decoration: BoxDecoration(
                  // color: AppColors.descriptionColor,
                  color: AppColors.greyColor,
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.width,
                  ),
                  child: TextFormField(
                    controller: todoDescriptionController,
                    maxLines: null,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: Sizes.dimens_22,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: "Description",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width - 150,
                height: 50,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("Save"),
                  color: Palette.lightBlue,
                  textColor: Colors.white,
                  onPressed: () async {
                    if (todoTitleController.text.isNotEmpty) {
                      await DatabaseService().updateTask(
                        taskData.uid,
                        todoTitleController.text.trim(),
                        todoDescriptionController.text.trim(),
                        taskData.isComplet,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              )
            ],
          ),
        );
      },
      child: Card(
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
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: color, width: 5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      taskData.title,
                      style: TextStyle(fontWeight: FontWeight.w900),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey[400],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  taskData.description,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w300, color: Colors.black45),
                ),
              ],
            ),
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

// Row(
// children: [
// Checkbox(
// materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
// value: taskData.isComplet,
// onChanged: (val) {},
// ),
// // SizedBox(
// //   width: 1,
// // ),
// IconButton(
// icon: Icon(
// Icons.delete,
// color: Colors.black54,
// ),
// onPressed: () async {
// showDialog(
// context: context,
// builder: (_) => new CupertinoAlertDialog(
// title: new Text("Delete"),
// content: new Text("Are you sure?"),
// actions: <Widget>[
// FlatButton(
// child: Text('Yes'),
// onPressed: () {},
// ),
// FlatButton(
// child: Text('No'),
// onPressed: () {
// Navigator.of(context).pop();
// },
// )
// ],
// ));
// },
// ),
// ],
// ),
