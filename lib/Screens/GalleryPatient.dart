import 'package:flutter/material.dart';

List<ImageDetails> _images = [
  ImageDetails(
    imagePath: 'assets/images/1.jpg',
  ),
  ImageDetails(
    imagePath: 'assets/images/1.jpg',
  ),
  ImageDetails(
    imagePath: 'assets/images/1.jpg',
  ),
  ImageDetails(
    imagePath: 'assets/images/1.jpg',
  ),
  ImageDetails(
    imagePath: 'assets/images/1.jpg',
  ),
  ImageDetails(
    imagePath: 'assets/images/1.jpg',
  ),
  ImageDetails(
    imagePath: 'assets/images/1.jpg',
  ),
  ImageDetails(
    imagePath: 'assets/images/1.jpg',
  ),
  ImageDetails(
    imagePath: 'assets/images/1.jpg',
  ),

];

class GalleryPatient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF90CAF9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              'Gallery Patient',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return RawMaterialButton(
                      onPressed: () {  },
                      child: Hero(
                        tag: 'logo$index',
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(_images[index].imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _images.length,
              ),
            ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageDetails {
  final String imagePath;

  ImageDetails({
    required this.imagePath,
});
}