import 'package:expense/model/category_model.dart';

class AppConstant{
 static List<catModel> mCat=[
    //catModel(Category_img: Category_img, Category_name: Category_name, CatId: CatId)
    catModel(CatId: 1, Category_name:"Restaurant", Category_img: "assets/icons/restaurent.png"),
   catModel(CatId: 2, Category_name: "Fast Food", Category_img: "assets/icons/fast_food.png"),
   //catModel(CatId: 3, Category_name: "Fuel", Category_img:"assets/icons/img.png "),
   catModel(CatId: 3, Category_name: "Rent", Category_img: "assets/icons/rent.png"),
   catModel(CatId: 4, Category_name: "Recharge", Category_img: "assets/icons/mobile_recharge.png"),
   catModel(CatId: 5, Category_name: "Mobile Transfer", Category_img:"assets/icons/mobile_transfer.png"),
   catModel(CatId: 6, Category_name: "Shopping", Category_img: "assets/icons/shopping.png"),
   catModel(CatId: 7, Category_name: "Education fee", Category_img: "assets/icons/education_fee.png"),
   catModel(CatId: 8, Category_name: "Coffee", Category_img: "assets/icons/coffee.png"),
   catModel(CatId: 9, Category_name: "Service", Category_img: "assets/icons/service.png"),

  ];
}