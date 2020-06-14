import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
class FilterChipWidget extends StatefulWidget {
  final String chipName;
  final String option;
  FilterChipWidget({Key key, this.chipName,this.option}) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}



class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected=false;

//   void didChangeDependencies(){
//     bool getValue(select){
//      if (select == 'build') {
//        _isSelected=  Provider.of<Options>(context,listen:true).b;
      
     
//     }
//     if(select=='certificate'){
      
      
//        _isSelected= Provider.of<Options>(context,listen:true).c;

   

//     }
//       if(select=='color'){
     
//  _isSelected= Provider.of<Options>(context,listen:true).co;


//     }
//       if(select=='diamond'){
     
//      _isSelected=    Provider.of<Options>(context,listen:true).d;

//       }


//     super.didChangeDependencies();
//   }
   
//   }
  

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    
    return ChoiceChip(

      label: Row(
        children: <Widget>[
          _isSelected
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : SizedBox(
                  width: 0.0,
                ),
          _isSelected
              ? SizedBox(
                  width: 10.0,
                )
              : SizedBox(
                  width: 0.0,
                ),
         Container(
           width: 80,
           height: 20,
           child: Center(child:Text(
            widget.chipName,
            style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: ScreenUtil().setSp(15,allowFontScalingSelf: true),
                color: !_isSelected ? kPrimaryColor : Colors.white),
          ),
          
         ),
     
         )],
      ),
      labelStyle: TextStyle(
        color: kPrimaryColor,
        fontSize: ScreenUtil().setSp(15,allowFontScalingSelf: true),
      ),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(
            color: kPrimaryColor,
            width: 1.0,
          )),
      backgroundColor: Colors.white,
  
      
      onSelected: (isSelected) {
        if(isSelected)
        {
  
          if(widget.option=='color'){
          Provider.of<Options>(context,listen:false).setColor(color:widget.chipName);

          }
            if(widget.option=='certificate'){
          Provider.of<Options>(context,listen:false).setCert(cert:widget.chipName);

          }if(widget.option=='build'){
          Provider.of<Options>(context,listen:false).setBuild(build:widget.chipName);

          }
          if(widget.option=='diamond'){
          Provider.of<Options>(context,listen:false).setDiamond(diamond:widget.chipName);

          }
        }
       
          
               setState(() {

          _isSelected = isSelected;
          // if (_isSelected) {
          //   tasktype.add(widget.chipName);
          // } else {
          //   tasktype.remove(widget.chipName);
          // }
        });
      },
      // checkmarkColor: kPrimaryLightColor,
      selectedColor: kPrimaryColor,
    );
  }
}
