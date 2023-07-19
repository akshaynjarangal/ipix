import 'dart:developer';

import 'package:akshaytest/src/data/model/restaurant_model.dart';
import 'package:akshaytest/src/logic/detail/detail_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';

class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)?.settings.arguments as RestaurantsModel;
    final opHours = model.operatingHours?.toJson().entries.expand((entry) => entry.value.split(', ').map((timeSlot) => '${entry.key}: $timeSlot')).toList();
    return Scaffold(
      body: BlocProvider(
        create: (context) => DetailBloc(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [
                  StretchMode.blurBackground,
                  StretchMode.zoomBackground,
                ],
                background: Image.network(
                  '${model.photograph}',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${model.name}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '${model.reviews?[0].rating}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w600),
                              ),
                              Icon(Icons.star, color: AppColors.white, size: 14)
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text('${model.neighborhood}'),
                    ),
                    setHeight(height: 10),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.restaurant_menu_outlined,
                              size: 18,
                            ),
                            setWidth(width: 8),
                             Text("${model.cuisineType}")
                          ],
                        ),
                        setHeight(height: 8),
                        GestureDetector(
                          onTap: ()async{
                            try {
                              final url = Uri.https(AppUrls.gmap,AppUrls.gmapEndPoint,{
                                "api":"1",
                                "query":"${model.latlng?.lat},${model.latlng?.lng}"
                              });
                              await launchUrl(url,mode: LaunchMode.externalApplication);
                            } catch (e) {
                              log(e.toString());
                            }
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 18,
                              ),
                              setWidth(width: 8),
                              Text("${model.address}")
                            ],
                          ),
                        ),
                      ],
                    ),
                    Theme(
                      data: ThemeData(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        childrenPadding: EdgeInsets.zero,
                        
                          textColor: AppColors.black,
                          iconColor: AppColors.black,
                          tilePadding: EdgeInsets.zero,
                          title: Row(
                            children: [
                              const Icon(
                                CupertinoIcons.clock,
                                size: 18,
                              ),
                              setWidth(width: 8),
                                Text(
                                    "Operating Hours",style: Theme.of(context).textTheme.bodyMedium,)
                            ],
                          ),
                          children: List.generate(opHours?.length??0, (index) => Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 24),
                                child: Text(opHours?[index]),
                              ),
                            ],
                          )),
                          ),
                    ),
                    setHeight(height: 10),
                    Text(
                      'Rating & Reviews',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    setHeight(height: 10),
                    Column(
                      children: List.generate(
                          model.reviews?.length??0,
                          (index) => BlocBuilder<DetailBloc, DetailState>(
                                builder: (context, state) {
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.green,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                '${model.reviews?[index].rating}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: AppColors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                              Icon(Icons.star,
                                                  color: AppColors.white,
                                                  size: 14)
                                            ],
                                          ),
                                        ),
                                        setWidth(width: 10),
                                        Text(
                                          '${model.reviews?[index].name}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ],
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        children: [
                                           Text(
                                            '${model.reviews?[index].comments}',
                                            maxLines: state.index==index&& state.isReadmore? 15:3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${model.reviews?[index].date}'),
                                              TextButton(
                                                  onPressed: () {
                                                    if(state.index==null&&state.isReadmore==false){
                                                      context.read<DetailBloc>().add(ChangeReadmore(index: index, value: true));
                                                    }else if(state.index==index&&state.isReadmore==true){
                                                      context.read<DetailBloc>().add(ChangeReadmore(index: index, value:false));
                                                    }else{
                                                      context.read<DetailBloc>().add(ChangeReadmore(index: index, value:true));
                                                    }
                                                  },
                                                  child: Text(
                                                    state.index==index&&state.isReadmore? 'less':'Read more',
                                                    style: TextStyle(
                                                        color: AppColors.black,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ))
                                            ],
                                          ),
                                          if(index<model.reviews!.length-1)const Divider(
                                    thickness: 0.4,
                                    height: 0,
                                  )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
