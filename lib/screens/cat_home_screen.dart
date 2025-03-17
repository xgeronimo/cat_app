import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/cat_model.dart';
import '../services/cat_service.dart';
import '../widgets/like_button.dart';
import 'cat_detail_screen.dart';

class CatHomeScreen extends StatefulWidget {
  const CatHomeScreen({super.key});

  @override
  CatHomeScreenState createState() => CatHomeScreenState();
}

class CatHomeScreenState extends State<CatHomeScreen> {
  final CatService _catService = CatService();
  Cat? _currentCat;
  int _likeCount = 0;
  double _dragPosition = 0.0;
  double _opacity = 1.0;
  //bool _isSwiping = false;

  @override
  void initState() {
    super.initState();
    _fetchCat();
  }

  Future<void> _fetchCat() async {
    try {
      final cat = await _catService.fetchCat();
      setState(() {
        _currentCat = cat;
      });
    } catch (e) {
      //print(e);
    }
  }

  void _likeCat() {
    setState(() {
      _likeCount++;
      _fetchCat();
    });
  }

  void _dislikeCat() {
    setState(() {
      _fetchCat();
    });
  }

  void _openDetailScreen() {
    if (_currentCat != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CatDetailScreen(cat: _currentCat!),
        ),
      );
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragPosition += details.delta.dx;
      _opacity = 1.0 - (_dragPosition.abs() / 200).clamp(0.0, 1.0);
      //_isSwiping = true;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dragPosition > 100) {
      _animateSwipe(true);
    } else if (_dragPosition < -100) {
      _animateSwipe(false);
    } else {
      _resetAnimation();
    }
  }

  void _animateSwipe(bool isLike) {
    setState(() {
      _dragPosition = isLike ? 500 : -500;
      _opacity = 0.0;
    });

    Future.delayed(Duration(milliseconds: 300), () {
      if (isLike) {
        _likeCat();
      } else {
        _dislikeCat();
      }
      _resetAnimation();
    });
  }

  void _resetAnimation() {
    setState(() {
      _dragPosition = 0.0;
      _opacity = 1.0;
      //_isSwiping = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CATinder',
          style: TextStyle(
            fontFamily: 'Bowler',
            fontSize: 40,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: SizedBox(
              height: 580,
              width: 350,
              child: GestureDetector(
                onHorizontalDragUpdate: _handleDragUpdate,
                onHorizontalDragEnd: _handleDragEnd,
                onTap: _openDetailScreen,
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: Duration(milliseconds: 200),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    transform: Matrix4.translationValues(_dragPosition, 0, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: _currentCat == null
                        ? Center(child: CircularProgressIndicator())
                        : Hero(
                            tag: 'cat-image-${_currentCat!.imageUrl}',
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(
                                  color: Colors.green,
                                  width: 5.0,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: CachedNetworkImage(
                                  imageUrl: _currentCat!.imageUrl,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(_currentCat?.breedName ?? '',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Pusia',
                color: Colors.amber,
              )),
          SizedBox(height: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LikeButton(
                onPressed: _dislikeCat,
                icon: Text('😾', style: TextStyle(fontSize: 70)),
              ),
              Text(
                '$_likeCount',
                style: TextStyle(
                    fontSize: 40, fontFamily: 'Bowler', color: Colors.green),
              ),
              LikeButton(
                onPressed: _likeCat,
                icon: Text('😻', style: TextStyle(fontSize: 70)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
