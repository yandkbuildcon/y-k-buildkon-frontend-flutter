import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_state/Provider/MyProvider.dart';
import 'package:real_state/Widgets/Other/RatingDisplayWidgetTwo.dart';
import 'package:real_state/config/ApiLinks.dart';
class VisitRequestedListPage extends StatefulWidget {
  const VisitRequestedListPage({Key? key}) : super(key: key);

  @override
  State<VisitRequestedListPage> createState() => _VisitRequestedListPageState();
}

class _VisitRequestedListPageState extends State<VisitRequestedListPage> {
  String requestStatus = "";
  Color statusColor = Colors.orange;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MyProvider>(context);
    //print(appState.visitRequestedPropertyList);
    return Column(
      children: [
        //=====================================PROPERTY LIST CONTAINER
         Expanded(
                child: ListView.builder(
                  itemCount: appState.visitRequestedPropertyList.length,
                  itemBuilder: (context, index) {
                    final property = appState.visitRequestedPropertyList[index];
                    if(property['v_status']==0){
                      requestStatus = "Pending";
                      statusColor = Colors.orange;
                    }else if(property['v_status']==1){
                      requestStatus="Accepted";
                      statusColor=Colors.green;
                    }else{
                      requestStatus="Completed";
                      statusColor=Colors.red;
                    }
                    return InkWell(
                      onTap: () {
                        appState.selectedProperty = property;
                        appState.activeWidget = "VisitRequestedDetailPage";
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
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
                                  margin: const EdgeInsets.all(8),
                                  child: Center(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: property['pi_name'].length > 0
                                            ? CachedNetworkImage(
                                          imageUrl: '${ApiLinks.accessPropertyImages}/${property['pi_name'][0]}?timestamp=${DateTime.now().millisecondsSinceEpoch}',
                                          placeholder: (context, url) =>const LinearProgressIndicator(),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.fill,
                                        )
                                            : ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset(
                                            'assets/images/home.jpg',
                                            width: 100,
                                          ),
                                        )
                                    ),
                                  ),
                                ),

                                //==============================PROPERTY DETAIL CONTAINER
                                Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //=======================NAME CONTAINER
                                          Text(
                                              '${property['p_name'].toUpperCase()}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              softWrap: true,
                                            ),


                                          //=======================AREA TEXT
                                          Text(
                                            '${property['p_area']} ${property['p_areaUnit']}',
                                            style: const TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w500),
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
                                                style: const TextStyle(fontSize: 14,color: Colors.grey, fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),

                                          //=======================LOCATION ROW SECTION
                                          Row(
                                            children: [
                                              Icon(Icons.location_pin,color: Theme.of(context).hintColor,size: 20,),
                                              Expanded(child:Text(
                                                '${property['p_locality']}, ${property['p_city']}',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              )
                                              )
                                            ],
                                          ),

                                          //=======================RATING ROW SECTION
                                          Row(
                                            children: [
                                              RatingDisplayWidgetTwo(rating: property['p_rating'].toDouble(),),
                                              Text(
                                                  '(${property['p_ratingCount']})'
                                              )
                                            ],
                                          ),

                                          //========================REQUEST STATUS
                                           Text(
                                                requestStatus,
                                              style: TextStyle(
                                                color: statusColor
                                              ),
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
                ))
      ],
    );
  }
}
