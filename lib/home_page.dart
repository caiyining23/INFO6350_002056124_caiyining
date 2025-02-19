import 'package:flutter/material.dart';
import 'widgets/image_section.dart';
import 'widgets/title_section.dart';
import 'widgets/button_section.dart';
import 'widgets/text_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Layout Demo')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ImageSection(image: 'images/lake.jpg'),
            const TitleSection(
              name: 'Oeschinen Lake Campground',
              location: 'Kandersteg, Switzerland',
            ),
            const ButtonSection(),
            const TextSection(
              description:
              'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. '
                  'Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. '
                  'A gondola ride from Kandersteg, followed by a half-hour walk through pastures '
                  'and pine forest, leads you to the lake, which warms to 20 degrees Celsius in '
                  'the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.',
            ),
          ],
        ),
      ),
    );
  }
}
