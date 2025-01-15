class OnBoardModel {
  String title;
  String imageUrl;
  String description;

  OnBoardModel(
      {required this.title, required this.imageUrl, required this.description});

 static List<OnBoardModel> contentList = [
    OnBoardModel(
        title: 'Select from Our\n      Best Menu',
        imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/006/800/452/small/order-on-hold-illustration-exclusive-design-inspiration-vector.jpg',
        description: 'Pick your food our menu\n         More than 35 times.'),
    OnBoardModel(
        title: 'Easy and Online Payment',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYFDGrdupyKNoBYOf8pfOj1U7sleZw8N3PZuq76nsPBZUmgsAxDzuTu4TFmBX8dFhWabs&usqp=CAU',
        description:
            'You can pay case on delivery and\n   Card payment is available'),
    OnBoardModel(
        title: '  Quick Delivery at\n      Your Doorstep',
        imageUrl: 'https://static.vecteezy.com/system/resources/previews/002/072/442/non_2x/man-delivered-goods-to-woman-through-mobile-smartphone-free-vector.jpg',
        description: 'Delivery your food at your\n                     Doorstep'),
  ];
}
