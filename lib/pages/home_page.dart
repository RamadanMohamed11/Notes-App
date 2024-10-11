import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_app/cubits/notes_cubit/add_notes_states.dart';
import 'package:notes_app/widgets/custom_app_bar_widget.dart';
import 'package:notes_app/widgets/model_bottom_sheet_for_search_widget.dart';
import 'package:notes_app/widgets/model_bottom_sheet_widget.dart';
import 'package:notes_app/widgets/notes_list_view_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.searchText, this.isFound});
  final String? searchText;
  final bool? isFound;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onPressedSearchIcon() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return const ModelBottomSheetForSearchWidget();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NotesCubit>(context).getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.searchText != null
            ? AppBar(
                centerTitle: true,
                title: Text(
                  "Search for ${widget.searchText}",
                  style: GoogleFonts.poppins(fontSize: 26),
                ),
              )
            : null,
        floatingActionButton: widget.searchText == null
            ? FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return const ModelBottomSheetWidget();
                      });
                },
                backgroundColor: Colors.black.withOpacity(0.7),
                child: const Icon(
                  Icons.add,
                  size: 35,
                ))
            : null,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: widget.searchText == null
                      ? CustomAppBarWidget(
                          onPressed: onPressedSearchIcon,
                          appBarText: "Note",
                          icon: const Icon(
                            Icons.search,
                            size: 37,
                          ),
                        )
                      : const SizedBox(),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: NotesListViewWidget(
                    searchText: widget.searchText,
                    isFound: widget.isFound,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
