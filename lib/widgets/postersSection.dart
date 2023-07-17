import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/screens/movieAbout.dart';
import 'package:flutter_movie/utils/text.dart';
import 'package:dots_indicator/dots_indicator.dart';

class PosterSection extends StatefulWidget {
  const PosterSection({Key? key, required this.movies}) : super(key: key);

  final List movies;

  @override
  State<PosterSection> createState() => PosterSectionState();
}

class PosterSectionState extends State<PosterSection>{
  PageController _pageController = PageController(viewportFraction: 0.85);
  
  double _currentPageValue = 0;
  final double _height = 300;
  final double _scaleChange = 0.8;

  String _movieDescription = '';

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return(
      Column(
        children: <Widget>[
          Container(
            height: 450,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.movies == null ? 0 : (widget.movies.length<=7 ? widget.movies.length : 7),
              itemBuilder:(context, index) {
                return _trendingItemsWidget(index);
              },  
            ),
          ),
          const SizedBox(height: 10,),
          DotsIndicator(
            dotsCount: 7,
            position: _currentPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeColor: CupertinoColors.activeOrange,
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            )
          )
        ],
      )
    );
  }


  Widget _trendingItemsWidget(int index){
    _movieDescription = widget.movies[index]['overview'];
    
    Matrix4 matrix = Matrix4.identity();
    double currentScale = 0.8;
    double currentTransform = 0.8;

    if(index == _currentPageValue.floor()){
      currentScale = 1 - (_currentPageValue - index) * (1 - _scaleChange);
    }
    else if (index == _currentPageValue.floor() + 1) {
      currentScale = _scaleChange + (_currentPageValue - index+1) * (1 - _scaleChange);
    } 
    else if (index == _currentPageValue.floor() - 1) {
      currentScale = 1 - (_currentPageValue - index) * (1 - _scaleChange);
    } 
    currentTransform = _height * (1 - currentScale) / 2;
    matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTransform, 0);
    
    return(
      Transform(
        transform: matrix,
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: 
              (context) => MovieAbout(movie: widget.movies[index],)));
          },
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(16),
            height: 450,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: NetworkImage('https://image.tmdb.org/t/p/w500' + widget.movies[index]['backdrop_path']),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black26,
                  BlendMode.darken
                )
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Container(
                  height: 25,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: CupertinoColors.systemOrange
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(CupertinoIcons.star_fill, color: Colors.white, size: 13,),
                      SizedBox(width: 4,),
                      ModifiedText(
                        text: (widget.movies[index]['vote_average']).toStringAsFixed(1), 
                        size: 12, 
                        color: Colors.white, 
                        fontWeight: FontWeight.bold,)
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                ModifiedText(
                  text: widget.movies[index]['title'] != null ? widget.movies[index]['title']: (widget.movies[index]['name']!=null ? widget.movies[index]['name'] : 'Loading'), 
                  size: 22, fontWeight: 
                  FontWeight.bold,),
                const SizedBox(height: 10,),
                ModifiedText(
                  text: _movieDescription.length > 100? '${_movieDescription.substring(0, 100)}...': _movieDescription, 
                  size: 12,),
              ],
            ),
          ),
        )
      )
    );
  }
}


