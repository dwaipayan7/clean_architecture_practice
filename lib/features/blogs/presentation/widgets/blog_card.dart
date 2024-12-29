import 'package:flutter/material.dart';

import '../../domain/entities/blog.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: blog.topics
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Chip(label: Text(e)),
                        ),
                      )
                      .toList(),
                ),
              ),
              Text(blog.title, style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),),
            ],

          ),



          Text("1 min"),
        ],
      ),
    );
  }
}
