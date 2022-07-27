import 'package:flutter/material.dart';
import 'package:thumbing/screens/leaderboard_screen.dart';
import 'package:thumbing/utility/constants.dart';

class Leaderboard extends StatelessWidget {
  final items;
  final bool showExpand;
  final borderRadius;
  Leaderboard(this.items, this.showExpand, this.borderRadius);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      color: kLightBlueAccent,
      borderRadius: borderRadius,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 12.0, bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Leaderboard',
                    textAlign: TextAlign.left,
                    style: kCardTextStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  Visibility(
                    visible: showExpand,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, LeaderboardScreen.kLeaderboardScreen);
                      },
                      icon: Icon(
                        Icons.north_east_rounded,
                        size: 25,
                      ),
                      color: Colors.white,
                    ),
                  ),
                ],
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
                        style: kCardTextStyle.copyWith(fontSize: 15),
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
