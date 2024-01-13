import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_state/Provider/MyProvider.dart';
import 'package:real_state/Widgets/Other/RatingDisplayWidgetTwo.dart';
import 'package:real_state/config/ApiLinks.dart';
class FavoritePropertyListPage extends StatefulWidget {
  const FavoritePropertyListPage({Key? key}) : super(key: key);

  @override
  State<FavoritePropertyListPage> createState() => _FavoritePropertyListPageState();
}

class _FavoritePropertyListPageState extends State<FavoritePropertyListPage> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MyProvider>(context);
    return Column(
      children: [
        //=====================================PROPERTY LIST CONTAINER
        Container(
            child: Expanded(
                child: ListView.builder(
                  itemCount: appState.favoritePropertyList.length,
                  itemBuilder: (context, index) {
                    final property = appState.favoritePropertyList[index];
                    return InkWell(
                      onTap: () {
                        appState.selectedProperty = property;
                        appState.activeWidget = "FavoritePropertyDetailPage";
                      },
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                          child: Card(
                            shadowColor: Colors.black,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //==============================PROPERTY IMAGE CONTAINER
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child:Center(
                                    child: ClipRRect(

                                      borderRadius: BorderRadius.circular(10),
                                      child: property['pi_name'].length>0 ? Image.network(
                                        '${ApiLinks.accessPropertyImages}/${property['pi_name'][0]}?timestamp=${DateTime.now().millisecondsSinceEpoch}',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.fill,
                                      )
                                          : Image.asset('assets/images/home.jpg',height: 100,width: 100,),
                                    ),
                                  ),
                                ),

                                //==============================PROPERTY DETAIL CONTAINER
                                Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //=======================NAME CONTAINER
                                          Container(
                                            child: Text(
                                              '${property['p_name'].toUpperCase()}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),

                                          //=======================AREA TEXT
                                          Text(
                                            '${property['p_area']} sq feet',
                                            style: TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w500),
                                          ),

                                          //=======================PRICE ROW SECTION
                                          Row(
                                            children: [
                                              Text(
                                                '₹',
                                                style: TextStyle(fontSize: 14,color: Theme.of(context).hintColor,fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                '${property['p_price']}',
                                                style: TextStyle(fontSize: 14,color: Colors.grey, fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),

                                          //=======================LOCATION ROW SECTION
                                          Row(
                                            children: [
                                              Icon(Icons.location_pin,color: Theme.of(context).hintColor,size: 20,),
                                              Expanded(child: Container(child:Text(
                                                '${property['p_locality']}, ${property['p_city']}',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              )),)
                                            ],
                                          ),

                                          //=======================RATING ROW SECTION
                                          Row(
                                            children: [
                                              RatingDisplayWidgetTwo(rating: property['p_rating'].toDouble(),),
                                              Text(
                                                  '(${property['p_rating_count']})'
                                              )
                                            ],
                                          ),
                                          //property['pi_name'].length>0 ? Text('${property['pi_name'][0]}') : Container()
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          )),
                    );
                  },
                )))
      ],
    );
  }
}