import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocity_x/velocity_x.dart';

int currentIndex = 0;
List<String> cardImagesList = [
  "assets/images/image2.jpeg",
  "assets/images/image4.jpeg",
  "assets/images/image3.jpeg",
  "assets/images/image5.jpeg",
  "assets/images/image1.jpeg",
];

class CardAnimation extends StatefulWidget {
  const CardAnimation({super.key});

  @override
  State<CardAnimation> createState() => _CardAnimationState();
}

var cardAspectRatio = 2 / 3;
var widgetAspectRatio = cardAspectRatio * 1.55;

class _CardAnimationState extends State<CardAnimation>
    with TickerProviderStateMixin {
  var isExpanded = false;
  late double currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = cardImagesList.length - 1.0;
  }

  @override
  Widget build(BuildContext context) {
    PageController controller =
        PageController(initialPage: cardImagesList.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
        currentIndex = currentPage.toInt();
      });
    });
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            12.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Yo D! Time to Spark",
                style: TextStyle(
                    fontSize: mq.width * 0.048,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: mq.width * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Pick a card",
                style: TextStyle(
                    fontSize: mq.width * 0.044,
                    color: Colors.grey,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500),
              ),
            ),
            20.heightBox,
            Container(
              width: double.infinity,
              height: mq.height * 0.5,
              child: Stack(
                children: <Widget>[
                  CardScrollWidget(currentPage),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: cardImagesList.length,
                      physics: ScrollPhysics(),
                      controller: controller,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(right: mq.width * 0.375),
                            color: Colors.transparent,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            20.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      SvgPicture.asset(
                        "assets/icons/youtube.svg",
                        height: 20,
                      ),
                      8.widthBox,
                      Text("@funwithd",
                          style: TextStyle(
                            fontSize: mq.width * 0.045,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            // color: Colors.redAccent,
                          )),
                    ]),
                    Row(children: [
                      SvgPicture.asset(
                        "assets/icons/github.svg",
                        height: 20,
                      ),
                      8.widthBox,
                      Text("@jadhavdurgesh",
                          style: TextStyle(
                            fontSize: mq.width * 0.045,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            // color: Colors.redAccent,
                          )),
                    ]),
                    4.heightBox,
                    Row(children: [
                      SvgPicture.asset(
                        "assets/icons/linkedin.svg",
                        height: 20,
                      ),
                      8.widthBox,
                      Text("@jadhavdurgesh",
                          style: TextStyle(
                            fontSize: mq.width * 0.045,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            // color: Colors.redAccent,
                          )),
                    ]),
                    4.heightBox,
                    Row(children: [
                      SvgPicture.asset(
                        "assets/icons/instagram.svg",
                        height: 20,
                      ),
                      8.widthBox,
                      Text("@funwithd_",
                          style: TextStyle(
                            fontSize: mq.width * 0.045,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            // color: Colors.redAccent,
                          )),
                    ]),
                    Text(
                      "Follow me on Instagram @FUNWITHD for more awesome content!",
                      style: TextStyle(
                        fontSize: mq.width * 0.02,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: Colors.redAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Container(
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  "Enjoy your time with FUNWITHD!",
                  style: TextStyle(
                      fontSize: mq.width * 0.05,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 0.0;
  var verticalInset = 30.0;
  CardScrollWidget(this.currentPage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = [];

        for (var i = 0; i < cardImagesList.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 8 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: AspectRatio(
              aspectRatio: cardAspectRatio,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(cardImagesList[i], fit: BoxFit.fill),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}


// comment below your favourite card.
// follow for more interesting content ,like comment and subscribe !!!!
//tada!!!!!!!!!!