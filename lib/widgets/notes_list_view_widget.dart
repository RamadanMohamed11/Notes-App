import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_app/cubits/notes_cubit/add_notes_states.dart';
import 'package:notes_app/widgets/note_item_widget.dart';

class NotesListViewWidget extends StatelessWidget {
  const NotesListViewWidget({super.key, this.searchText, this.isFound});
  final String? searchText;
  final bool? isFound;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return searchText != null
            ? (isFound!
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        BlocProvider.of<NotesCubit>(context).notes.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (searchText!.toLowerCase() ==
                          BlocProvider.of<NotesCubit>(context)
                              .notes[index]
                              .title
                              .toLowerCase()) {
                        return NoteItemWidget(
                          note:
                              BlocProvider.of<NotesCubit>(context).notes[index],
                        );
                      }
                      return const SizedBox();
                    },
                  )
                : Center(
                    child: Text(
                      "Not Found",
                      style: GoogleFonts.poppins(
                          fontSize: 35, color: Colors.lightBlue),
                    ),
                  ))
            : (BlocProvider.of<NotesCubit>(context).notes.isEmpty
                ? Center(
                    child: Text(
                    "No Notes added yet!",
                    style: GoogleFonts.poppins(
                        fontSize: 35, color: Colors.lightBlue),
                  ))
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        BlocProvider.of<NotesCubit>(context).notes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NoteItemWidget(
                        note: BlocProvider.of<NotesCubit>(context).notes[
                            BlocProvider.of<NotesCubit>(context).notes.length -
                                index -
                                1],
                      );
                    },
                  ));
      },
    );
  }
}
