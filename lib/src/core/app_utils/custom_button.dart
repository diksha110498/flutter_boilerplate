import 'export.dart';

class CustomButton extends StatelessWidget {
  String buttonText;
  Function onPressed;
  EdgeInsets ?customPadding;
  Color backgroundColor;
  bool isFilled = true;
  bool isTrailingNeeded = false;

  CustomButton(this.buttonText, this.onPressed, this.backgroundColor,
      {this.isFilled = true, this.isTrailingNeeded = false,this.customPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide(color: backgroundColor),
                borderRadius:
                    BorderRadius.circular(AppSizes.smallRoundedRadius))),
            padding: MaterialStatePropertyAll(customPadding??EdgeInsets.symmetric(
                horizontal: AppSizes.smallPadding,
                vertical: AppSizes.mediumPadding)),
            backgroundColor: MaterialStatePropertyAll(
                isFilled ? backgroundColor : Colors.white),
            elevation: MaterialStatePropertyAll(0.0)),
        onPressed: () {
          onPressed();
        },
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: Text(buttonText,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: buttonTextStyle()),
              ),
              isTrailingNeeded
                  ? Icon(Icons.check, color: Colors.white)
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  TextStyle buttonTextStyle() =>
      AppTheme.lightTheme.textTheme.labelLarge!.copyWith(
          color: isFilled ? Colors.white : Colors.black,
          fontWeight: !isFilled ? FontWeight.w500 : FontWeight.w600);
}
