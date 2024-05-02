import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:JAY_BUILDCON/controller/MyProvider.dart';
import 'package:JAY_BUILDCON/config/ApiLinks.dart';
import 'package:JAY_BUILDCON/config/Constant.dart';
import 'package:JAY_BUILDCON/config/StaticMethod.dart';
import 'package:JAY_BUILDCON/services/ThemeService/theme.dart';
import 'package:JAY_BUILDCON/ui/Widgets/Property/ProjectPropertyDetail.dart';
import 'package:shimmer/shimmer.dart';
class ProjectDetailWidget extends StatefulWidget {
  final Map<String,dynamic> projectData;
  const ProjectDetailWidget({super.key, required this.projectData});

  @override
  State<ProjectDetailWidget> createState() => _ProjectDetailWidgetState();
}

class _ProjectDetailWidgetState extends State<ProjectDetailWidget> {
  bool _mounted=false;
  List<dynamic> propertyList = [];
  
  //========================================FILTER VARIABLE
  final List<String> available = ['All', 'Available', 'Not Available','Sold'];
  String selectedAvailability = "All";
  int propertyUn = 0;

  //======================================PAGINATION VARIABLE===================
  int page = 1;
  final int limit = 6;

  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;

  //==========================================first load method
  _firstLoad(appState)async{
    if(_mounted){
      setState(() {
        _isFirstLoadRunning = true;
      });
    }
    Map<String,dynamic> paginationOptions = {
      "page":page,
      "limit":limit
    };
    var url = Uri.parse(ApiLinks.fetchAllPropertiesWithPaginationAndFilter);
    final res = await StaticMethod.fetchAllPropertyWithPaginationAndFilter(appState,paginationOptions,url,
        projectId: widget.projectData['project_id'],
      propertyUn: propertyUn,
      selectedAvailability: selectedAvailability
    );

    if (res.isNotEmpty) {
      if (res['success'] == true) {
        //print('succes is true and result is ${res['result']}');
        propertyList = res['result'];
        if(_mounted){
          setState(() {
            _isFirstLoadRunning = false;
          });
        }
      } else {
        //print(res['error']);
        appState.error = res['error'];
        appState.errorString=res['message'];
        //appState.fromWidget='ProjectDetailWidget';
        //appState.activeWidget = "SpacificErrorPage";
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>SpacificErrorPage(error: res['error'],errorString: res['message'],fromWidget: appState.activeWidget,)));
      }
    }
  }

  //==========================================LOAD MORE METHOD
  void _loadMore(appState) async {

    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300 && _mounted
    ) {
      if(_mounted){
        setState(() {
          _isLoadMoreRunning = true; // Display a progress indicator at the bottom
        });
      }

      page += 1; // Increase _page by 1
      Map<String,dynamic> paginationOptions = {
        "page":page,
        "limit":limit
      };
      var url = Uri.parse(ApiLinks.fetchAllPropertiesWithPaginationAndFilter);
      final res = await StaticMethod.fetchAllPropertyWithPaginationAndFilter(appState,paginationOptions,url,
          projectId: widget.projectData['project_id'],
          propertyUn: propertyUn,
          selectedAvailability: selectedAvailability
      );
      if (res.isNotEmpty) {
        if (res['success'] == true) {
          if(res['result'].length>0){
            //print('succes is true and result is ${res['result']}');
            if(_mounted){
              setState(() {
                 propertyList.addAll(res['result']);
                _isFirstLoadRunning = false;
              });
            }
          }else{
            if(_mounted){
              setState(() {
                _hasNextPage = false;
              });
            }
            StaticMethod.showDialogBar('no more content available', Colors.green);
          }
        } else {
          //print('unable to fetch property show error page');
        }
      }
      if (_mounted) {
        setState(() {
          _isLoadMoreRunning = false;
        });
      }
    }
  }


  late ScrollController _controller;
  @override
  void initState() {
    ///print('initstate methond called');
    _mounted = true;
    final appState = Provider.of<MyProvider>(context, listen: false);
    _mounted=true;
    _firstLoad(appState);
    _mounted = true;
    _controller = ScrollController()..addListener(() => _loadMore(appState));
    //print('initstate called');
    super.initState();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MyProvider>(context);
    double fontSizeScaleFactor =
        MyConst.deviceWidth(context) / MyConst.referenceWidth;
    //print(propertyList);
    return RefreshIndicator(
        child: PopScope(
          child: Scaffold(
            backgroundColor: context.theme.backgroundColor,
            appBar: _appBar('Project Details'),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  //========================PROJECT DETAILS CARD
                  Container(
                    child: Card(
                      color: Get.isDarkMode?Colors.white12: Theme.of(context).primaryColorLight,
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  '${widget.projectData['project_name'].toUpperCase()} - ${widget.projectData['project_un']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                subtitle: Text(
                                  '${widget.projectData['project_locality']}, ${widget.projectData['project_city']}, ${widget.projectData['project_state']}, ${widget.projectData['project_pincode']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: MyConst.smallTextSize*fontSizeScaleFactor
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Container(
                                      height:20,
                                      width:20,
                                      decoration: const BoxDecoration(
                                          color: Colors.green
                                      ),
                                    ),
                                    const Text('Available')
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 15),
                                child:Row(
                                  children: [
                                    Container(
                                      height:20,
                                      width:20,
                                      decoration: const BoxDecoration(
                                          color: Colors.red
                                      ),
                                    ),
                                    const Text('Not Available')
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 15),
                                  child:Row(
                                    children: [
                                      Container(
                                        height:20,
                                        width:20,
                                        decoration: const BoxDecoration(
                                            color: Colors.orange
                                        ),
                                      ),
                                      const Text('Sold')
                                    ],
                                  )
                              )
                            ],
                          )
                      ),
                    ),
                  ),
                  //========================PROPERTY LIST FILTER
                  Container(
                    child: Card(
                      color: Get.isDarkMode?Colors.white12: Theme.of(context).primaryColorLight,
                      //shadowColor: Colors.black,
                      elevation: 1,
                      child: TextField(
                        onChanged: (value) {
                          propertyUn = value.length!=0 ? int.parse(value) : 0;
                          _hasNextPage=true;
                          page=1;
                          //setState(() {
                          _isFirstLoadRunning=false;
                          _firstLoad(appState);
                          //});
                        },
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: MyConst.mediumSmallTextSize *
                                fontSizeScaleFactor),
                        textAlignVertical: TextAlignVertical.center,
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 5),
                          labelText: 'Filter By Unique Id',
                          labelStyle: TextStyle(fontSize: MyConst.smallTextSize*fontSizeScaleFactor),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search,size: MyConst.deviceHeight(context)*0.025,),
                        ),
                        cursorOpacityAnimates: false,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child:  Text(
                          'Availability: ',
                          style: TextStyle(fontSize:MyConst.smallTextSize*fontSizeScaleFactor,fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: MyConst.deviceWidth(context)*0.010,
                      ),

                      Card(
                          color: Get.isDarkMode?Colors.white12:Theme.of(context).primaryColorLight,
                          child: Container(
                            height: 45,
                            width: MyConst.deviceWidth(context)*0.4,
                            child: Center(
                              child: DropdownButton<String>(
                                value: selectedAvailability,
                                alignment: Alignment.center,
                                elevation: 16,
                                underline: Container(),
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedAvailability = value!;
                                    page=1;
                                    _hasNextPage=true;
                                    _isFirstLoadRunning=false;
                                    _firstLoad(appState);
                                  });
                                },
                                items: available
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text('${value}',
                                            softWrap: true,
                                            style: TextStyle(
                                                fontSize: MyConst.smallTextSize*fontSizeScaleFactor,
                                                overflow: TextOverflow
                                                    .ellipsis)),
                                      );
                                    }).toList(),
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  //========================PROJECT PROPERTY LIST
                  _isFirstLoadRunning
                      ? const LinearProgressIndicator()
                      : Container(
                      child: Flexible(
                        child:GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // Set the number of columns in the grid
                            crossAxisSpacing: 10, // Set the spacing between columns
                            mainAxisSpacing: 10, // Set the spacing between rows
                            childAspectRatio: 2, // Set the aspect ratio of each grid item
                          ),
                          itemCount: propertyList.length,
                          itemBuilder: (context, index) {
                            final property = propertyList[index];
                            Color cardColor = Colors.white;
                            if(property['property_isAvailable']=="Available"){
                              cardColor =Colors.green;
                            }else if(property['property_isAvailable']=="Not Available"){
                              cardColor = Colors.red;
                            }else if(property['property_isAvailable']=="Sold"){
                              cardColor = Colors.orange;
                            }
                            return InkWell(
                              onTap: (){
                                //print(property);
                                appState.p_id = property['property_id'];
                                appState.activeWidget='ProjectPropertyDetailPage';
                                Get.to(()=>ProjectPropertyDetail());
                              },
                              child: GridTile(
                                  child: Card(
                                      color: cardColor,
                                      child: Center(
                                        child: Text('${property['property_un']}'),
                                      )
                                  )
                              ),
                            );
                          },
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        ), 
        onRefresh: ()async{
          _isFirstLoadRunning=false;
          page=1;
          _firstLoad(appState);
        }
    );
  }
  _appBar(appBarContent){
    return AppBar(
      leading: IconButton(
        onPressed: (){Get.back();},
        icon: Icon(Icons.arrow_back_ios),
      ),
      iconTheme: IconThemeData(
        color: Get.isDarkMode ?  Colors.white70 :Colors.black,
        size: MyConst.deviceHeight(context)*0.030,
      ),
      toolbarHeight: MyConst.deviceHeight(context)*0.060,
      titleSpacing: MyConst.deviceHeight(context)*0.02,
      elevation: 0.0,
      title:Text(
        appBarContent,
        style: appbartitlestyle,
        softWrap: true,
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/images/ic_launcher.png',
                height: 100,
              )
          ),
        ),
      ],
      backgroundColor: Get.isDarkMode
          ? Colors.black45 : Colors.white,
    );
  }
}
