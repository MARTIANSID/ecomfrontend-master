import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/options.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:provider/provider.dart';

class OptDiamond extends StatefulWidget {
  final int diamond;
  final bool isCart;
  final Function sett;
  OptDiamond(this.diamond,this.isCart,this.sett);
  @override
  _OptDiamondState createState() => _OptDiamondState();
}

class _OptDiamondState extends State<OptDiamond> {
  int diamond;

  @override
  void initState() {
    diamond = widget.diamond;
    super.initState();
  }

  Future<void> setData(index) async {
    if (index == 0) {
      await Provider.of<Options>(context, listen: false).setDiamond(diamond: 0);
    }
    if (index == 1) {
      await Provider.of<Options>(context, listen: false).setDiamond(diamond: 1);
    }
    if (index == 2) {
      await Provider.of<Options>(context, listen: false).setDiamond(diamond: 2);
    }
     if (index == 3) {
      await Provider.of<Options>(context, listen: false).setDiamond(diamond: 3);
    }
     if (index == 4) {
      await Provider.of<Options>(context, listen: false).setDiamond(diamond: 4);
    }
    await Provider.of<Options>(context, listen: false).getStringValuesSF();
  }

  Map<int, Widget> diamondItems = {
    0: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Text('vVS_EF'),
    ),
    1: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Text('vVS_FG'),
    ),
    2: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Text('vVS_VS_FG'),
    ),
    3: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Text('vS_FG'),
    ),
    4: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Text('sI_HI'),
    ),
  };
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Container(
        //   decoration: BoxDecoration(
        //     color: Colors.grey,
        //     borderRadius: BorderRadius.circular(10.0),
        //   ),
        //   height: size.height * 0.012,
        //   width: size.width * 0.2,
        //   margin: EdgeInsets.only(bottom: 30.0),
        // ),
        // Text(
        //   'Select Filter Options',
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontFamily: 'Gilroy Black',
        //     fontSize: 25.0,
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: MaterialSegmentedControl(
            children: diamondItems,
            selectionIndex: diamond,
            borderColor: Colors.black,
            selectedColor: kPrimaryColor,
            unselectedColor: Colors.white,
            borderRadius: 20.0,
            onSegmentChosen: (index) async {
              if(!widget.isCart)
              {
                  await setData(index);

              }
            else{
              widget.sett(index);
            }

              setState(() {
                diamond = index;
              });
            },
          ),
        ),
      ],
    );
  }
}
