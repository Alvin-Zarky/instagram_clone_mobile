import "package:flutter/material.dart";

class SearchFeaturesScreen extends StatelessWidget {
  const SearchFeaturesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: 10,
                  itemBuilder: ((context, index) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 230, 230, 230),
                      ),
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
