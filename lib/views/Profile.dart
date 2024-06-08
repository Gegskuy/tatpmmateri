import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tatpmmobil/widgets/style.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 30.0),
          Text(
            'Gega Rakanatha', style: TextStyles.title.copyWith(fontSize: 24.0),
          ),
          SizedBox(height: 8.0),
          Text(
            '123210136', style: TextStyles.body,
          ),
          SizedBox(height: 18.0),
          Text(
            'Timothea Ruth', style: TextStyles.title.copyWith(fontSize: 24.0),
          ),
          SizedBox(height: 8.0),
          Text(
            '123210121', style: TextStyles.body,
          )
        ],
      ),
    );
  }
}
