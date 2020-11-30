import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/movie_image.dart';

class ImagePager extends StatelessWidget {
  final List<MovieImage> images;

  const ImagePager({
    Key key,
    this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 216,
      child: PageView.builder(
        itemCount: images?.length ?? 0,
        itemBuilder: _buildImagePage,
      ),
    );
  }

  Widget _buildImagePage(BuildContext context, int index) {
    return Image.network(
      images[index].url,
      fit: BoxFit.cover,
    );
  }
}
