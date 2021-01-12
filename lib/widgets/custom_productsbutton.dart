import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


// ignore: camel_case_types
class Custom_ProductButtons extends StatelessWidget {
  final IconData icon ;
  final String productOpName ;
  final Function onClicked ;
  final double size;
  final Color color ;
  final double height ;
  final double width ;


  const Custom_ProductButtons({Key key, this.icon, this.productOpName, this.onClicked, this.size, this.color, this.height, this.width, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(17.0),
        elevation: 5.0,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(17.0),
          ),
          child: GestureDetector(
            onTap: onClicked,
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
              
                   Expanded(child: FittedBox(child: FaIcon(icon ,color: color,),fit: BoxFit.fill
                     ,)),
                Text(productOpName,style: TextStyle(color: color,fontSize: size,),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
