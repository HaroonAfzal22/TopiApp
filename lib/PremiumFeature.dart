import 'dart:async';
import 'dart:collection';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/NavigationDrawer.dart';
import 'package:topi/OutlineBtn.dart';
import 'package:topi/Subscriptions/consumeable_store.dart';
import 'package:topi/Widgets/premium_widget.dart';
import 'package:topi/constants.dart';


const bool _kAutoConsume = true;
const String _kSilver_30 = '01_month_30';
const String _kSilver_180 = '01_hmonth_180';
const String _kSilver_365 = '01_ymonth_365';
const String _kGold_30 = '02_month_30';
const String _kGold_180 = '02_hmonth_180';
const String _kGold_365 = '02_ymonth_365';
const String _kDiamong_30 = '03_month_30';
const String _kDiamong_180 = '03_hmonth_180';
const String _kDiamong = '03_ymonth_365';
const String _kConsumableId = 'one_product_3';
// const String _kUpgradeId = '01_hmonth_180';
// const String _kSilverSubscriptionId = 'six_months_180';
// const String _kGoldSubscriptionId = 'one_year_365';

const List<String> _kProductIds = <String>[
  _kConsumableId,
  // _kUpgradeId,
  _kSilver_30,
  _kSilver_180,
  _kSilver_365,
  _kGold_30,
  _kGold_180,
  _kGold_365,
  _kDiamong_30,
  _kDiamong_180,
  _kDiamong
];

class PremiumFeature extends StatefulWidget {
  const PremiumFeature({Key? key}) : super(key: key);

  @override
  _PremiumFeatureState createState() => _PremiumFeatureState();
}

class _PremiumFeatureState extends State<PremiumFeature> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[].toSet().toList();
  List<String> _consumables = <String>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // handle error here.
    });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _notFoundIds = <String>[];
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
    _inAppPurchase.restorePurchases();

  }
// i am printing purchases  here
  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      // print to loop where listen update
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // showPendingUI();
      }
      else if (purchaseDetails.error == null ){
        print('Erro printing ${purchaseDetails.error}');
        _purchases.add(purchaseDetails);
        print('_purchases Loop $_purchases'); // print to loop where listen update
        print('purchaseDetailsList Loop $purchaseDetails');

        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
      ('Printing purchases list data ${_purchases.length}');
    }
  }
