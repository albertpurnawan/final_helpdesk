import 'package:flutter/material.dart';
import 'package:helpdesk_skripsi/style.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({super.key});

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  static List<String> categoryItems = [
    "Server",
    "Cloud",
    "Network Problem",
    "Technical Problem",
    "Application Problem",
    "Incident",
    "Data Center"
  ];

  final List<Map<String, dynamic>> _items = List.generate(
    7,
    (index) => {
      "id": index,
      "title": categoryItems[index],
      "created_by": "MG000$index",
      "created_at": "15/11/2022",
      "updated_by": "MG000$index",
      "updated_at": "15/11/2022",
    },
  );

  void _removeItem(int id) {
    setState(() {
      _items.removeWhere((element) => element['id'] == id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Item #$id has been removed"),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return Card(
            key: PageStorageKey(item['id']),
            color: secondaryColor,
            elevation: 2,
            child: ExpansionTile(
              collapsedIconColor: primaryColor,
              iconColor: primaryColor,
              childrenPadding: const EdgeInsets.all(5),
              // expandedCrossAxisAlignment: CrossAxisAlignment.end,
              title: Text(
                item['title'],
                style: TextStyle(color: primaryColor),
              ),
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Created by: ${item['created_by']}",
                          style: TextStyle(color: primaryColor),
                        ),
                        Text(
                          "Created at: ${item['created_at']}",
                          style: TextStyle(color: primaryColor),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Updated by: ${item['updated_by']}",
                          style: TextStyle(color: primaryColor),
                        ),
                        Text(
                          "Updated at: ${item['updated_at']}",
                          style: TextStyle(color: primaryColor),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // BUTTON EDIT
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            color: primaryColor,
                          ),
                        ),
                        // BUTTON DELETE
                        IconButton(
                          onPressed: () {
                            _removeItem(index);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: primaryColor,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
