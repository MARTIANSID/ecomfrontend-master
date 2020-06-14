import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/search.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading = false;
  int count = 0;
  var valuee;

  void getSearchResult(value) async {
    setState(() {
      isLoading = true;
    });
    if(value==''|| value==null){
      Provider.of<Searchh>(context,listen: false).setZero();
      setState(() {
        count=0;
      });    }

else{
    await Provider.of<Searchh>(context, listen: false)
        .getSearch(context: context, query: value);
    setState(() {
      count = 1;
      isLoading = false;
      valuee = value;
    });
}
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final search = Provider.of<Searchh>(context, listen: true).searchResult;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 30, left: 10, right: 10),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.cyan,
                  ),
                  focusColor: Colors.blue,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Search for products",
                ),
                onChanged: (value) async {
                  getSearchResult(value.toUpperCase());
                },
              )),
          count == 0
              ?Expanded(
                  child: Text(
                    'Search for products',
                    style: TextStyle(
                        fontFamily: 'Gilory Black',
                        color: Colors.grey[400],
                        fontSize:
                            ScreenUtil().setSp(35, allowFontScalingSelf: true),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                )
              : isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : search.length == 0
                      ? Expanded(
                          child: Text(
                            'Product Not Found!',
                            style: TextStyle(
                                fontFamily: 'Gilory Black',
                                color: Colors.grey[400],
                                fontSize: ScreenUtil()
                                    .setSp(35, allowFontScalingSelf: true),
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount:
                                  search.length == null ? 0 : search.length,
                              itemBuilder: (context, i) {
                                if (search.length > 0)
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              height: 90.0,
                                              width: 90.0,
                                              child: Image(
                                                  fit: BoxFit.contain,
                                                  // color: Colors.amber,
                                                  image: NetworkImage(
                                                    search[i].image,
                                                  )),
                                            ),
                                            Text(
                                              search[i].styleNumber,
                                              style: TextStyle(
                                                fontFamily: 'Varela',
                                                fontSize: 21.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                      ],
                                    ),
                                  );
                              }))
        ],
      ),
    );
  }
}

// import 'package:Flutter/providers/search.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// // import '../providers/search.dart';

// class Search extends StatefulWidget {
//   @override
//   _SearchState createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   bool isLoading = false;
//   int count = 0;
//   var valuee;

//   Future<void> getSearchResult(value) async {
//     setState(() {
//       isLoading = true;
//     });

//     await Provider.of<Searchh>(context, listen: false)
//         .getSearch(context: context, query: value);
//     setState(() {
//       count = 1;
//       isLoading = false;
//       valuee = value;
//     });
//   }

//   final TextEditingController textEditingController = TextEditingController();
//   String searchValue = "";
//   List suggestion = [];

//   @override
//   Widget build(BuildContext context) {
//     List<String> info = [];

//     // final info = styleNumber.where((element) => element.split(searchValue));
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Positioned(
//             top: 30,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: MediaQuery.of(context).size.height - 30.0,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   TextField(
//                     controller: textEditingController,
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.search),
//                       suffixIcon: IconButton(
//                         icon: Icon(Icons.clear),
//                         onPressed: () {
//                           textEditingController.clear();
//                         },
//                       ),
//                       labelText: 'Search Product',
//                     ),
//                     onChanged: (value) async {
//                       await getSearchResult(value);

//                       // getSearchResult(value.toUpperCase());
//                     },
//                   ),
//                   valuee == null
//                       ? Center(
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 315.0),
//                             child: Text(
//                               "Let's search some Nose Pins",
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontFamily: 'Gilroy',
//                                 fontSize: 23.0,
//                               ),
//                             ),
//                           ),
//                         )
//                       : Provider.of<Searchh>(context, listen: true)
//                                   .searchResult
//                                   .length ==
//                               0
//                           ? Center(child: Text('Product not found'))
//                           : Container(
//                               height: MediaQuery.of(context).size.height - 100,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: const EdgeInsets.fromLTRB(
//                                         40.0, 20.0, 0.0, 20.0),
//                                     child: Text(
//                                       'Nose Pins',
//                                       style: TextStyle(
//                                           fontFamily: 'Gilroy',
//                                           color: Colors.black,
//                                           fontSize: 20.0),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: ListView.separated(
//                                       separatorBuilder: (context, index) {
//                                         return Divider(
//                                           color: Colors.black,
//                                           indent: 50.0,
//                                           endIndent: 50.0,
//                                         );
//                                       },
//                                       shrinkWrap: true,
//                                       scrollDirection: Axis.vertical,
//                                       // physics: BouncingScrollPhysics(),
//                                       itemCount: Provider.of<Searchh>(context,
//                                               listen:true)
//                                           .searchResult
//                                           .length,
//                                       itemBuilder: (context, index) {
//                                         // info = styleNumber[index].split(searchValue);
//                                         print(info);
//                                         return Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 20.0, right: 20.0),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: <Widget>[
//                                               // Container(
//                                               //   height: 90.0,
//                                               //   width: 90.0,
//                                               //   child: Image(
//                                               //   fit: BoxFit.contain,
//                                               //   // color: Colors.amber,
//                                               //   image: NetworkImage(
//                                               //    suggestion[index].image,

//                                               //   )),
//                                               // ),
//                                               // Text(
//                                               //   styleNumber[index],
//                                               //   style: TextStyle(
//                                               //     fontFamily: 'Varela',
//                                               //     fontSize: 21.0,
//                                               //   ),
//                                               // )
//                                               RichText(
//                                                 text: TextSpan(
//                                                   // text: suggestion[index].substring(
//                                                   //   suggestion[index].indexOf(
//                                                   //       searchValue),
//                                                   //   searchValue.length,
//                                                   // ),
//                                                   style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontFamily: 'Varela',
//                                                     fontSize: 21.0,
//                                                   ),
//                                                   children: [
//                                                     TextSpan(
//                                                       text: Provider.of<
//                                                                   Searchh>(
//                                                               context,
//                                                               listen: false)
//                                                           .searchResult[index]
//                                                           .styleNumber,
//                                                       style: TextStyle(
//                                                         color: Colors.grey,
//                                                         // fontWeight: FontWeight.bold,
//                                                         fontFamily: 'Varela',
//                                                         fontSize: 21.0,
//                                                       ),
//                                                     ),
//                                                     TextSpan(
//                                                       text: searchValue,
//                                                       style: TextStyle(
//                                                         color: Colors.black,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontFamily: 'Varela',
//                                                         fontSize: 21.0,
//                                                       ),
//                                                     ),
//                                                     TextSpan(
//                                                       text: info[1],
//                                                       style: TextStyle(
//                                                         color: Colors.grey,
//                                                         // fontWeight: FontWeight.bold,
//                                                         fontFamily: 'Varela',
//                                                         fontSize: 21.0,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
