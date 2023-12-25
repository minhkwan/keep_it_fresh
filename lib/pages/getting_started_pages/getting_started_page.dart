import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep_it_fresh/lib.dart';

class GettingStartedPage extends StatefulWidget {
  const GettingStartedPage({super.key});

  @override
  State<GettingStartedPage> createState() => _GettingStartedPageState();
}

class _GettingStartedPageState extends State<GettingStartedPage> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF46DE99) : const Color(0xFFC4C4C4),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 660.w,
              child: PageView(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: <Widget>[
                  onBoardingScreen(
                    Assets.images.imgOnboarding1.path,
                    'Choose Your Favorite Drink',
                    'Find your favorite drink anytime from your existing location easily',
                  ),
                  onBoardingScreen(
                    Assets.images.imgOnboarding2.path,
                    'Choose Your Favorite Drink',
                    'Find your favorite drink anytime from your existing location easily',
                  ),
                  onBoardingScreen(
                    Assets.images.imgOnboarding3.path,
                    'Choose Your Favorite Drink',
                    'Find your favorite drink anytime from your existing location easily',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
            _currentPage != _numPages - 1
                ? Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: const Color(0xFF46DE99),
                        ),
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    ),
                  )
                : const Text(''),
          ],
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Padding(
              padding: const EdgeInsets.only(bottom: 30.0, left: 30, right: 30),
              child: SizedBox(
                height: 50.0,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF46DE99)),
                  onPressed: () => print('Get started'),
                  child: const Center(
                    child: CommonText(
                      'Get started',
                      fontStyle: FontStyle.bold,
                      variant: Variant.h5,
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          : const Text(''),
    );
  }

  Widget onBoardingScreen(String image, String title, String description) {
    return Column(
      children: [
        Container(
          color: const Color(0x0ff6fff6),
          width: double.infinity,
          child: Image(
            image: AssetImage(
              image,
            ),
            fit: BoxFit.contain,
          ),
        ),
        CommonText(
          title,
          textColor: Colors.black,
          fontStyle: FontStyle.bold,
        ),
        const SizedBox(height: 15.0),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: CommonText(
            description,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
