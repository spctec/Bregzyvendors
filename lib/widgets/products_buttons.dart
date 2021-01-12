import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';
class ProductButton extends StatelessWidget {
  final IconData icon ;
  final String productsOp ;
  final Color color;
  final Function function ;

  const ProductButton({Key key, this.icon, this.productsOp, this.color, this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 50,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.85,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            // border: Border.all(color: KPurpleColor , width: 1.2),
            color: color
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Text(productsOp, style: TextStyle(
                fontFamily: "Cairo",
                color: Colors.white),),


            SizedBox(
              width: 15,
            ),
            FaIcon(icon, color: Colors.white,),
            SizedBox(
              width: 10,
            ),

          ],
        ),
      ),
    );
  }
}