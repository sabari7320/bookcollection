// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybooks/feature/books/presentation/bloc/bloc/book_bloc.dart';

class AddOrEdit extends StatefulWidget {
  final String apptitle;
  final String? booktitle;
  final String? author;
  final String? id;

  const AddOrEdit({
    required this.apptitle,
    this.booktitle,
    this.author,
    this.id,
  });

  @override
  State<AddOrEdit> createState() => _AddOrEditState();
}

class _AddOrEditState extends State<AddOrEdit> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController book_titleController;
  late TextEditingController authorController;

  @override
  void initState() {
    super.initState();
    book_titleController = TextEditingController(text: widget.booktitle ?? '');
    authorController = TextEditingController(text: widget.author ?? '');
  }

  @override
  void dispose() {
    book_titleController.dispose();
    authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.booktitle != null && widget.author != null;

    return BlocListener<BookBloc, BookState>(
      listener: (context, state) {
        if (state is BookLoaded) {
          Navigator.pop(context); // Navigate back on success
        } else if (state is BookError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              context.read<BookBloc>().add(GetBooksEvent());
            },
          ),
          title: Text(
            widget.apptitle, //add_or_edit title
            style: const TextStyle(fontSize: 25, color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 10,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Title",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                TextFormField(
                  controller: book_titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter book title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Book Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Author",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                TextFormField(
                  controller: authorController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter author name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Book Author Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<BookBloc, BookState>(
                  builder: (context, state) {
                    final isLoading = state is BookLoading;
                    return ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                if (isEditing) {
                                  context.read<BookBloc>().add(
                                    EditBookEvent(
                                      id: widget.id ?? "",
                                      title: book_titleController.text.trim(),
                                      authors: [authorController.text.trim()],
                                      coverImage: "",
                                    ),
                                  );
                                } else {
                                  context.read<BookBloc>().add(
                                    AddBookEvent(
                                      title: book_titleController.text.trim(),
                                      authors: [authorController.text.trim()],
                                      coverImage: "",
                                    ),
                                  );
                                }
                              }
                            },
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(isEditing ? "Update Book" : "Add Book"),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(double.maxFinite, 50),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
