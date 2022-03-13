import 'package:flutter/material.dart';

class FluidContainer extends StatefulWidget {
   FluidContainer({
    Key key,
    @required this.headerIcon,
    @required this.headerTitle,
    this.content
  });
  ///The icon on the left side of the container header
  final String headerTitle;
  ///The display text on the left side of the container header. 
  final IconData headerIcon;
  ///A widget for the body of the container.
  final Widget content;

  @override
  _FluidContainerState createState() => _FluidContainerState();
}

class _FluidContainerState extends State<FluidContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ///header
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5)
              ),
              color: Color(0xfff5f5f5),
              border: Border(
                left: BorderSide(
                  color: Color(0xffdddddd),
                ),
                bottom: BorderSide(
                  color: Color(0xffdddddd),
                ),
                top:  BorderSide(
                  color: Color(0xffdddddd),
                ),
                right:  BorderSide(
                  color: Color(0xffdddddd),
                ),
              ),
            ),
            height: 40,
            width: MediaQuery.of(context).size.width >= 1000 ? 900 : MediaQuery.of(context).size.width-(MediaQuery.of(context).size.width*0.1),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Icon(widget.headerIcon, size: 20,),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Text(widget.headerTitle),
                ),
              ],
            ),
          ),
          ///body
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)
              ),
               border: Border(
                left: BorderSide(
                  color: Color(0xffdddddd),
                ),
                bottom: BorderSide(
                  color: Color(0xffdddddd),
                ),
                top:  BorderSide(
                  color: Color(0xffdddddd),
                ),
                right:  BorderSide(
                  color: Color(0xffdddddd),
                ),
              ),
            ),
            width: MediaQuery.of(context).size.width >= 1000 ? 900 : MediaQuery.of(context).size.width-(MediaQuery.of(context).size.width*0.1),
            child: widget.content
          ),
        ],
      ),
    );
  }
}