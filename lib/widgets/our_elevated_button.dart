import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OurElevatedButton extends StatelessWidget {
  final String title;
  final Function function;
  const OurElevatedButton(
      {Key? key, required this.title, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          ScreenUtil().setSp(30),
        ),
        child: SizedBox(
          height: ScreenUtil().setSp(45),
          // width: double.infinity,
          width: MediaQuery.of(context).size.width * 0.4,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color(0xFF0454FF),
              ),
            ),
            onPressed: () {
              function();
            },
            child: Text(
              title,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(
                  20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
