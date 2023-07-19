import 'dart:developer';

import 'package:akshaytest/src/constants/constants.dart';
import 'package:akshaytest/src/logic/authentication/authentication_bloc.dart';
import 'package:akshaytest/src/logic/restaurant/restaurant_bloc.dart';
import 'package:akshaytest/src/screens/detail/restaurant_details.dart';
import 'package:akshaytest/src/screens/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RestaurantBloc()..add(LoadRestaurantsList()),
          ),
          
        ],
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            log("Home $state");
            if (state is AuthenticationFailed) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false);
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                title: const Text('Restaurants'),
                centerTitle: false,
                actions: [
                  TextButton.icon(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Logout"),
                                content: const Text(
                                    "Are you sure you want to log out?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text(
                                      "Cancel",
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text(
                                      "Logout",
                                      style: TextStyle(
                                          color:
                                              CupertinoColors.destructiveRed),
                                    ),
                                  ),
                                ],
                              );
                            }).then((value) {
                          if (value == true) {
                            context
                                .read<AuthenticationBloc>()
                                .add(UserLogout());
                          }
                        });
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'))
                ],
              ),
              BlocBuilder<RestaurantBloc, RestaurantState>(
                builder: (context, state) {
                  if (state is RestaurantListLoading) {
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: 3,
                            (context, index) => Shimmer.fromColors(
                                  baseColor: CupertinoColors.systemGrey5,
                                  highlightColor: CupertinoColors.systemGrey6,
                                  child: Container(
                                    height: 200,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.black
                                                  .withOpacity(0.1),
                                              blurRadius: 5,
                                              spreadRadius: 3)
                                        ]),
                                  ),
                                )));
                  }
                  if (state is RestaurantListSuccess) {
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: state.model.length,
                            (context, index) => GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          settings: RouteSettings(
                                              arguments: state.model[index]),
                                          builder: (context) =>
                                              const Detail())),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          color:
                                              AppColors.black.withOpacity(0.1),
                                          blurRadius: 5,
                                          spreadRadius: 3)
                                    ]),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: AppColors.white,
                                        child: Column(
                                          children: [
                                            Image.network(
                                              '${state.model[index].photograph}',
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return SizedBox(
                                                  height: 150,
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CircularProgressIndicator(
                                                          color:
                                                              AppColors.green,
                                                          strokeWidth: 1,
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              height: 150,
                                              width: double.infinity,
                                            ),
                                            setHeight(height: 5),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${state.model[index].name}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4,
                                                        vertical: 2),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '${state.model[index].reviews?[0].rating}',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall
                                                              ?.copyWith(
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                        Icon(Icons.star,
                                                            color:
                                                                AppColors.white,
                                                            size: 14)
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            setHeight(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  bottom: 10,
                                                  right: 10),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .restaurant_menu_outlined,
                                                        size: 18,
                                                      ),
                                                      setWidth(width: 8),
                                                      Text(
                                                          "${state.model[index].cuisineType}")
                                                    ],
                                                  ),
                                                  setHeight(height: 8),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        size: 18,
                                                      ),
                                                      setWidth(width: 8),
                                                      Text(
                                                          "${state.model[index].address}")
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )));
                  }
                  if (state is RestaurantListFailed) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Column(
                          children: [
                            const Icon(CupertinoIcons.wifi_exclamationmark,
                                color: CupertinoColors.systemRed),
                            setHeight(height: 16),
                            const Text(
                                "Something went wrong...!\nPlease check your Internet Connection")
                          ],
                        ),
                      ),
                    );
                  }
                  return const SliverToBoxAdapter();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
