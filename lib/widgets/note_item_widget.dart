import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/pages/edit_note_page.dart';

class NoteItemWidget extends StatelessWidget {
  const NoteItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.lightBlue, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text(
              "Flutter Tips",
              style: GoogleFonts.poppins(fontSize: 30),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "Learn how to use Flutter",
                style: GoogleFonts.poppins(
                    fontSize: 19, color: Colors.black.withOpacity(0.6)),
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
                              builder: (context) => EditNotePage()));
                    },
                    icon: Icon(Icons.edit,
                        size: 35, color: Colors.black.withOpacity(0.6))),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      size: 35,
                      color: Colors.black.withOpacity(0.5).withRed(230),
                    )),
              ],
            ),
            isThreeLine: true,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "1 May 2024",
              style: GoogleFonts.poppins(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
