import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: SizedBox(
        width: double.maxFinite,
        child: ListView.separated(
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('USER NAME'),
                        SizedBox(height: 4),
                        Text('USER Descreptoin'),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_vert),
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: 10,
        ),
      ),
    );
  }
}
