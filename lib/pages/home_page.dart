import 'package:flutter/material.dart';
import 'package:notes_app/widgets/custom_app_bar_widget.dart';
import 'package:notes_app/widgets/model_bottom_sheet_widget.dart';
import 'package:notes_app/widgets/note_item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void onPressedSearchIcon() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
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
            )),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                CustomAppBarWidget(
                  onPressed: onPressedSearchIcon,
                  appBarText: "Note",
                  icon: const Icon(
                    Icons.search,
                    size: 37,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return const NoteItemWidget();
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
