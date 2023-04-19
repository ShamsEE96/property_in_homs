import 'package:flutter/material.dart';

class profilePage extends StatelessWidget {
  const profilePage({super.key});

  @override
  Widget build(BuildContext context) {
    //   Widget textfild({required String hintText}) {
    //     return Material(
    //       elevation: 4,
    //       shadowColor: Colors.grey,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: TextField(
    //         decoration: InputDecoration(
    //             hintText: hintText,
    //             hintStyle: TextStyle(
    //                 letterSpacing: 2,
    //                 color: Colors.black45,
    //                 fontWeight: FontWeight.bold),
    //             fillColor: Colors.white,
    //             filled: true,
    //             border: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(10.0),
    //                 borderSide: BorderSide.none)),
    //       ),
    //     );
    //   }

    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromARGB(255, 108, 131, 207),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 450,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'User Name',
                      ),
                      Text(
                        'Email',
                      ),
                      Text(
                        'Number',
                      ),
                      // Container(
                      //   height: 55,
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //       style: ElevatedButton.styleFrom(
                      //           backgroundColor: Colors.black45),
                      //       onPressed: () {},
                      //       child: Text(
                      //         "update",
                      //         style:
                      //             TextStyle(fontSize: 23, color: Colors.white),
                      //       )),
                      // )
                    ],
                  ),
                )
              ],
            ),
            CustomPaint(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "profile",
                    style: TextStyle(
                        fontSize: 35,
                        letterSpacing: 1.5,
                        color: Color(0xFF3842C9),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 5),
                    shape: BoxShape.circle,
                    color: Color(0xFF3842C9),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 270, left: 184),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ));
  }
}

// class _ClipShadowShadowPainter extends CustomPainter {
//   final Shadow shadow;
//   final CustomClipper<Path> clipper;

//   _ClipShadowShadowPainter({required this.shadow, required this.clipper});

//   @override
//   void paint(Canvas canvas, dynamic size) {
//     var paint = shadow.toPaint();
//     var clipPath = clipper.getClip(size).shift(shadow.offset);
//     canvas.drawPath(clipPath, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
