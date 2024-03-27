import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/screens/paymentScreen/enterAmount.dart';
import 'package:sutra_ecommerce/screens/paymentScreen/upi_screen.dart';

import '../../config/common.dart';
import '../../controllers/mycart_controller.dart';
import '../../controllers/payment_controller.dart';
import '../../utils/circularCheckbox_text.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/back_button_ls.dart';
import '../../widgets/custom_text_field.dart';

class SelectPaymentMethod extends StatefulWidget {
  String? shift;
  int? selectedIndex;
  String? selectedDate;
  String? address;
  String? totalAmount;
   SelectPaymentMethod({super.key,this.shift,this.selectedIndex,this.selectedDate,this.address,this.totalAmount});
  static const routeName = '/selectPaymentMethod';
  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  final PaymentController controller = Get.put(PaymentController());
  final MyCartController createOrderCtlr = Get.put(MyCartController());
  late FocusNode focusNode;
  bool isTextFieldFocused = false;
  String? isCODallowed = "";
  String? clientupiId = "";
  String? planId = "";
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {
        isTextFieldFocused = focusNode.hasFocus;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.upi.value = false;
      controller.cod.value = false;
      controller.showUpi.value = false;
      Map storedUserData=box!.get('userData');
      print('userdata in paymentselection ${ storedUserData['party']['COD_Allowed'].toString()}');
      isCODallowed =storedUserData['party']['COD_Allowed'].toString();
      clientupiId =storedUserData['party']['route_code']['plant']['UPI_id'].toString();
      planId =storedUserData['party']['route_code']['plant']['id'].toString();


    });

  }
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: getProportionateScreenWidth(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BackButtonLS(),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Select Payment Method',
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(17),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               const SizedBox(height: 50),
              Container(
              //  color: Colors.red,
                width:Get.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isCODallowed !=null && isCODallowed == "No"?
                      CircularCheckBoxWithText(
                        codNotAllowed: "NO",
                    text: 'COD',
                    initialValue: false,
                    onChanged: (value) {
                      // Do something with the value
                      print('Checkbox COD: $value');
                      },
                  ) :
                      CircularCheckBoxWithText(
                        text: 'COD',
                        initialValue: controller.cod.value,
                        onChanged: (value) {
                          // Do something with the value
                          print('Checkbox COD: $value');
          
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                elevation: 0.0,
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Are you sure?',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      Text(''),
                                      SizedBox(height: 16.0),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Close the dialog
                                           createOrderCtlr.createOrderApi(
                                               "1",
                                               (widget.selectedIndex!+2).toString(),
                                               widget.selectedDate.toString(),
                                               widget.address,
                                               widget.totalAmount.toString(),
                                            "COD",// "Online",
                                            "",// "1234567",
                                           "",//  "ggghhhh4444",
                                            ""// "Success"
                                           );
                                        },
                                        child: Text('Submit'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
          
          
                          setState(() {
                            if(value == true){
                              controller.cod.value = value;
                              controller.upi.value = false;
                              controller.update();
                           //   Navigator.push(context, MaterialPageRoute(builder: (context) =>EnterAmount(paymentType: "cod",)));
                             // createOrderCtlr.createOrderApi("1", (widget.selectedIndex!+2).toString(), widget.selectedDate.toString(), widget.address);
                            }else{
                              controller.cod.value = value;
                              controller.upi.value = true;
                              controller.update();
                             // upi = true;
                            }
          
                          });
          
                        },
                      ),
                      const SizedBox(height: 8),
                      isCODallowed !=null && isCODallowed == "No"?Text("COD Not Allowed",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11,color: Colors.red),):SizedBox.shrink(),
                      const SizedBox(height: 50),
                      CircularCheckBoxWithText(
                        text: 'UPI',
                        initialValue: controller.upi.value,
                        onChanged: (value) {
                          // Do something with the value
                          setState(() {
                            if(value == true){
                              controller.upi.value = value;
                              controller.cod.value = false;
                              controller.update();
                            //  Navigator.push(context, MaterialPageRoute(builder: (context) =>EnterAmount(paymentType: "upi",)));
                            }else{
                              controller.upi.value = value;
                              controller.cod.value = true;
                              controller.update();
                            //  cod = true;
                            }
                          });
                          print('Checkbox UPI: $value');
                        },
                      ),
                      const SizedBox(height: 30),

                      controller.upi.value? Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey, // Border color
                          width: 1.0, // Border width
                        ),
                        borderRadius: BorderRadius.circular(getProportionateScreenWidth(8)),
                      ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(

                            children: [
                              controller.upi.value?
                              Row(
                                children: [
                                  Text("Ordered Amount ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),),
                                  Expanded(child: Text(": ${widget.totalAmount}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black))),
                                ],
                              ):SizedBox.shrink(),
                              const SizedBox(height: 20),
                              controller.upi.value?
                              CustomTextField(
                                  FocusNode: focusNode,
                                  onChanged: (v){
                                    // if(v != amountController.text){
                                    controller.showUpi.value = true;
                                    controller.update();
                                    //  }

                                  },
                                  controller: amountController,
                                  hint: 'Enter amount',
                                  TextInputType: TextInputType.number
                              ):SizedBox.shrink(),
                              const SizedBox(height: 50),
                              controller.upi.value?
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(16.0),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:isTextFieldFocused?kPrimaryBlueBG:kTextColorAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          12), // <-- Radius
                                    ),
                                  ),
                                  onPressed: () {
                                    // Get.toNamed(FlutterPayUPI.routeName);
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    if(amountController.text == null || amountController.text ==""){
                                      Fluttertoast.showToast(
                                        msg: 'Enter Amount',
                                        backgroundColor: Colors.red,
                                      );
                                    }
                                    else{
                                      controller.showUpi.value = true;
                                      controller.update();
                                      //  Navigator.push(context, MaterialPageRoute(builder: (context) =>FlutterPayUPI(paymentAmount: amountController.text,)));

                                    }


                                  },
                                  child: const Text('Submit'),
                                ),
                              ):SizedBox.shrink(),
                              const SizedBox(height: 50),
                              controller.showUpi.value?
                              Container(
                                  height: 300,
                                //  width: Get.width,
                                //  color: Colors.red.shade50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FlutterPayUPI(paymentAmount: amountController.text,

                                        Successcallback: (upiRequestParams,amnt,transID,merchId){
                                     // if(upiRequestParams.status ?? "N/A" ==  ""){}
                                      print('upiRequestParams:::${upiRequestParams?.status}');
                                      var upiCallBackStatus =upiRequestParams?.status;
                                      if(upiCallBackStatus != null && upiCallBackStatus == "success"){

                                        createOrderCtlr.createOrderApi(
                                            "1",
                                            (widget.selectedIndex!+2).toString(),
                                            widget.selectedDate.toString(),
                                            widget.address,
                                            widget.totalAmount.toString(),
                                             "Online",
                                            clientupiId ??"",
                                            transID ?? "",
                                            upiCallBackStatus?? ""  // "Success"
                                        );
                                      }
                                                  }),
                                  )): SizedBox.shrink()
                            ],
                          ),
                        ),
                      ):SizedBox.shrink(),

                    ],
                  ),
                ),
              )
          
            ],
          ),
        ),
      ),
    );
  }
}
