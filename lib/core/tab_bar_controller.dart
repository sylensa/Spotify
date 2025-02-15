import 'package:flutter/material.dart';
import 'package:spotify/core/helper/helper.dart';
import 'package:spotify/core/utils/colors_utils.dart';

class SellItOptionsLab extends StatefulWidget {
  final List<String> options;
  final int index;
  final ValueChanged<int> onChange;
  final List<Widget> children;
  final double leftPadding;
  final double topPadding;
  final double rightPadding;
  const SellItOptionsLab(
      {Key? key,
        required this.options,
        required this.index,
        required this.onChange,
        this.leftPadding = 0,
        this.rightPadding = 0,
        this.topPadding = 10,
        required this.children})
      : super(key: key);

  @override
  State<SellItOptionsLab> createState() => _SellItOptionsLabState();
}

class _SellItOptionsLabState extends State<SellItOptionsLab> {
  int childPosition = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            widget.options.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      childPosition = index;
                      widget.onChange(index);
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                        margin:  EdgeInsets.only(top: widget.topPadding,bottom: 10,left: widget.leftPadding ,right: widget.rightPadding),

                        decoration: BoxDecoration(
                            color: widget.index == index ?Colors.green : Colors.black,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: widget.index == index ? Colors.transparent : Colors.grey),
                        ),
                        child: appText(
                          widget.options[index],
                          color: widget.index == index ? Colors.white : Colors.white,
                          size: 12,
                          weight: FontWeight.bold,
                          align: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 10,)
                    ],
                  ),
                ),
          ),
        ),
        widget.children[childPosition]
      ],
    );
  }
}







