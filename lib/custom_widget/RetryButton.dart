import 'package:flutter/material.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/Button.dart';

class RetryButton extends StatelessWidget {
  const RetryButton({
    Key? key, required this.onTap
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Button(
      width: 82, 
      height: 40, 
      onTap: (){
        this.onTap();
      }, 
      padding: EdgeInsets.all(4),
      borderRadius: BorderRadius.circular(50),
      color: ApplicationColor.blackHint.withOpacity(0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("retry", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: ApplicationColor.blackHint),),
        Icon(Icons.replay_outlined, size: 18,color: ApplicationColor.blackHint,),
      ],
    ));
  }
}
