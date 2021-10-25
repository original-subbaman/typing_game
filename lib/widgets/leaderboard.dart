import 'package:flutter/material.dart';
import 'package:thumbing/utility/constants.dart';
class Leaderboard extends StatelessWidget {
  final items;

  Leaderboard(this.items);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      shadowColor: Colors.deepPurpleAccent.shade400,
      color: Colors.black54,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Leaderboard',
                textAlign: TextAlign.left,
                style: kCardTextStyle.copyWith(
                  fontSize: 18,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(
                        items[index].userName,
                        style: kCardTextStyle,
                      ),
                      leading: CircleAvatar(
                        backgroundImage: items[index].userImage,
                      ),
                      trailing: Text(
                        items[index].rank,
                        style:
                        kCardTextStyle.copyWith(fontSize: 15),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