// Google Play store Function For Subscription

  void goToPlayStore(pItem) {
    late PurchaseParam purchaseParam;
    /*var currentPurchse;
    var oldPurchase;
    if(_purchases.isNotEmpty){
      for(int i =0; i<_purchases.length; i++){
        if(_purchases[i].productID== _products[1].id && pItem=='01_hmonth_180'){
          print('upgraded ${pItem}');
          currentPurchse =_products[0];
          oldPurchase =_purchases[i];
        }else if(_purchases[i].productID==_products[1].id && pItem=='01_ymonth_365'){
          print('upgraded ${pItem}');
          currentPurchse =_products[2];
          oldPurchase =_purchases[i];
        }else if(_purchases[i].productID==_products[0].id && pItem=='01_ymonth_365'){
          print('upgraded second ${pItem}');
          currentPurchse =_products[2];
          oldPurchase =_purchases[i];
        }
        else if(_purchases[i].productID==_products[0].id && pItem=='01_month_30'){
          print('upgraded second ${pItem}');
          currentPurchse =_products[1];
          oldPurchase =_purchases[i];
        }
        else if(_purchases[i].productID==_products[2].id && pItem=='01_hmonth_180'){
          print('Down Grading App ${pItem}');
          currentPurchse =_products[0];
          oldPurchase =_purchases[i];

        } else if(_purchases[i].productID==_products[2].id && pItem=='01_month_30'){
          print('Down Grading App ${pItem}');
          currentPurchse =_products[1];
          oldPurchase =_purchases[i];

        }
      }
      print('Printing After if else in the if statement');
      purchaseParam =  GooglePlayPurchaseParam(
          productDetails: currentPurchse,
          applicationUserName: 'Haroon Afzal',
          changeSubscriptionParam: (_purchases.isNotEmpty)
              ? ChangeSubscriptionParam(
            oldPurchaseDetails: oldPurchase as GooglePlayPurchaseDetails,
            prorationMode: ProrationMode
                .immediateWithTimeProration,
          )
              : null);
    }
    else if (_purchases.isEmpty){
     print('Enter in the Else statement');
     purchaseParam = PurchaseParam(productDetails: pItem);
   }*/
    purchaseParam = PurchaseParam(productDetails: pItem);
    InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
    print('context is printing');
      Navigator.pop(context);


  } // old Subscriptions


  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_products Lenght and Data  ${_products.length} +  ${_products}');
    inspect(_products);
    print('_purchases Lenght and Data  ${_purchases.length} +  ${_purchases}');
    inspect(_purchases);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0.0,
        title: Image.asset(
          'assets/topi.png',
          fit: BoxFit.contain,
          width: 80,
          height: 80,
        ),
        centerTitle: true,
      ),
      drawer: Drawers(),
      backgroundColor: Colors.black87,
      extendBody: true,
      body: SafeArea(
        child: BackgroundGradient(
          childView: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                alignment: Alignment.center,
                child: Text(
                  'Subscription Plan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              cusomtCardWidget(
                cTittle: 'Silver Pack',
                cSubtitle: 'Ads free + Premium templates',
                contaierColor: [
                  Color(0xff0cf268),
                  Color(0xffd0be22),
                  Color(0xff1c1fe0),
                ],
                buttonColor: [Colors.cyan, Colors.deepOrangeAccent],
                Conpressed: () {
                  _settingModalBottomSheet(
                    fBoxText: '1-Month',
                    fBoxAmount: '\$2.99',
                    fOnPressed: () {
                      goToPlayStore(_products[1]);
                    },
                    sBoxText: '6-Months',
                    sBoxAmount: '\$16.99',
                    sOnPressed: () {
                      goToPlayStore(_products[0]);
                    },
                    tBoxText: '1 Year',
                    tBoxAmount: '\$29.99',
                    tOnPressed: () {
                      goToPlayStore(_products[2]);
                    },
                  );
                },
              ),
              cusomtCardWidget(
                cTittle: 'Gold Pack',
                cSubtitle: 'Without watermark + Premium Music',
                contaierColor: [
                  Color(0xff85f20c),
                  Color(0xffec6b09),
                  Color(0xff1ca2e0),
                ],
                buttonColor: [Colors.cyan, Colors.deepOrangeAccent],
                Conpressed: () {
                  _settingModalBottomSheet(
                    fBoxText: '1-Month',
                    fBoxAmount: '\$3.99',
                    fOnPressed: () {
                      goToPlayStore(_products[4]);
                    },
                    sBoxText: '6-Months',
                    sBoxAmount: '\$17.99',
                    sOnPressed: () {
                      goToPlayStore(_products[3]);
                    },
                    tBoxText: '1 Year',
                    tBoxAmount: '\$39.99',
                    tOnPressed: () {
                      goToPlayStore(_products[5]);
                    },
                  );
                },
              ),
              cusomtCardWidget(
                cTittle: 'Platinum Pack',
                cSubtitle: 'Without watermark + Premium music + Ads free',
                contaierColor: [
                  Color(0xff5454f6),
                  Color(0xff09c5ec),
                  Color(0xff1ce046),
                ],
                buttonColor: [Colors.cyan, Colors.deepOrangeAccent],
                Conpressed: () {
                  _settingModalBottomSheet(
                    fBoxText: '1-Month',
                    fBoxAmount: '\$5.99',
                    fOnPressed: () {
                      goToPlayStore(_products[7]);
                    },
                    sBoxText: '6-Months',
                    sBoxAmount: '\$30.99',
                    sOnPressed: () {
                      goToPlayStore(_products[6]);
                    },
                    tBoxText: '1 Year',
                    tBoxAmount: '\$49.99',
                    tOnPressed: () {
                      goToPlayStore(_products[8]);
                    },
                  );
                },
              ),
              Container(

                margin: EdgeInsets.only(top: 90,right: 40,left: 40,bottom: 10),
                width: 10,
                height: 40,
                child: UnicornOutlineButton(
                  strokeWidth: 1,
                  radius: 10,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff85f20c),
                      Color(0xffec6b09),
                      Color(0xff1ca2e0),
                    ],
                    // [Colors.cyan, Colors.deepOrangeAccent]
                  ),
                  child: Text(
                    'Tap To View Subscription Detail',
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                        foreground: Paint()..shader = linearGradient),
                  ),
                  onPressed: (){
                  // _inAppPurchase.restorePurchases();

                    _subscriptionDetailsModalBottomSheet(context,_purchases);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //for modal bottom sheet to show children
  _settingModalBottomSheet({
    required String? fBoxText,
    required String? fBoxAmount,
    required VoidCallback fOnPressed,
    required sBoxText,
    required sBoxAmount,
    required VoidCallback sOnPressed,
    required tBoxText,
    required tBoxAmount,
    required VoidCallback tOnPressed,
  })
  {
    showModalBottomSheet(
        backgroundColor: Color(0xffD7CCC8),
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext contex, StateSetter mystate) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 9),
                        child: Divider(
                          thickness: 1.0,
                          height: 0.5,
                          indent: 10,
                          endIndent: 10,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: Text(
                        'Subscription Category',
                        style: TextStyle(
                            //color: Color(int.parse('newColor'),),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 9),
                        child: Divider(
                          thickness: 1.0,
                          height: 0.5,
                          indent: 10,
                          endIndent: 10,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: fOnPressed,
                      child: CustomCardBoxWidget(
                        boxText: fBoxText,
                        boxAmount: fBoxAmount,
                        BoxColor: [
                          Color(0xff5454f6),
                          Color(0xff09c5ec),
                          Color(0xff1ce046),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: sOnPressed,
                      child: CustomCardBoxWidget(
                        boxText: sBoxText,
                        boxAmount: sBoxAmount,
                        BoxColor: [
                          Color(0xff85f20c),
                          Color(0xffec6b09),
                          Color(0xff1ca2e0),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: tOnPressed,
                      child: CustomCardBoxWidget(
                        boxText: tBoxText,
                        boxAmount: tBoxAmount,
                        BoxColor: [
                          Color(0xff0cf268),
                          Color(0xffd0be22),
                          Color(0xff1c1fe0),
                        ],
                      ),
                    ),
                  ],
                ),
                //
                // Expanded(child: Text("You've not any subscription yet!",style: TextStyle(color: Colors.grey,fontSize: 20),),
              ],
            );
          });
        });
  }
}
_subscriptionDetailsModalBottomSheet(BuildContext contex, _purchases) {
  showModalBottomSheet(
      backgroundColor: Color(0xffD7CCC8),
      context:contex,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (BuildContext bc) {
        return StatefulBuilder(
            builder: (BuildContext contex, StateSetter mystate) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 9),
                          child: Divider(
                            thickness: 1.0,
                            height: 0.5,
                            indent: 10,
                            endIndent: 10,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.0, bottom: 8.0),
                        child: Text(
                          'Subscription Detail',
                          style: TextStyle(
                            //color: Color(int.parse('newColor'),),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 9),
                          child: Divider(
                            thickness: 1.0,
                            height: 0.5,
                            indent: 10,
                            endIndent: 10,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ],
                  ),
                 Expanded(

                      child:  GestureDetector(
                        onTap:() {
                          Navigator.pop(contex);
                        },
                        child: Container(
                        margin: EdgeInsets.only(top: 10, left: 6, right: 6),
                        child:  GridView.builder(
                          scrollDirection: Axis.vertical,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: (3 / 1),
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 10),
                          itemCount: _purchases.length,
                          itemBuilder: (context, index) {
                            return  ListTile(
                              tileColor: Colors.white30,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              leading: Icon(Icons.check, color: Colors.green),
                              title: Text(
                                _purchases[index].productID,
                                style: TextStyle(color: Colors.blue),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // ElevatedButton(onPressed: null, child: Text('Buton'))
                ],
              );
            });
      });
}

//_purchases.length == null
//                         ? Text("You've not any subscription yet!",
//                         style:
//                         TextStyle(color: Colors.grey, fontSize: 20))
//