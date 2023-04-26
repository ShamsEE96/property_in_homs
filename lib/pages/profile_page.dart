import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_in_homs/bloc/cubits/auth_cubit.dart';
import 'package:property_in_homs/bloc/states/auth_states.dart';
import 'package:property_in_homs/utils/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit authCubit = AuthCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: AppColors.seconderyBlueColor,
              title: Text("profile"),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
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
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // SizedBox(
                          //   height: size.height / 15,
                          //   width: double.infinity,
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       authCubit.profil();
                          //       // Navigator.push(
                          //       //     context,
                          //       //     MaterialPageRoute(
                          //       //       builder: (context) => const profilePage(),
                          //       //     ));
                          //     },
                          //     child: const Text('THIS IS YOUR PROFILE'),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 8,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const SizedBox(
                            height: 8,
                          ),

                          Text(
                            authCubit.userEmail,
                            style: TextStyle(
                                color: Color(0xFF0B2447), fontSize: 30),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(authCubit.username,
                              style: const TextStyle(
                                  color: Color(0xFF0B2447), fontSize: 30)),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(authCubit.number,
                              style: TextStyle(
                                  color: Color(0xFF0B2447), fontSize: 30)),

                          IconButton(
                              onPressed: () async {
                                await AuthCubit.get(context).logout();
                              },
                              icon: const Icon(Icons.logout)),
                          const SizedBox(
                            height: 8,
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
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "",
                        style: TextStyle(
                            fontSize: 35,
                            letterSpacing: 1.5,
                            color: Color(0xFF0B2447),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 5),
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 270, left: 184),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ));
      },
    );
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
