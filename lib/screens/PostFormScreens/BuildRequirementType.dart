import 'package:flutter/material.dart';
import 'package:helpinghandsversion2/constants/customColor.dart';
import 'package:helpinghandsversion2/notifiers/postFormValidator.dart';
import 'package:provider/provider.dart';

class BuildRequiementType extends StatefulWidget {
  const BuildRequiementType({
    Key? key,
  }) : super(key: key);

  @override
  _BuildRequiementTypeState createState() => _BuildRequiementTypeState();
}

class _BuildRequiementTypeState extends State<BuildRequiementType> {
  Map<String, String> _types = {
    'Blood': "Require \nBlood",
    'Plasma': "Require \nPlasma",
    'Platelets': "Require \nPlatelets",
  };
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(child: Consumer<PostFormProvider>(
        builder: (context, postFormValidator, child) {
          return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          )),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          (postFormValidator.postFormValidatorModel
                                      .requirementType.value ==
                                  _types.keys.first.toLowerCase()
                              ? CustomColors.red
                              : CustomColors.grey),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: FittedBox(
                        child: Text(
                          _types.values.first,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () {
                      postFormValidator.validateRequirementType(
                          _types.keys.elementAt(0).toLowerCase());
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                      backgroundColor: MaterialStateProperty.all(
                          postFormValidator.postFormValidatorModel
                                      .requirementType.value ==
                                  _types.keys.elementAt(1).toLowerCase()
                              ? CustomColors.red
                              : CustomColors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FittedBox(
                        child: Text(
                          _types.values.elementAt(1),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () {
                      postFormValidator.validateRequirementType(
                          _types.keys.elementAt(1).toLowerCase());
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: ElevatedButton(
                    onPressed: () {
                      postFormValidator.validateRequirementType(
                          _types.keys.elementAt(2).toLowerCase());
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          (postFormValidator.postFormValidatorModel
                                      .requirementType.value ==
                                  _types.keys.elementAt(2).toLowerCase()
                              ? CustomColors.red
                              : CustomColors.grey),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FittedBox(
                          child: Text(
                        _types.values.elementAt(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ),
              ]);
        },
      )),
    );
  }
}
