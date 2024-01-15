import 'package:flutter/material.dart';
import 'package:real_state/config/StaticMethod.dart';
class AddNewPropertyWidget extends StatefulWidget {
  const AddNewPropertyWidget({Key? key}) : super(key: key);

  @override
  State<AddNewPropertyWidget> createState() => _AddNewPropertyWidgetState();
}

class _AddNewPropertyWidgetState extends State<AddNewPropertyWidget> {
  final _formKey = GlobalKey<FormState>();
  final List<String> propertyType = ['House', 'Flat', 'Plot'];
  String selectedPropertyType = "House";

  final List<String> bhk = ['0','1','2','3','4','5'];
  int selectedBhk = 0;

  final List<String> floor = ['0','1','2','3','4','5'];
  int selectedFloor = 0;

  final List<String> garden = ['Yes', 'No'];
  String selectedGarden = 'No';


  final List<String> parking = ['Yes', 'No'];
  String selectedParking='No';


  final List<String> furnished = ['Yes', 'No'];
  String selectedFurnished = "No";

  final List<String> available = ['Yes', 'No'];
  String selectedAvailability = "Yes";

  //===================================ALL THE FORM CONTROLLERS
  final _propertyNameController = TextEditingController();
  final _propertyUnController = TextEditingController();
  final _propertyAreaController = TextEditingController();
  final _propertyPriceController = TextEditingController();
  final _propertyBookingAmountController = TextEditingController();
  final _propertyDescriptionController = TextEditingController();
  final _propertyAddressController = TextEditingController();
  final _propertyLocalityController = TextEditingController();
  final _propertyCityController = TextEditingController();
  final _propertyPincodeController = TextEditingController();
  final _propertyLocationUrlController = TextEditingController();

