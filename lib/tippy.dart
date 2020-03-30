import 'package:flutter/material.dart';

class Tippy extends StatefulWidget {
  @override
  _TippyState createState() => _TippyState();
}

class _TippyState extends State<Tippy> {
  int _tipPercent = 10;
  int _noOfPersons = 1;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Tippy',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1.0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                color: Color(0xFF6908D6).withOpacity(0.10),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Total per person'),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '\$ ${calculateTotalPerPerson(_billAmount, _noOfPersons, _tipPercent)}',
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF6908D6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey.shade100,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                      color: Color(0xFF6908D6),
                    ),
                    decoration: InputDecoration(
                      prefixText: 'Bill Amount: ',
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (e) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Split',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                _noOfPersons > 1
                                    ? _noOfPersons--
                                    : _noOfPersons;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(7.0),
                                color: Color(0xFF6908D6).withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                    color: Color(0xFF6908D6),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '$_noOfPersons',
                            style: TextStyle(
                              color: Color(0xFF6908D6),
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _noOfPersons++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(7.0),
                                color: Color(0xFF6908D6).withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    color: Color(0xFF6908D6),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Tip',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          '\$ ${calculateTotalTip(_billAmount, _noOfPersons, _tipPercent)}',
                          style: TextStyle(
                            color: Color(0xFF6908D6),
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///Slider
                  Column(
                    children: <Widget>[
                      Text(
                        '$_tipPercent %',
                        style: TextStyle(
                          color: Color(0xFF6908D6),
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                      Slider(
                        min: 0,
                        divisions: 10,
                        inactiveColor: Colors.grey.shade400,
                        activeColor: Color(0xFF6908D6),
                        max: 100,
                        value: _tipPercent.toDouble(),
                        onChanged: (double newValue) {
                          setState(() {
                            _tipPercent = newValue.round();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculateTotalTip(double billAmt, int splitBy, int tipPercent) {
    double totalTip = 0.0;
    if (billAmt <= 0 || billAmt.toString().isEmpty || billAmt == null) {
    } else {
      totalTip = (billAmt * tipPercent) / 100;
    }
    return totalTip;
  }

  calculateTotalPerPerson(double billAmt, int splitBy, int tipPercent) {
    var totalPerPerson =
        (calculateTotalTip(billAmt, splitBy, tipPercent) + billAmt) / splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }
}
