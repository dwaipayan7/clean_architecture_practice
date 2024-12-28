import 'package:clean_architecture/cors/theme/app_pallete.dart';
import 'package:clean_architecture/features/blogs/presentation/pages/add_new_blog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => BlogPage());
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blogs App"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, AddNewBlogPage.route());
              },
              icon: Icon(CupertinoIcons.add_circled)
          )
        ],
      ),
      body:Container()
    );
  }
}
