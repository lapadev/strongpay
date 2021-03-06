import 'package:flutter/material.dart';
import 'package:strongpay/models/coin_model.dart';

import '../../../../models/transaction_model.dart';
import 'widgets/coin_balance_widget.dart';
import 'widgets/transaction_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///static coin model
  static final CoinModel coinModel = CoinModel(
      image: Image.asset("images/ic_stronghands_small.png"),
      name: 'StrongHands',
      priceInDollar: 0.00033,
      princeInBTC: 0.0000004);
  final CoinModel coinModelMN = CoinModel(
      image: Image.asset("images/ic_masternode_small.png"),
      name: 'StrongHands Master Node',
      priceInDollar: 0.00033,
      princeInBTC: 0.0000004);

  List<TransactionModel> _transactionsList = [
//    TransactionModel(
//        coin: coinModel,
//        timestamp: 100000,
//        amount: 20,
//        transactionType: TransactionType.SEND)
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
//                            Colors.black,
                        Color(0xff212121),
                        Color(0xff212830),
//                            Color(0xff565539),
                      ])),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 25, left: 15),
                        child: Text(
                          "Total Balance",
                          style: TextStyle(fontSize: 22, color: Colors.grey),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Text(
                          "\$ 0,00",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                CoinBalanceWidget(
                  coinModel: coinModel,
                ),
                CoinBalanceWidget(
                  coinModel: coinModelMN,
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Transactions',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                _transactionsList.length > 0
                    ? Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Coin'),
                            Text('Amount'),
                            Text('Date'),
                          ],
                        ),
                      )
                    : Container(),
                _transactionsList.length > 0
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: _transactionsList.length,
                          itemBuilder: (context, index) {
                            return TransactionWidget(
                                transaction: _transactionsList[index]);
                          },
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 100),
                        width: MediaQuery.of(context).size.width,
                        child: Text("No transactions records :(",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                            textAlign: TextAlign.center),
                      )
              ],
            ))
      ],
    );
  }
}
