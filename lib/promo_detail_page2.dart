import 'package:flutter/material.dart';

class PromoDetailPage2 extends StatelessWidget {
  const PromoDetailPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Promo 2'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Text('This is the second promo detail page.'),
      ),
    );
  }
}
