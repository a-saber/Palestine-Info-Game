/*
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:word_game/core/core_widget/alerts/alert_show_ad.dart';
import 'package:word_game/main.dart';

import '../../../../../core/core_widget/default_button.dart';
import '../../../../../core/manager/app_cubit.dart';
import '../../../../../core/resources_manager/colors_manager.dart';
import '../../../../../core/ads/admob_service.dart';

class RewardedAdd extends StatefulWidget {
  const RewardedAdd({Key? key, this.fromGainPoints=false}) : super(key: key);
  final bool fromGainPoints;
  @override
  State<RewardedAdd> createState() => _RewardedAddState();
}

class _RewardedAddState extends State<RewardedAdd> {

  RewardedAd? rewardedAd;
  int rewardedScore =0;
  @override
  void initState() {
    createRewardedAd();
    super.initState();
  }
  void createRewardedAd()
  {
    RewardedAd.load(
        adUnitId: AdMobService.rewardedAdUnitId!,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) => setState((){rewardedAd = ad;}),
          onAdFailedToLoad: (error) => setState(()=> rewardedAd = null),
        )
    );
  }
  void showRewardedAd()
  {
    if(rewardedAd !=null){
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad){
              AppCubit.get(context).addAdCoins();
            ad.dispose();
            createRewardedAd();
          },
          onAdFailedToShowFullScreenContent: (ad, error){
            ad.dispose();
            createRewardedAd();
          }
      );
      rewardedAd!.show(
          onUserEarnedReward: (ad,reward)
          => setState(()=>rewardedScore++)
      );
      rewardedAd = null;
    }
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return   widget.fromGainPoints ?
    DefaultButton(
      function:  (){
        showDialog(
          context: context,
          builder: (BuildContext ctx) =>
              alertShowAd(showRewardedAd),
          barrierDismissible: false,
        );
      },
      text: 'شاهد فيديو إعلاني و أحصل على 10 نقاط',
      icon: FontAwesomeIcons.film,
      sizefont: 16.0,
      paddingLeft: 10.0,
      paddingRight: 20.0,
      sizeIcon: 20.0,
      width: 495,
      height: 75,
      radius: 10.0,
    )
        :
      InkWell(
       onTap: ()
      {
        showDialog(
          context: context,
          builder: (BuildContext ctx) =>
              alertShowAd(showRewardedAd),
          barrierDismissible: false,
        );
      },
            child: Container(
              decoration: BoxDecoration(
                  color: ColorsManager.buttonColor,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: ColorsManager.secondColor)
              ),
              child:  const Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(
                  FontAwesomeIcons.film,
                  color: ColorsManager.secondColor,
                  size: 35.0,
                ),
              ),
            )
    );
  }
}
*/