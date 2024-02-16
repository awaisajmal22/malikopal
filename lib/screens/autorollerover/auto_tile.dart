import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../ScopedModelWrapper.dart';

class AutoRollTile extends StatelessWidget {
  //

  AutoRollTile(
      {Key? key,
      required this.onPress,
      required this.titleText,
      required this.subTitle,
      required this.textNum,
      required this.isSelected})
      : super(key: key);

  Function onPress;
  String textNum;
  String titleText;
  String subTitle;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    AppModel model = ScopedModel.of<AppModel>(context);
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(top: 20),
      shadowColor: Color(0xff01010126).withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        enableFeedback: false,
        splashColor: Colors.transparent,
        onTap: () {
          onPress();
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Icon(
                isSelected ? Icons.circle : Icons.circle_outlined,
                color: isSelected ? Color(0xff912C8C) : Color(0xffA6A7AA),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                textNum,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff912C8C)),
              ),
              SizedBox(
                width: 14,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upcoming Closing",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: model.isDarkTheme
                            ? Colors.white
                            : Color(0xff606161)),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color:
                          model.isDarkTheme ? Colors.black : Color(0xff912C8C),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
