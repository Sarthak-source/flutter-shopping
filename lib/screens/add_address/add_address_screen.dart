import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/add_address_controller.dart';

import '../../constants/colors.dart';
import '../../controllers/mycart_controller.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/back_button_ls.dart';
import '../map_screen.dart';

class AddAddressScreen extends StatelessWidget {
  static const routeName = '/add_address_screen';

   AddAddressScreen({super.key});

  final AddAddressController controller = Get.put(AddAddressController());

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return GetBuilder<AddAddressController>(
        builder: (controller) {
     return Scaffold(
       floatingActionButton: Padding(
         padding: const EdgeInsets.only(bottom: 80.0),
         child: FloatingActionButton(

             onPressed: (){},
             backgroundColor: kPrimaryBlue,
             child: Icon(Icons.add,color: Colors.white,)),
       ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(
                  getProportionateScreenWidth(18),
                ),
                child: Container(
                //  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const BackButtonLS(),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Add Your Address',
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(17),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.myAddressItems.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        print('controller.myAddressItems lg.... ${controller.myAddressItems.length}');

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:GestureDetector(
                            onTap: (){
                              controller.slectedIndex = RxInt(index);
                              controller.update();
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:controller.slectedIndex==index?kPrimaryBlue.withOpacity(0.2) :Colors.white,
                              ),
                              child: ListTile(

                                title:  Text(controller.myAddressItems[index]["address_line1"],
                                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: getProportionateScreenWidth(14),
                                  ),),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.myAddressItems[index]["address_line2"], style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w100,
                                          fontSize: getProportionateScreenWidth(11),
                                        )),
                                    Text(controller.myAddressItems[index]["address_line3"], style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontSize: getProportionateScreenWidth(11),
                                    )),
                                    Text("GST : ${controller.myAddressItems[index]["gstin"]["gstin"]}", style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontSize: getProportionateScreenWidth(11),
                                    )),
                                    Divider(),
                                  ],
                                ),
                                leading: Icon(Icons.factory_outlined,size: 30,),
                              ),
                            ),
                          ),


                        );
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenWidth(16.0),
                  horizontal: getProportionateScreenWidth(16.0),
                ),
                child: ElevatedButton(
                  onPressed: () {

                  },
                  child: const Text('Next'),
                ),
              ),
            ]
            ,
          ),
        ),
      );}
    );
  }
}
