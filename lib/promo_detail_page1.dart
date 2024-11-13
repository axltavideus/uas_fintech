import 'package:flutter/material.dart';

class PromoDetailPage1 extends StatelessWidget {
  const PromoDetailPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Promo 1'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Text('This is the first promo detail page.'),
      ),
    );
  }
}
