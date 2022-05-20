import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geeksday/bloc/admin_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/services/implementation/admin_service.dart';
import 'package:geeksday/services/implementation/auth_service.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:geeksday/services/implementation/quiz_records_service.dart';
import 'package:geeksday/ui/guategeeks/elements.dart';
import 'package:multiavatar/multiavatar.dart';

class SocialMetrics extends StatelessWidget {
  String eventId;
  SocialMetrics({Key? key, required this.eventId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GuateGeeksScaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 0.9,
          colors: [
            Color(0xFF0E89AF),
            Color(0xFF4B3BAB),
          ],
        ),
      ),
      child: _SocialMetricsWidget(eventId: eventId),
    ));
  }
}

class _SocialMetricsWidget extends StatelessWidget {
  String eventId;
  _SocialMetricsWidget({Key? key, required this.eventId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => AdminCubit(
            AdminService(), PostService(), AuthService(), QuizRecordsService()),
        child: BlocBuilder<AdminCubit, AdminState>(builder: (context, state) {
          // BlocProvider.of<AdminCubit>(context)
          //     .sortPostList(PostFilterOptions.MOST_POST, eventId);
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  BlocProvider.of<AdminCubit>(context)
                      .sortPostList(PostFilterOptions.MOST_POST, eventId);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Con mas likes"),
                        const Icon(Icons.arrow_drop_down_rounded)
                      ]),
                ),
              ),
              const _TopThee(),
              const SizedBox(
                height: 20,
              ),
              const Expanded(
                child: _Leaderboard(),
              ),
            ],
          );
        }));
  }
}

class _TopThee extends StatelessWidget {
  const _TopThee({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(builder: (context, state) {
      if (state.postList.isEmpty || state.postList.length < 3) {
        return const Center(
          child: Text("No Records"),
        );
      } else {
        var user1 = state.postList.entries.elementAt(0);
        var user2 = state.postList.entries.elementAt(1);
        var user3 = state.postList.entries.elementAt(2);
        return Row(children: [
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5),
                      borderRadius: BorderRadius.circular(990),
                    ),
                    width: 90,
                    height: 90,
                    child: SvgPicture.string(
                      multiavatar(
                          (state.userList[user2.key] as AuthUser).image),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("2"),
                  Text((state.userList[user2.key] as AuthUser).name),
                  Text(user2.value.toString()),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5),
                      borderRadius: BorderRadius.circular(990),
                    ),
                    width: 120,
                    height: 120,
                    child: SvgPicture.string(
                      multiavatar(
                          (state.userList[user1.key] as AuthUser).image),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("1"),
                  Text((state.userList[user1.key] as AuthUser).name),
                  Text(user1.value.toString()),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5),
                      borderRadius: BorderRadius.circular(990),
                    ),
                    width: 90,
                    height: 90,
                    child: SvgPicture.string(
                      multiavatar(
                          (state.userList[user3.key] as AuthUser).image),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("3"),
                  Text((state.userList[user3.key] as AuthUser).name),
                  Text(user3.value.toString()),
                ],
              ),
            ),
          ),
        ]);
      }
    });
  }
}

class _Leaderboard extends StatelessWidget {
  const _Leaderboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
    int _leaderboardCount = 4;

    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        return Container(
          width: maxWidth,
          padding: const EdgeInsets.fromLTRB(35, 20, 35, 5),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
              // Get all entries except the top three
              children: state.postList.entries.skip(3).map((e) {
            AuthUser user = state.userList[e.key] as AuthUser;
            int value = e.value;
            return _LeaderboardItem(
              position: _leaderboardCount++,
              user: user,
              value: value,
            );
          }).toList()),
        );
      },
    );
  }
}

class _LeaderboardItem extends StatelessWidget {
  AuthUser user;
  int value;
  int position;
  _LeaderboardItem(
      {Key? key,
      required this.user,
      required this.value,
      required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Text(position.toString()),
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100), color: Colors.red),
              child: SizedBox(
                width: 50,
                height: 50,
                child: SvgPicture.string(
                  multiavatar(user.image),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    user.name,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
        trailing: Text(value.toString()),
      ),
    );
  }
}
