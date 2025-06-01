// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybooks/feature/books/presentation/bloc/bloc/book_bloc.dart';
import 'package:mybooks/feature/books/presentation/widgets/add_or_edit.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  void initState() {
    context.read<BookBloc>().add(GetBooksEvent());
    print("booklist");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Books",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => AddOrEdit(apptitle: 'Add Book'),
                  ),
                );
              },
              icon: Icon(Icons.add, size: 30),
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<BookBloc>().add(GetBooksEvent());
            },
            icon: Icon(Icons.refresh, size: 30),
          ),
        ],
      ),

      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookLoaded) {
            return ListView.builder(
              itemCount: state.booklist.length,
              itemBuilder: (context, index) {
                final book = state.booklist[index];
                print("covver Imagesss ${book.coverImage}");
                return ListTile(
                  leading: book.coverImage.isNotEmpty
                      ? Image.network(
                          book.coverImage,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey,
                            );
                          },
                        )
                      : Text('no Images'),
                  title: Text(
                    book.title.trim(),
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),

                  subtitle: Text(book.authors.join(", ")),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => AddOrEdit(
                                apptitle: 'Edit Book',
                                booktitle: book.title.trim(),
                                author: book.authors.join(", "),
                                id: book.id,
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // handle delete

                          DeleteDialog(id: book.id, context: context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is BookError) {
            return const Center(child: Text("Error loading books"));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Future<void> DeleteDialog({
    required String id,
    required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Delete Book",
            style: TextStyle(
              fontSize: 25,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this book from your collection?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 50),
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<BookBloc>().add(DeleteBookEvent(id));
                Navigator.pop(context);
                // Close dialog immediately
                context.read<BookBloc>().add(GetBooksEvent());
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 50),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
