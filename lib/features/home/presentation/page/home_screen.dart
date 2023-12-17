import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_chat/core/utils/app_colors.dart';
import 'package:giraffe_chat/features/home/presentation/manager/home_cubit.dart';
import 'package:giraffe_chat/features/home/presentation/manager/home_state.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (_, state) {},
        builder: (_, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              centerTitle: true,
              leading: Icon(Icons.home_filled),
              title: HomeCubit.get(context).searchFlag
                  ? TextField(
                      controller: HomeCubit.get(context).searchController,
                      onChanged: (text) {
                        HomeCubit.get(context).searchForUser();
                      },
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "search...",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    )
                  : Text("Giraffe Chat"),
              actions: [
                IconButton(
                    onPressed: () {
                      bool searchFlag = !HomeCubit.get(context).searchFlag;
                      HomeCubit.get(context).changeSearchState(searchFlag);
                    },
                    icon: Icon(HomeCubit.get(context).searchFlag
                        ? Icons.close_rounded
                        : Icons.search)),
                IconButton(
                    onPressed: () {
                      //HomeCubit.get(context).logout();
                      Navigator.pushNamed(context, Routes.profile);
                    },
                    icon: Icon(Icons.more_vert)),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add_comment_rounded),
            ),
            body: StreamBuilder(
              stream: HomeCubit.get(context).snapshot,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      final docs = snapshot.data?.docs;
                      HomeCubit.get(context).handleUsersStream(docs);
                    }
                    return ListView.builder(
                      itemBuilder: (_, index) {
                        return UserCard(HomeCubit.get(context).searchFlag
                            ? HomeCubit.get(context).filteredUsers[index]
                            : HomeCubit.get(context).users[index]);
                      },
                      itemCount: HomeCubit.get(context).searchFlag
                          ? HomeCubit.get(context).filteredUsers.length
                          : HomeCubit.get(context).users.length,
                      physics: BouncingScrollPhysics(),
                    );
                }
              },
            ),
          );
        });
  }
}
