import 'package:flutter/material.dart';
import 'package:medrep_pro/features/products/domain/entities/product.dart';

class PdfVisualAidView extends StatefulWidget {
  final Product product;

  const PdfVisualAidView({super.key, required this.product});

  @override
  State<PdfVisualAidView> createState() => _PdfVisualAidViewState();
}

class _PdfVisualAidViewState extends State<PdfVisualAidView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Generate beautiful scientific mock slide pages for the product
    final slides = [
      _SlideData(
        title: '${widget.product.name} - Scientific Presentation',
        subtitle: 'Product Overview & Efficacy Data',
        content: 'Welcome to the clinical presentation for ${widget.product.name}. Under the SKU (${widget.product.sku}), this formula targets premium therapeutic indicators with high patient safety margins.',
        stats: '99.4% Purity Level • FDA Standard Grade',
        color: Colors.teal.shade800,
      ),
      _SlideData(
        title: 'Clinical Efficacy & Trials',
        subtitle: 'Comparative Study vs. Standard Remedies',
        content: 'Recent double-blind trials demonstrate that ${widget.product.name} yields a 34% faster onset of relief compared to traditional medication courses. Consistent bio-availability is observed across diverse patient demographics.',
        stats: '87% Patient Improvement within 7 Days',
        color: Colors.indigo.shade800,
      ),
      _SlideData(
        title: 'Recommended Dosage & Administration',
        subtitle: 'Safety Protocols & Prescription Standards',
        content: 'Standard administration is 1 tablet twice daily after food. For patients in critical care categories, doses should be titrated in compliance with standard clinical advisory panels.',
        stats: 'Zero Adverse Side Effects Logged in Phase III',
        color: Colors.purple.shade800,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        title: Text('${widget.product.name} - E-Detailing Aid'),
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Zoom mode activated')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('PDF Aid shared with physician')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: slides.length,
              itemBuilder: (context, index) {
                final slide = slides[index];
                return Center(
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 500),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(80),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: [
                          Container(
                            height: 120,
                            width: double.infinity,
                            color: slide.color,
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  slide.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  slide.subtitle,
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      slide.content,
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.6,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: slide.color.withAlpha(30),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      slide.stats,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: slide.color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.black87,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: _currentPage > 0
                      ? () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                ),
                Text(
                  'Slide ${_currentPage + 1} of ${slides.length}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onPressed: _currentPage < slides.length - 1
                      ? () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SlideData {
  final String title;
  final String subtitle;
  final String content;
  final String stats;
  final Color color;

  _SlideData({
    required this.title,
    required this.subtitle,
    required this.content,
    required this.stats,
    required this.color,
  });
}
