import 'package:flutter/material.dart';
import 'radial_expansion.dart';

/// Main Radial Hero Animation screen with multiple images.
class RadialHeroAnimation extends StatelessWidget {
  const RadialHeroAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Hero Animation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (context) => const RadialHeroSecondPage(),
                ));
              },
              child: Hero(
                tag: 'hero-radial-1',
                createRectTween: createRectTween,
                child: RadialExpansion(
                  maxRadius: 100.0,
                  child: Image.asset('assets/images/radial-image1.png'),
                ),
              ),
            ),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (context) => const RadialHeroThirdPage(),
                ));
              },
              child: Hero(
                tag: 'hero-radial-2',
                createRectTween: createRectTween,
                child: RadialExpansion(
                  maxRadius: 100.0,
                  child: Image.asset('assets/images/radial-image2.png'),
                ),
              ),
            ),
            const SizedBox(height: 20),

            ///  Add the third image with a new Hero tag
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (context) => const RadialHeroFourthPage(),
                ));
              },
              child: Hero(
                tag: 'hero-radial-3', //  Make sure this tag is unique
                createRectTween: createRectTween,
                child: RadialExpansion(
                  maxRadius: 100.0,
                  child: Image.asset('assets/images/radial-image3.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Second screen
class RadialHeroSecondPage extends StatelessWidget {
  const RadialHeroSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Hero - Second Page'),
      ),
      body: Center(
        child: Hero(
          tag: 'hero-radial-1',
          createRectTween: createRectTween,
          child: RadialExpansion(
            maxRadius: 300.0,
            child: Image.asset('assets/images/radial-image1.png'),
          ),
        ),
      ),
    );
  }
}

/// Third screen
class RadialHeroThirdPage extends StatelessWidget {
  const RadialHeroThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Hero - Third Page'),
      ),
      body: Center(
        child: Hero(
          tag: 'hero-radial-2',
          createRectTween: createRectTween,
          child: RadialExpansion(
            maxRadius: 300.0,
            child: Image.asset('assets/images/radial-image2.png'),
          ),
        ),
      ),
    );
  }
}

///  Fourth screen for the third image
class RadialHeroFourthPage extends StatelessWidget {
  const RadialHeroFourthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Hero - Fourth Page'),
      ),
      body: Center(
        child: Hero(
          tag: 'hero-radial-3',
          createRectTween: createRectTween,
          child: RadialExpansion(
            maxRadius: 300.0,
            child: Image.asset('assets/images/radial-image3.png'),
          ),
        ),
      ),
    );
  }
}
