import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/pages/edit_note_page.dart';

class NoteItemWidget extends StatelessWidget {
  const NoteItemWidget({super.key, required this.note});
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(note.key.toString()), // Ensure unique key
      direction:
          DismissDirection.horizontal, // Allow both left and right swipes
      background: _buildSwipeActionRight(), // Show "Delete" on right swipe
      secondaryBackground: _buildSwipeActionLeft(), // Show "Edit" on left swipe
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Right swipe: Show confirmation before deleting
          return await _showConfirmDeleteDialog(context);
        } else if (direction == DismissDirection.endToStart) {
          // Left swipe: Edit action, but don't dismiss
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditNotePage(note: note),
            ),
          );
          return false; // Prevent the widget from being dismissed
        }
        return false;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          // Perform deletion if confirmed
          note.delete();
          BlocProvider.of<NotesCubit>(context).getNotes();
        }
      },
      child: _buildNoteContent(context),
    );
  }

  // Method to build note content for the ListTile
  Widget _buildNoteContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text(
              note.title,
              style: GoogleFonts.poppins(fontSize: 25),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                note.content,
                style: GoogleFonts.poppins(
                    fontSize: 20, color: Colors.black.withOpacity(0.6)),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNotePage(note: note),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 35,
                      color: Colors.black.withOpacity(0.6),
                    )),
                IconButton(
                  onPressed: () async {
                    bool? isDeleted = await _showConfirmDeleteDialog(context);
                    if (isDeleted != null && isDeleted == true) {
                      note.delete();
                    }
                    BlocProvider.of<NotesCubit>(context).getNotes();
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 35,
                    color: Colors.black.withOpacity(0.5).withRed(230),
                  ),
                ),
              ],
            ),
            isThreeLine: true,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8),
            child: Text(
              note.date,
              style: GoogleFonts.poppins(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  // Swipe action for "Delete" when swiping right
  Widget _buildSwipeActionRight() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Icon(Icons.delete, color: Colors.white, size: 30),
          const SizedBox(width: 8),
          Text(
            "Delete",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Swipe action for "Edit" when swiping left
  Widget _buildSwipeActionLeft() {
    return Container(
      color: Colors.green,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Edit",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.edit, color: Colors.white, size: 30),
        ],
      ),
    );
  }

  // Confirmation dialog for deleting
  Future<bool?> _showConfirmDeleteDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Note',
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Are you sure you want to delete this note?',
            style: GoogleFonts.poppins(fontSize: 22),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel deletion
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(fontSize: 22),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm deletion
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.red,
                ),
                child: Text(
                  'Delete',
                  style: GoogleFonts.poppins(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
