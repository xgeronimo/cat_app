import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/cat_model.dart';

class CatDetailScreen extends StatefulWidget {
  final Cat cat;

  const CatDetailScreen({super.key, required this.cat});

  @override
  CatDetailScreenState createState() => CatDetailScreenState();
}

class CatDetailScreenState extends State<CatDetailScreen> {
  double _dragPosition = 0.0;

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragPosition += details.delta.dx;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dragPosition > 100) {
      Navigator.pop(context);
    } else {
      setState(() {
        _dragPosition = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.cat.breedName,
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Pusia',
            color: Colors.amber,
          ),
        ),
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: _handleDragUpdate,
        onHorizontalDragEnd: _handleDragEnd,
        child: Transform.translate(
          offset: Offset(_dragPosition, 0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'cat-image-${widget.cat.imageUrl}',
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(
                          color: Colors.green,
                          width: 5.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: CachedNetworkImage(
                          imageUrl: widget.cat.imageUrl,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (widget.cat.temperament != null) ...[
                    Text(
                      'Temperament:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pusia'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.cat.temperament!,
                      style: TextStyle(fontSize: 18, fontFamily: 'Pusia'),
                    ),
                    SizedBox(height: 20),
                  ],
                  if (widget.cat.origin != null) ...[
                    Text(
                      'Origin:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pusia'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.cat.origin!,
                      style: TextStyle(fontSize: 18, fontFamily: 'Pusia'),
                    ),
                    SizedBox(height: 20),
                  ],
                  if (widget.cat.description != null) ...[
                    Text(
                      'Description:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pusia'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.cat.description!,
                      style: TextStyle(fontSize: 18, fontFamily: 'Pusia'),
                    ),
                    SizedBox(height: 20),
                  ],
                  if (widget.cat.lifeSpan != null) ...[
                    Text(
                      'Life Span:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pusia'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.cat.lifeSpan!,
                      style: TextStyle(fontSize: 18, fontFamily: 'Pusia'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
