import 'dart:convert';
import 'package:hr_app/data/model/body/menu_model_status_request.dart';
import 'package:hr_app/data/model/response/menu_model.dart';
import 'package:hr_app/provider/product_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../../data/model/body/MenuModelRequest.dart';
import '../../../data/model/body/login_model_info.dart';
import '../../../data/model/response/store_model.dart';
import '../../../helper/security_helper.dart';
import '../../../helper/user_login_info.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/splash_provider.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/strings_manager.dart';
import '../../base/custom_dialog.dart';
import '../../base/custom_dropdown_obj.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late ProgressDialog pd;
  late MenuModel menuModels;
  late TextEditingController _searchController;
  late Store _storeSelected;
  @override
  void initState() {
    // Provider.of<ParseProvider>(context, listen: false)
    //     .getOrderListAll(context, 2);
    super.initState();
    pd = ProgressDialog(context: context);
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    menuModels = context.watch<ProductProvider>().menuModelList;
    List<Store>? storeList = Provider.of<SplashProvider>(context, listen: false)
        .storeModelList
        .result;
    return Scaffold(
       backgroundColor: ColorResources.MAIN_COLOR,
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Image.asset(Images.logo_with_app_name, height: 35),
        ),
        body: buildBody(context,storeList)
    );
  }

  Widget buildBody(BuildContext context, List<Store>? storeList) {
    //==========product=======
    var userModelInfo =  getLoginInfo(context);
    String data_enc_menu =
    SecurityHelper.getDataEncryptionKey(dataTypes: [
      AppConstants.CSTORE_LIST_MENU_STATUS,
    ], dev_kit: AppConstants.dev_kid);

    MenuModelRequest menuModelRequest = MenuModelRequest(
        devKid: AppConstants.dev_kid,
        function: AppConstants.store_app_function,
        storeappFunction:
        AppConstants.store_app_function_check_all_menu_status,
        datas: DatasMenuRequest(
            dataEncryption: data_enc_menu,
            storeid: userModelInfo.storeId,
            func: AppConstants.func_type));

    return Padding(
      padding: EdgeInsets.only(right: 4, left: 4, top: 4, bottom: 4),
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Padding(
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      child: Container(
                        margin: EdgeInsets.only(right: 18, left: 18),
                        child: Text(
                          "History",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orangeAccent
                          ),
                        ),
                      )),
                   Container(
                       padding: EdgeInsets.only(top: 4, bottom: 4),
                       margin: EdgeInsets.only(right: 18, left: 18),
                       width: 200.0, //or whatever you want
                      child: CustomDropdownObj(
                        border: true,
                        hintText: AppStrings.select_store,
                        items: storeList ?? [],
                        onChanged: (item) {
                          _storeSelected = item;
                        },
                      )),
                ],
              )
          ),

              // context.watch<ProductProvider>().isLoading?
              // Expanded(child: Container(child: Center(child: CircularProgressIndicator(),),)):
         Expanded(
              child: ListView.builder(
                itemCount: menuModels.result!.length,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                itemBuilder: (context, index) {
                  return _item(menuModels.result![index]);
                },
              )
          ),
        ],
      ),
    );
  }

  Widget _item(Menu menu){

    return Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0),
        child: Container(
          color: Colors.white54,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Image.asset(
                  //   'assets/image/2.png',
                  //   scale: 1.6,
                  // ),
                  Container(
                    child: CachedNetworkImage(
                      errorWidget: (ctx, url ,err )=>Image.asset(Images.placeholder_image,
                        height: Dimensions.chat_image, width: Dimensions.chat_image, fit: BoxFit.cover,),
                      placeholder: (ctx, url )=>Image.asset(Images.placeholder_image),
                      imageUrl: 'https://www.browncoffee.com.kh/uploads/ximg/item_menus/${menu.menuPicture}',
                      fit: BoxFit.cover, height: Dimensions.chat_image, width: Dimensions.chat_image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: menu.status == "2"? ColorFilter.mode(Colors.black38, BlendMode.darken):ColorFilter.mode(Colors.white, BlendMode.darken)
                              ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(menu.menuName!,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              menu.status == "3"?Images.ic_veg:Images.ic_no_veg,
                              height: 16.0,
                              width: 16.7,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text('\$ Not Show',
                                style:
                                Theme.of(context).textTheme.caption),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned.directional(
                end: 0.0,
                bottom: 8.0,
                textDirection: Directionality.of(context),
                child: Row(
                  children: [
                    Text( menu.status == "3"?'In Stock':'Out Stock',

                      style: TextStyle(
                          color: menu.status == "3"? Theme.of(context).primaryColor:Theme.of(context).hintColor,
                          fontSize: 13.3,
                          fontWeight: FontWeight.bold),
                    ),
                    Switch(
                      activeColor: Theme.of(context).primaryColor,
                      activeTrackColor: Colors.grey[300],
                      value: menu.status == "3"? true:false,
                      onChanged: (value) async {

                        //==========product=======
                        String data_enc_menu = SecurityHelper.getDataEncryptionKey(
                            dataTypes: [
                              "CSTORE_LIST_MENU_STATUS",
                            ],
                            dev_kit: AppConstants.dev_kid
                        );

                        final String userInfo = Provider.of<AuthProvider>(context,listen: false).getUserInfo();
                        Map<String, dynamic> jsonUserInfo = jsonDecode(userInfo);
                        var userModelInfo = LoginModelInfo.fromJson(jsonUserInfo);

                        MenuModelStatusRequest menuModelStatusRequest = MenuModelStatusRequest(
                            devKid: AppConstants.dev_kid,
                            function: AppConstants.store_app_function,
                            storeappFunction: AppConstants.store_app_function_dis_enable_menu,
                            datas: DatasenuModelStatusRequest(
                                func: AppConstants.func_type,
                                storeid: userModelInfo.storeId,
                                zoneid: menu.zoneid,
                                menuid: menu.idMenu,
                                foodcode: menu.linkedCode,
                                status: menu.status == "3"? "2":"3",
                                dataEncryption: data_enc_menu
                            ));
                        MenuModelRequest menuModelRequest = MenuModelRequest(devKid: AppConstants.dev_kid, function: AppConstants.store_app_function, storeappFunction: AppConstants.store_app_function_check_all_menu_status, datas: DatasMenuRequest(dataEncryption: data_enc_menu,storeid: userModelInfo.storeId, func: AppConstants.func_type));
                        //pd.show(max: 90, msg: 'Please waiting...');
                        showDialog(
                          // The user CANNOT close this dialog  by pressing outsite it
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => CustomDialog(title: AppStrings.please_wait,)
                         );
                        await Provider.of<ProductProvider>(context, listen: false).setMenuStatus(context, menuModelStatusRequest, menuModelRequest, query: _searchController.text.trim());
                        // if(pd.isOpen()){
                        //   pd.close();
                        // }
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
