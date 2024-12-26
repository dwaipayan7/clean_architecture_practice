import 'package:clean_architecture/features/blogs/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../../cors/theme/app_pallete.dart';

class AddNewBlog extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddNewBlog());
  const AddNewBlog({super.key});

  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  List<String> selectedTopics = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done_rounded))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DottedBorder(
                color: AppPallete.borderColor,
                dashPattern: [10, 4],
                radius: Radius.circular(10),
                borderType: BorderType.RRect,
                strokeCap: StrokeCap.round,
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_open,
                        size: 40,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Select your image",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Technology',
                    'Business',
                    'Programming',
                    'Entertainment',
                  ]
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: (){
                              if(selectedTopics.contains(e)){
                                selectedTopics.remove(e);
                              }else{
                                selectedTopics.add(e);
                              }
                              setState(() {
                                print(selectedTopics);
                              });
                            },
                            child: Chip(
                              label: Text(e),
                              color: selectedTopics.contains(e) ? const MaterialStatePropertyAll(AppPallete.gradient1) : null,
                              side: selectedTopics.contains(e) ? null : BorderSide(
                                color: AppPallete.borderColor
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 10,),
              BlogEditor(controller: _titleController, hintText: 'Blog Title'),
              SizedBox(height: 10,),
              BlogEditor(controller: _contentController, hintText: 'Blog Content'),
        
            ],
          ),
        ),
      ),
    );
  }
}
