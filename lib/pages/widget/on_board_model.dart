class OnBoardModel {
  String title;
  String imageUrl;
  String description;

  OnBoardModel(
      {required this.title, required this.imageUrl, required this.description});

 static List<OnBoardModel> contentList = [
    OnBoardModel(
        title: 'Select from Our\n      Best Menu',
        imageUrl: 'images/screen1.png',
        description: 'Pick your food our menu\n         More than 35 times.'),
    OnBoardModel(
        title: 'Easy and Online Payment',
        imageUrl: 'images/screen2.png',
        description:
            'You can pay case on delivery and\n   Card payment is available'),
    OnBoardModel(
        title: '  Quick Delivery at\n      Your Doorstep',
        imageUrl: 'images/screen3.png',
        description: 'Delivery your food at your\n                     Doorstep'),
  ];
}