  final FocusNode _propertyNameFocusNode = FocusNode();
  final FocusNode _propertyUnFocusNode = FocusNode();
  final FocusNode _propertyAreaFocusNode = FocusNode();
  final FocusNode _propertyPriceFocusNode = FocusNode();
  final FocusNode _propertyBookingAmountFocusNode = FocusNode();
  final FocusNode _propertyDescriptionFocusNode = FocusNode();
  final FocusNode _propertyAddressFocusNode = FocusNode();
  final FocusNode _propertyLocalityFocusNode = FocusNode();
  final FocusNode _propertyCityFocusNode = FocusNode();
  final FocusNode _propertyPincodeFocusNode = FocusNode();
  final FocusNode _propertyLocationUrlFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: 250),
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 150,
              color: Theme.of(context).hintColor,
            ),
            Container(
              width: double.infinity,
              child: Center(
                  child:Text(
                    'Welcome To Y&K Buildkon',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  )
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //==============================SIGNUP HEADING
            Container(
              width: double.infinity,
              child:const Center(
                  child:Text(
                    'New Property Listing',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25
                    ),
                  )
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            //==============================FORM CONTAINER
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //=============================PROPERTY NAME TEXTFIELD
                      Container(
                        child:TextFormField(
                            focusNode: _propertyNameFocusNode,
                            controller: _propertyNameController,
                            decoration:  InputDecoration(
                                labelText: 'Property Name',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    // color: Theme.of(context).hintColor
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10),),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10),),
                                )
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter valid property name';
                              }
                              return null;
                            }
                        ),
                      ),
                      const SizedBox(height: 15,),

                      //========================PROPETY UNIQUE NUMBER TEXTFIELD
                      Container(
                        child:TextFormField(
                            focusNode: _propertyUnFocusNode,
                            controller: _propertyUnController,
                            keyboardType: TextInputType.text,
                            decoration:  InputDecoration(
                                labelText: 'Property Unique Number',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    // color: Theme.of(context).hintColor
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10),),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10),),
                                )
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter valid unique number';
                              }
                              return null;
                            }
                        ),
                      ),
                      const SizedBox(height: 15,),

                      //============================PROPERTY AREA
                      Container(
                        child:TextFormField(
                          focusNode: _propertyAreaFocusNode,
                          controller: _propertyAreaController,
                          keyboardType: TextInputType.number,
                          decoration:  InputDecoration(
                              labelText: 'Property Area',
                              labelStyle: TextStyle(color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  // color: Theme.of(context).hintColor
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10),),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10),),
                              )
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return "please enter valid area";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15,),

                      //============================PROPERTY PRICE
                      Container(
                        child:TextFormField(
                          focusNode: _propertyPriceFocusNode,
                          controller: _propertyPriceController,
                          keyboardType: TextInputType.number,
                          decoration:  InputDecoration(
                              labelText: 'Property Price',
                              labelStyle: TextStyle(color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  // color: Theme.of(context).hintColor
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10),),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10),),
                              )
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return "please enter valid price";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15,),

                      //============================PROPERTY BOOKING AMMOUNT
                      Container(
                        child:TextFormField(
                          focusNode: _propertyBookingAmountFocusNode,
                          controller: _propertyBookingAmountController,
                          keyboardType: TextInputType.number,
                          decoration:  InputDecoration(
                              labelText: 'Property Booking Ammount',
                              labelStyle: TextStyle(color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  // color: Theme.of(context).hintColor
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10),),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10),),
                              )
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return "please enter valid booking ammount";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15,),


                      //===========================SPACIFICATION CONTAINER
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            //==========================PROPERTY TYPE
                            Row(
                              children: [
                                Text('Select Property Type: '),
                                SizedBox(width: 10,),
                                Card(
                                    elevation: 1,
                                    child:Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                      child: DropdownButton<String>(
                                        value: selectedPropertyType,
                                        icon: const Icon(Icons.arrow_drop_down_sharp, size: 30,),
                                        elevation: 16,
                                        underline: Container(),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            selectedPropertyType = value!;
                                            print('selected property type is ${selectedPropertyType}');
                                          });
                                        },
                                        items: propertyType.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  )

                              ],
                            ),

                            //==========================PROPERTY BHK
                            selectedPropertyType=='House' || selectedPropertyType=="Flat"
                                ? Row(
                              children: [
                                Text('Select Property BHK: '),
                                SizedBox(width: 10,),
                                Card(
                                    elevation: 1,
                                    child:Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                      child: DropdownButton<String>(
                                        value: selectedBhk.toString(),
                                        icon: const Icon(Icons.arrow_drop_down_sharp, size: 30,),
                                        elevation: 16,
                                        underline: Container(),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            selectedBhk = int.parse(value!);
                                            print('selected bhk is : ${selectedBhk}');
                                          });
                                        },
                                        items: bhk.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                )

                              ],
                            )
                                : Container(),

                            //==========================PROPERTY FLOOR
                            selectedPropertyType=='House'
                                ? Row(
                              children: [
                                Text('Select No. Of Floors: '),
                                SizedBox(width: 10,),
                                Card(
                                    elevation: 1,
                                    child:Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                      child: DropdownButton<String>(
                                        value: selectedFloor.toString(),
                                        icon: const Icon(Icons.arrow_drop_down_sharp, size: 30,),
                                        elevation: 16,
                                        underline: Container(),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            selectedFloor = int.parse(value!);
                                            print('selected floor is : ${selectedFloor}');
                                          });
                                        },
                                        items: floor.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                )

                              ],
                            )
                                : Container(),

                            //==========================isGarden facility
                            selectedPropertyType=='House'
                                ? Row(
                              children: [
                                Text('Garden Availibility?: '),
                                SizedBox(width: 10,),
                                Card(
                                    elevation: 1,
                                    child:Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                      child: DropdownButton<String>(
                                        value: selectedGarden,
                                        icon: const Icon(Icons.arrow_drop_down_sharp, size: 30,),
                                        elevation: 16,
                                        underline: Container(),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            selectedGarden = value!;
                                            print('is Garden : ${selectedGarden}');
                                          });
                                        },
                                        items: garden.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                )

                              ],
                            )
                                : Container(),

                            //==========================isParking facility
                            selectedPropertyType=='House'
                                ? Row(
                              children: [
                                Text('Parking Facility?: '),
                                SizedBox(width: 10,),
                                Card(
                                    elevation: 1,
                                    child:Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                      child: DropdownButton<String>(
                                        value: selectedParking,
                                        icon: const Icon(Icons.arrow_drop_down_sharp, size: 30,),
                                        elevation: 16,
                                        underline: Container(),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            selectedParking = value!;
                                            print('is Parking : ${selectedParking}');
                                          });
                                        },
                                        items: parking.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                )

                              ],
                            )
                                : Container(),

                            //==========================isFurnished facility
                            selectedPropertyType=='House' || selectedPropertyType=='Flat'
                                ? Row(
                              children: [
                                Text('Furnished Or Not?: '),
                                SizedBox(width: 10,),
                                Card(
                                    elevation: 1,
                                    child:Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                      child: DropdownButton<String>(
                                        value: selectedFurnished,
                                        icon: const Icon(Icons.arrow_drop_down_sharp, size: 30,),
                                        elevation: 16,
                                        underline: Container(),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            selectedFurnished = value!;
                                            print('is furnished : ${selectedFurnished}');
                                          });
                                        },
                                        items: furnished.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                )

                              ],
                            )
                                : Container(),

                            //==========================AVAILABILITY
                            Row(
                              children: [
                                Text('Available Or Not?: '),
                                SizedBox(width: 10,),
                                Card(
                                    elevation: 1,
                                    child:Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                      child: DropdownButton<String>(
                                        value: selectedAvailability,
                                        icon: const Icon(Icons.arrow_drop_down_sharp, size: 30,),
                                        elevation: 16,
                                        underline: Container(),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            selectedAvailability = value!;
                                            print('is available : ${selectedFurnished}');
                                          });
                                        },
                                        items: available.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                )

                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 15,),


                      //============================DESCRIPTION TEXTFIELD
                      Container(
                        child:TextFormField(
                          focusNode: _propertyDescriptionFocusNode,
                          controller: _propertyDescriptionController,
                          maxLines: 5,
                            decoration:  InputDecoration(
                                labelText: 'Property Description',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    // color: Theme.of(context).hintColor
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10),),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10),),
                                )
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter valid description';
                              }
                              return null;
                            }
                        ),
                      ),
                      const SizedBox(height: 15,),


                      //============================ADDRESS TEXTFIELD
                      Container(
                        child:TextFormField(
                            focusNode: _propertyAddressFocusNode,
                            controller: _propertyAddressController,
                            decoration:  InputDecoration(
                                labelText: 'Address',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    // color: Theme.of(context).hintColor
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10),),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10),),
                                )
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter valid address';
                              }
                              return null;
                            }
                        ),
                      ),
                      const SizedBox(height: 15,),

                      //===============================LOCALITY AND CITY
                      Row(
                        children: [
                          Expanded(child:Container(
                            child:TextFormField(
                                focusNode: _propertyLocalityFocusNode,
                                controller: _propertyLocalityController,
                                decoration:  InputDecoration(
                                    labelText: 'Locality',
                                    labelStyle: TextStyle(color: Colors.black),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        // color: Theme.of(context).hintColor
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10),),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10),),
                                    )
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter valid locality';
                                  }
                                  return null;
                                }
                            ),
                          ),),
                          SizedBox(width: 10,),
                          Expanded(child:Container(
                            child:TextFormField(
                                focusNode: _propertyCityFocusNode,
                                controller: _propertyCityController,
                                decoration:  InputDecoration(
                                    labelText: 'City',
                                    labelStyle: TextStyle(color: Colors.black),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        // color: Theme.of(context).hintColor
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10),),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10),),
                                    )
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter valid city name';
                                  }
                                  return null;
                                }
                            ),
                          ),),
                        ],
                      ),
                      const SizedBox(height: 15,),

                      //===========================PINCODE TEXTFIELD
                      Container(
                        child:TextFormField(
                            focusNode: _propertyPincodeFocusNode,
                            controller: _propertyPincodeController,
                            keyboardType: TextInputType.number,
                            decoration:  InputDecoration(
                                labelText: 'Pincode',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    // color: Theme.of(context).hintColor
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10),),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10),),
                                )
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length!=6) {
                                return 'please enter valid pincode';
                              }
                              return null;
                            }
                        ),
                      ),
                      const SizedBox(height: 15,),

                      //=============================url note
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Note:',
                              style: TextStyle(
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(width: 5,),
                            Expanded(
                              child: Text(
                                'please click on open map button and point you address, copy the address link and paste below',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: Colors.orange,
                                ),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: TextButton(
                            onPressed: (){
                              var url = 'https://maps.app.goo.gl/cC71ok8WYcdzXuGF7';
                              StaticMethod.openMap(url);
                            },
                            child: Text('Open Map')
                        ),
                      ),

                      //============================LOCATION MAP URL TEXTFIELD
                      Container(
                        child:TextFormField(
                          focusNode: _propertyLocationUrlFocusNode,
                          controller: _propertyLocationUrlController,
                            decoration:  InputDecoration(
                                labelText: 'Google Map Address Url',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    // color: Theme.of(context).hintColor
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10),),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10),),
                                )
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter valid address';
                              }
                              return null;
                            }
                        ),
                      ),
                      const SizedBox(height: 15,),

                      //===============================SIGNUP BTN
                      ElevatedButton(
                          onPressed: (){
                            if (_formKey.currentState!.validate()) {
                              //_submitData(appState, context);
                            }
                          },
                          child: Text('Add Properties',style: TextStyle(color: Theme.of(context).hintColor),)
                      ),
                      const SizedBox(height: 15,),


                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}


class PropertyTypeDropDown extends StatefulWidget {
  final List<String> propertyType;
  String selectedPropertyType;

  PropertyTypeDropDown({super.key, required this.propertyType, required this.selectedPropertyType});

  @override
  State<PropertyTypeDropDown> createState() => _PropertyTypeDropDownState();
}

class _PropertyTypeDropDownState extends State<PropertyTypeDropDown> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedPropertyType,
      icon: const Icon(Icons.arrow_drop_down_sharp, size: 30,),
      elevation: 16,
      underline: Container(),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          // handle the onSelect method
        });
      },
      items: widget.propertyType.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
