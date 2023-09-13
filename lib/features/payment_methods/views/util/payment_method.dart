class PaymentMethod {
  String icon;
  String label;
  String discription;
  List<String> methodImages;
  void Function()? onTap;
  bool isSelected;

  PaymentMethod(
      {this.icon = "",
      this.label= "",
      this.discription= "",
      this.methodImages = const [],
      this.onTap,
      this.isSelected = false});
}