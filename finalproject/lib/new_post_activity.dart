import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewPostActivity extends StatefulWidget {
  @override
  _NewPostActivityState createState() => _NewPostActivityState();
}

class _NewPostActivityState extends State<NewPostActivity> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile> _images = [];

  Future<void> _pickImage() async {
    if (_images.length >= 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Max 4 images allowed')),
      );
      return;
    }
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _images.add(picked);
      });
    }
  }

  Future<List<String>> uploadImages(List<XFile> images) async {
    List<String> downloadUrls = [];
    for (var image in images) {
      final file = File(image.path);
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = FirebaseStorage.instance.ref().child("posts/$fileName.jpg");
      final task = await ref.putFile(file);
      final url = await task.ref.getDownloadURL();
      downloadUrls.add(url);
    }
    return downloadUrls;
  }

  void _submitPost() async {
    final title = _titleController.text.trim();
    final price = _priceController.text.trim();
    final desc = _descController.text.trim();

    if (title.isEmpty || price.isEmpty || desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final imageUrls = await uploadImages(_images);

      await FirebaseFirestore.instance.collection('posts').add({
        'title': title,
        'price': price,
        'description': desc,
        'images': imageUrls,
        'created_at': Timestamp.now(),
      });

      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Images (max 4):",
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              const SizedBox(height: 8),
              GridView.builder(
                itemCount: _images.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                ),
                itemBuilder: (context, index) {
                  return Image.file(
                    File(_images[index].path),
                    fit: BoxFit.cover,
                  );
                },
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.add_a_photo),
                label: const Text("Add Image"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitPost,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Post', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
