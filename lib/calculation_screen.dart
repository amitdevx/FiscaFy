import 'package:flutter/material.dart';

class CalculationScreen extends StatefulWidget {
  const CalculationScreen({
    super.key,
    required this.totalAmount,
    required this.budget,
    required this.inputText,
    required this.avlBlnc,
  });

  final double totalAmount;
  final VoidCallback budget;
  final String inputText;
  final double avlBlnc;

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SingleChildScrollView(
        child: Column(
          children: [
            if (width < 600)
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(0, 255, 255, 255)),
                      height: 220,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(80),
                          bottomRight: Radius.circular(80),
                        ),
                        color: const Color.fromARGB(255, 0, 39, 103),
                      ),
                      height: 130,
                    ),
                    Positioned(
                      top: 40,
                      left: 12,
                      right: 12,
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.black26,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Container(
                                      height: 60,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(45),
                                        color: Colors.transparent,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Spend',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              '\u20B9 ${widget.totalAmount}',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: VerticalDivider(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      thickness: 2,
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: InkWell(
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      overlayColor: WidgetStatePropertyAll(
                                          Colors.transparent),
                                      onTap: widget.budget,
                                      child: Container(
                                        height: 60,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(45),
                                          color: Colors.transparent,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Budget',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                '\u20B9 ${widget.inputText}',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 40, 151, 21),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              if (widget.avlBlnc < 0)
                                Text(
                                  'Available Balance : \u20B9 0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              else
                                Text(
                                  'Available Balance : \u20B9 ${widget.avlBlnc}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            else
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(0, 14, 12, 12)),
                      height: 230,
                    ),
                    Positioned(
                      top: 40,
                      left: 12,
                      right: 12,
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.black26,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Container(
                                      height: 60,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(45),
                                        color: Colors.transparent,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Spend',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              '\u20B9 ${widget.totalAmount}',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 255, 17, 0),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: VerticalDivider(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      thickness: 2,
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: InkWell(
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      overlayColor: WidgetStatePropertyAll(
                                          Colors.transparent),
                                      onTap: widget.budget,
                                      child: Container(
                                        height: 60,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(45),
                                          color: Colors.transparent,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Budget',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                '\u20B9 ${widget.inputText}',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 40, 151, 21),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              if (widget.avlBlnc <= 0)
                                Text(
                                  'Available Balance : \u20B9 0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              else
                                Text(
                                  'Available Balance : \u20B9 ${widget.avlBlnc}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      );
    });
  }
}
