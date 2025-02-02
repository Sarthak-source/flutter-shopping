import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/hive_models/Orders/create_order.dart';
import 'package:sutra_ecommerce/screens/paymentScreen/enterAmount.dart';
import 'package:sutra_ecommerce/screens/paymentScreen/upi_screen.dart';

import '../../config/common.dart';
import '../../controllers/mycart_controller.dart';
import '../../controllers/payment_controller.dart';
import '../../hive_models/cart/cart_model.dart';
import '../../utils/circularCheckbox_text.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/back_button_ls.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/loading_widgets/loader.dart';

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
  Box<CreateOrderModel>? createOrderBox;
  List<CreateOrderModel>? catModelList = [];
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    checkForDBdata();
    focusNode.addListener(() {
      setState(() {
        isTextFieldFocused = focusNode.hasFocus;
      });
    });




    Map storedUserData=box!.get('userData');
    print('userdata in paymentselection ${ storedUserData['party']['COD_Allowed'].toString() }');
    isCODallowed =storedUserData['party']['COD_Allowed']!=null?storedUserData['party']['COD_Allowed'].toString():"";
    print('userdata in isCODallowed ${ isCODallowed.toString() }');
    clientupiId =storedUserData['party']['route_code']['plant']['UPI_id']!=null?storedUserData['party']['route_code']['plant']['UPI_id'].toString():"";
    planId =storedUserData['party']['route_code']['plant']['id']!=null?storedUserData['party']['route_code']['plant']['id'].toString():"";
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.upi.value = false;
      controller.cod.value = false;
      controller.showUpi.value = false;
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


              createOrderCtlr.isLoading.value == true? Center(child: Loader()):  Container(
              //  color: Colors.red,
                width:Get.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isCODallowed !=null && isCODallowed == "No"?

                      Row(
                        children: [
                          Container(

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child:  Icon(
                                Icons.check,
                                size: 15.0,
                                color: Colors.white,
                              )

                            ),
                          ),
                          SizedBox(width: 14),
                          Text("COD",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),),
                        ],
                      ) :
                      CircularCheckBoxWithText(
                        text: 'COD',
                        initialValue: controller.cod.value,
                        onChanged: (value) {
                          // Do something with the value
                          print('Checkbox COD: $value');
                          /* showDialog(
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
                          );*/



                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(""),
                                content: const Text("Are you sure? would you like to place the order."),

                                actions: [
                                  TextButton(
                                    child: const Text("Cancel"),
                                    onPressed: () {
                                      controller.upi.value = false;
                                      controller.cod.value = false;
                                      Navigator.pop(context);

                                    },
                                  ),
                                  TextButton(
                                    child: const Text("Ok"),
                                    onPressed: () async{
                                      Navigator.pop(context); // Close the dialog
                               /*       createOrderCtlr.createOrderApi(   //COD FLOW
                                          "1",
                                          (widget.selectedIndex!+2).toString(),
                                          widget.selectedDate.toString(),
                                          widget.address,
                                          widget.totalAmount.toString(),
                                          "COD",// "Online",
                                          "",// "1234567",
                                          "",//  "ggghhhh4444",
                                          ""// "Success"
                                      );*/
                                      await Hive.deleteBoxFromDisk('createorder');
                                      localBox = await Hive.openBox<CreateOrderModel>('createorder');
                                      createOrderBox?.delete(["amtPaid","payMode","upiId","upiTransId","upiTransSts"]);
                                      createOrderBox = Hive.box<CreateOrderModel>('createorder');
                                      catModelList?.clear();
                                      catModelList = createOrderBox?.values.toList();
                                      print('All data from hive before adding:: ${catModelList?.length}');
                                      var catModel = CreateOrderModel(widget.totalAmount.toString(), "COD" ,"","","",widget.selectedIndex == null? "":(widget.selectedIndex!+2).toString(),widget.selectedDate==null?"":widget.selectedDate.toString(),widget.address ?? "" ); //creating object
                                      createOrderBox?.deleteAll(["amtPaid","payMode","upiId","upiTransId","upiTransSts"]);

                                      await createOrderBox?.put(catModel.amtPaid, catModel); //putting object into hive box
                                      catModelList = createOrderBox?.values.toList(); //get all items in list
                                     if(catModelList != null && catModelList!.isNotEmpty){
                                       String amt ="";
                                       String payMode ="";
                                       String shift ="";
                                       String date ="";
                                       String address ="";
                                       for(var i=0 ; i<catModelList!.length; i++){
                                         print('All data from hive:: ${catModelList?[i].amtPaid},${catModelList?[i].payMode}');
                                         amt = catModelList?[i].amtPaid ?? "";
                                         payMode = catModelList?[i].payMode ?? "";
                                         shift = catModelList?[i].shift ?? "";
                                         date = catModelList?[i].date ?? "";
                                         address = catModelList?[i].address ?? "";
                                       }
                                       print('All data from hive2::amnt: $amt,paymode: $payMode address: $address shift: $shift date: $date' );
                                           createOrderCtlr.createOrderApi(   //COD FLOW
                                               shift,
                                               date,
                                               address,
                                               amt.toString(),
                                               payMode,// "Online",
                                               "",// "1234567",
                                               "",//  "ggghhhh4444",
                                               "",// "Success"
                                            (v) async {
                                            if(v == true){
                                              await  localBox?.delete(catModel.amtPaid);
                                              catModelList = createOrderBox?.values.toList() ?? [];
                                                print('after success:: ${catModelList?.length}');
                                            }
                                           }
                                      );

                                     }



                                    },
                                  ),
                                ],
                              );
                            },
                          );
          
          
                          setState(() {
                            if(value == true){
                              controller.cod.value = value;
                              controller.upi.value = false;
                              controller.update();
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
                      Platform.isIOS?SizedBox.shrink(): CircularCheckBoxWithText(
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
                              controller.cod.value = false;
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
                                  Text("Order Amount ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),),
                                  Expanded(child: Text(": ₹ ${widget.totalAmount}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black))),
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
                                  child: const Text('Pay'),
                                ),
                              ):SizedBox.shrink(),
                              const SizedBox(height: 50),
                              controller.showUpi.value?
                              Container(
                                  height: 200,
                                //  width: Get.width,
                                //  color: Colors.red.shade50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: FlutterPayUPI(paymentAmount: amountController.text,

                                        Successcallback: (upiRequestParams,amnt,transID,merchId) async {
                                     // if(upiRequestParams.status ?? "N/A" ==  ""){}

                                          if(amnt != "IOS"){
                                            print('upiRequestParams:::${upiRequestParams?.status}');
                                            var upiCallBackStatus =upiRequestParams?.status;
                                            if(upiCallBackStatus != null && upiCallBackStatus == "success"){


                                              await Hive.deleteBoxFromDisk('createorder');
                                              localBox = await Hive.openBox<CreateOrderModel>('createorder');
                                              createOrderBox?.delete(["amtPaid","payMode","upiId","upiTransId","upiTransSts"]);
                                              createOrderBox = Hive.box<CreateOrderModel>('createorder');
                                              catModelList?.clear();
                                              catModelList = createOrderBox?.values.toList();
                                              print('All data from hive before adding:: ${catModelList?.length}');
                                              var catModel = CreateOrderModel(widget.totalAmount.toString(), "COD" ,clientupiId ??"",transID?? "",upiCallBackStatus,widget.selectedIndex == null? "":(widget.selectedIndex!+2).toString(),widget.selectedDate==null?"":widget.selectedDate.toString(),widget.address ?? "" ); //creating object
                                              createOrderBox?.deleteAll(["amtPaid","payMode","upiId","upiTransId","upiTransSts"]);

                                              await createOrderBox?.put(catModel.amtPaid, catModel); //putting object into hive box
                                          catModelList = createOrderBox?.values.toList(); //get all items in list
                                          if(catModelList != null && catModelList!.isNotEmpty){
                                          String amt ="";
                                          String payMode ="";
                                          String shift ="";
                                          String date ="";
                                          String address ="";
                                          String databasetransID ="";
                                          String clientupi ="";
                                          String transts ="";
                                          for(var i=0 ; i<catModelList!.length; i++){
                                          print('All data from hive:: ${catModelList?[i].amtPaid},${catModelList?[i].payMode}');
                                          amt = catModelList?[i].amtPaid ?? "";
                                          payMode = catModelList?[i].payMode ?? "";
                                          shift = catModelList?[i].shift ?? "";
                                          date = catModelList?[i].date ?? "";
                                          address = catModelList?[i].address ?? "";
                                          databasetransID = catModelList?[i].upiTransId ?? "";
                                          clientupi = catModelList?[i].upiId ?? "";
                                          transts = catModelList?[i].upiTransSts ?? "";
                                          }
                                          print('All data from hive2::amnt: $amt,paymode: $payMode address: $address shift: $shift date: $date databasetransID: $databasetransID clientupi: $clientupi transts: $transts' );

                                         /* Fluttertoast.showToast(
                                            msg: 'All data from hive2::amnt: $amt,paymode: $payMode address: $address shift: $shift date: $date databasetransID: $databasetransID clientupi: $clientupi transts: $transts' ,
                                            backgroundColor: Colors.red,
                                          );*/
                                          createOrderCtlr.createOrderApi(

                                              shift,
                                              date,
                                              address,
                                              amnt.toString(),
                                              payMode,
                                              clientupi,
                                              databasetransID,
                                              transts,  // "Success"
                                          (v) async {
                                            if(v == true){
                                              await  localBox?.delete(catModel.amtPaid);
                                            catModelList = createOrderBox?.values.toList() ?? [];
                                            print('after success:: ${catModelList?.length}');
                                          }
                                          }

                                          );

                                          }

                                            }

                                          }else{
                                            createOrderCtlr.createOrderApi(

                                                (widget.selectedIndex!+2).toString(),
                                                widget.selectedDate.toString(),
                                                widget.address,
                                                amountController.text.toString(),
                                                "Online",
                                                clientupiId ??"",
                                                transID ?? "",
                                                "success" , // "Success"
                                                (v){}
                                            );
                                          }


                                                  }

                                                  ),
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

  Future<void> checkForDBdata() async {
    localBox = await Hive.openBox<CreateOrderModel>('createorder');
    createOrderBox = Hive.box<CreateOrderModel>('createorder');
    catModelList = createOrderBox?.values.toList();
    print('All data from hive in initstate:: ${catModelList?.length}');
    if(catModelList!= null && catModelList!.isNotEmpty){
      String amt ="";
      String payMode ="";
      String shift ="";
      String date ="";
      String address ="";
      for(var i=0 ; i<catModelList!.length; i++){
        print('All data from hive:: ${catModelList?[i].amtPaid},${catModelList?[i].payMode}');
        amt = catModelList?[i].amtPaid ?? "";
        payMode = catModelList?[i].payMode ?? "";
        shift = catModelList?[i].shift ?? "";
        date = catModelList?[i].date ?? "";
        address = catModelList?[i].address ?? "";
      }
      print('All data from hive2::amnt: $amt,paymode: $payMode address: $address shift: $shift date: $date' );
      createOrderCtlr.createOrderApi(   //COD FLOW
          shift,
          date,
          address,
          amt.toString(),
          payMode,// "Online",
          "",// "1234567",
          "",//  "ggghhhh4444",
          "",// "Success"
              (v) async {
            if(v == true){
              await Hive.deleteBoxFromDisk('createorder');
              catModelList = createOrderBox?.values.toList() ?? [];
              print('after success from initstate:: ${catModelList?.length}');
            }
          }
      );
    }else{

    }
  }
}
