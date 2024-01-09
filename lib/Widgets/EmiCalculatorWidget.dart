import 'dart:math';

import 'package:flutter/material.dart';

class EmiCalculatorWidget extends StatefulWidget {
  const EmiCalculatorWidget({Key? key}) : super(key: key);

  @override
  State<EmiCalculatorWidget> createState() => _EmiCalculatorWidgetState();
}

class _EmiCalculatorWidgetState extends State<EmiCalculatorWidget> {
  final _formKey = GlobalKey<FormState>();
  final _principleAmmountController = TextEditingController();
  final FocusNode _principleAmmountFocusNode = FocusNode();

  final _downPaymentController = TextEditingController();
  final FocusNode _downPaymentFocusNode = FocusNode();

  final _interestController = TextEditingController();
  final FocusNode _interestFocusNode = FocusNode();

  final _timeController = TextEditingController();
  final FocusNode _timeFocusNode = FocusNode();

  double monthlyEmi = 0.0;
  double calculateEMI(double principalAmount, double downPayment, int loanTenureInYears, double annualInterestRate) {
    // Calculate loan amount (principal - down payment)
    double loanAmount = principalAmount - downPayment;

    // Convert annual interest rate to monthly interest rate
    double monthlyInterestRate = (annualInterestRate / 12) / 100;

    // Calculate total number of monthly installments (loan tenure in years * 12)
    int totalInstallments = loanTenureInYears * 12;

    // Calculate EMI using the formula
    double emi = loanAmount * monthlyInterestRate * pow(1 + monthlyInterestRate, totalInstallments) /
        (pow(1 + monthlyInterestRate, totalInstallments) - 1);
    return emi;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                    controller: _principleAmmountController,
                    focusNode: _principleAmmountFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Principle Ammount',
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            // color: Theme.of(context).hintColor
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter valid principle ammount';
                      }
                      return null;
                    }),
              ),

              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                    controller: _downPaymentController,
                    focusNode: _downPaymentFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Down Payment',
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            // color: Theme.of(context).hintColor
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        )),
                    validator: (value) {
                      double dp = double.tryParse(value.toString()) ?? 0.0;
                      double pam = double.tryParse(_principleAmmountController.text) ?? 0.0;
                      if (value!.isEmpty || dp>pam) {
                        return 'down payment should be less than principle amount';
                      }
                      return null;
                    }),
              ),


              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: TextFormField(
                            controller: _interestController,
                            focusNode: _interestFocusNode,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'Interest Rate',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    // color: Theme.of(context).hintColor
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter valid interest rate';
                              }
                              return null;
                            }),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: TextFormField(
                            controller: _timeController,
                            focusNode: _timeFocusNode,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'time in years',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    // color: Theme.of(context).hintColor
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter valid value';
                              }
                              return null;
                            }),
                      ),
                    )
                  ],
                ),
              ),


              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Monthly EMI: ',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    )),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.08,
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            '₹ ${monthlyEmi.ceil().toString()} ',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Theme.of(context).hintColor),
                          ))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      double principalAmount = double.tryParse(_principleAmmountController.text) ?? 0.0;
                      double downPayment = double.tryParse(_downPaymentController.text) ?? 0.0;
                      int loanTenureInYears = int.tryParse(_timeController.text) ?? 0;
                      double annualInterestRate = double.tryParse(_interestController.text) ?? 0.0;
                      monthlyEmi= calculateEMI(principalAmount, downPayment, loanTenureInYears, annualInterestRate);
                      setState(() {

                      });
                    }
                  },
                  child: Text(
                    'Calculate EMI',
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}