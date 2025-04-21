import 'package:flutter/material.dart';
import 'post.dart';

class PostDetailActivity extends StatelessWidget {
  final Post post;

  const PostDetailActivity({super.key, required this.post});

  void _showFullImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(backgroundColor: Colors.black),
          backgroundColor: Colors.black,
          body: Center(
            child: InteractiveViewer(
              child: Image.network(imageUrl),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(post.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('\$${post.price}',
                style: const TextStyle(fontSize: 18, color: Colors.blueAccent)),
            const SizedBox(height: 8),
            Text(post.description,
                style: const TextStyle(fontSize: 16, height: 1.4)),
            const SizedBox(height: 16),
            if (post.imageUrls.isNotEmpty) ...[
              const Text('Images:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: post.imageUrls.map((url) {
                  return GestureDetector(
                    onTap: () => _showFullImage(context, url),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        url,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
