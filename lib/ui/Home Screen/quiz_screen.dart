import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_academy/config/config.dart';
import 'package:quiz_academy/style/app_colors.dart';

import '../../model/Quiz_model.dart';
import '../../model/ad_helper.dart';
import '../../style/constant.dart';
import '../../widgets/button_global.dart';
import 'mt_loser.dart';
import 'mt_victory.dart';



class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key,required this.quizzes}) : super(key: key);
  final Quizzes quizzes;
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  PageController pageController = PageController();

  bool isSelected = true;
  String select = '';
  int currentIndex = 0;
  int score = 0;


  void checkAnswer(String answer, String rightAnswer){
    if(answer == rightAnswer){
      score++;
    }
  }


  List<Color> colorList = [
    const Color(0xFFFF0000),
    const Color(0xFF4AAF4F),
    const Color(0xFFECECEC),
  ];
  final CountDownController _controller = CountDownController();
  final assetsAudioPlayer = AssetsAudioPlayer();
  int _interstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 5;

  late BannerAd _bottomBannerAd;
  InterstitialAd? _interstitialAd;

  bool _isBottomBannerAdLoaded = false;

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (_) {
        setState(() {
          print('Banner Ad Loaded');
          _isBottomBannerAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();
      }),
    );
    _bottomBannerAd.load();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback:
        InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          print('Interstitial Ad Loaded');
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        }, onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_interstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        }));
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
            ad.dispose();
            _createInterstitialAd();
          }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        _createInterstitialAd();
      });
      _interstitialAd!.show();
    }
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 10));
    _interstitialAd != null ? _showInterstitialAd() : null;
  }

  @override
  void initState() {
    _createBottomBannerAd();
    _createInterstitialAd();
    init();
    super.initState();
  }
  @override
  void dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          bottomNavigationBar: _isBottomBannerAdLoaded
              ? SizedBox(
            height: _bottomBannerAd.size.height.toDouble(),
            width: _bottomBannerAd.size.width.toDouble(),
            child: AdWidget(ad: _bottomBannerAd),
          )
              : null,
          body: PageView.builder(
              controller: pageController,
              itemCount: widget.quizzes.questions!.length,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (val){
                setState(() {
                  currentIndex++;
                });
              },
              itemBuilder: (_, i) {
                return Column(
                  children: [
                    ListTile(
                      horizontalTitleGap: 0.0,
                      title: Text(
                        widget.quizzes.name ?? '',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${widget.quizzes.questions!.length.toString()} Questions (${widget.quizzes.rewardPoint.toString()} Points)',
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: CircularCountDownTimer(
                        duration: 30,
                        initialDuration: 0,
                        controller: _controller,
                        height: 50.0,
                        width: 50.0,
                        ringColor: AppColor.mainColor,
                        ringGradient: null,
                        fillColor: Colors.white,
                        fillGradient: null,
                        backgroundColor: Colors.transparent,
                        backgroundGradient: null,
                        strokeWidth: 3.0,
                        strokeCap: StrokeCap.round,
                        textStyle: const TextStyle(
                          fontSize: 18.0,
                          color: AppColor.titleColor,
                        ),
                        textFormat: CountdownTextFormat.S,
                        isReverse: true,
                        isReverseAnimation: false,
                        isTimerTextShown: true,
                        autoStart: true,
                        onStart: () async {
                          //await Future.delayed(const Duration(seconds: 20)).then((value) => assetsAudioPlayer.open(Audio('images/tick.mp3'),autoStart: true,showNotification: false));
                        },
                        onChange: (val){
                          if(val == '10'){
                            assetsAudioPlayer.open(Audio('images/tick.mp3'),autoStart: true,showNotification: false);
                          }
                        },
                        onComplete: () {
                          assetsAudioPlayer.dispose();
                          currentIndex+1 ==  widget.quizzes.questions!.length ? MtLoser(quizzes: widget.quizzes,score: score.toString(),).launch(context)
                              : pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.bounceIn,);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      width: context.width() / 1.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                  image: NetworkImage(widget.quizzes.questions![i].image.toString()),
                                ),
                              ),
                            ).visible(widget.quizzes.questions![i].image != AppConfig.siteUrl),
                            const SizedBox(height: 10.0),
                            Center(
                              child: Text(
                                widget.quizzes.questions![i].question ?? '',
                                style: TextStyle(color: AppColor.titleColor),
                                maxLines: 3,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: BorderSide(color: select == widget.quizzes.questions![i].optionA ? Colors.green : AppColor.subTitleColor.withOpacity(0.5)),
                              ),
                              child: ListTile(
                                onTap: () {
                                  checkAnswer('A', widget.quizzes.questions![i].answer.toString());
                                  setState(() {
                                    select = widget.quizzes.questions![i].optionA.toString();
                                  });
                                },
                                title: Text(
                                  widget.quizzes.questions![i].optionA ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.titleColor,
                                  ),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        FeatherIcons.check,
                                        color: Colors.green,
                                      ).visible(select == widget.quizzes.questions![i].optionA),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: BorderSide(color: select == widget.quizzes.questions![i].optionB ? Colors.green : AppColor.subTitleColor.withOpacity(0.5)),
                              ),
                              child: ListTile(
                                onTap: () {
                                  checkAnswer('B', widget.quizzes.questions![i].answer.toString());

                                  setState(() {
                                    select = widget.quizzes.questions![i].optionB.toString();
                                  });
                                },
                                title: Text(
                                  widget.quizzes.questions![i].optionB ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.titleColor,
                                  ),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        FeatherIcons.check,
                                        color: Colors.green,
                                      ).visible(select == widget.quizzes.questions![i].optionB),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: BorderSide(color: select == widget.quizzes.questions![i].optionC ? Colors.green : AppColor.subTitleColor.withOpacity(0.5)),
                              ),
                              child: ListTile(
                                onTap: () {
                                  checkAnswer('C', widget.quizzes.questions![i].answer.toString());

                                  setState(() {
                                    select = widget.quizzes.questions![i].optionC.toString();
                                  });
                                },
                                title: Text(
                                  widget.quizzes.questions![i].optionC ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.titleColor,
                                  ),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        FeatherIcons.check,
                                        color: Colors.green,
                                      ).visible(select == widget.quizzes.questions![i].optionC),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: BorderSide(color: select == widget.quizzes.questions![i].optionD ? Colors.green : AppColor.subTitleColor.withOpacity(0.5)),
                              ),
                              child: ListTile(
                                onTap: () {
                                  checkAnswer('D', widget.quizzes.questions![i].answer.toString());

                                  setState(() {
                                    select = widget.quizzes.questions![i].optionD.toString();
                                  });
                                },
                                title: Text(
                                  widget.quizzes.questions![i].optionD ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.titleColor,
                                  ),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        FeatherIcons.check,
                                        color: Colors.green,
                                      ).visible(select == widget.quizzes.questions![i].optionD),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            ButtonGlobal(
                                buttonText: 'Next',
                                buttonDecoration: myButtonDecoration,
                                onPressed: () async{
                                  assetsAudioPlayer.dispose();
                                  currentIndex+1 ==  widget.quizzes.questions!.length ? score == widget.quizzes.questions!.length? Victory(score: score.toString(), questions: widget.quizzes.questions!.length.toString(),point: widget.quizzes.rewardPoint.toString(),).launch(context) : MtLoser(quizzes: widget.quizzes,score: score.toString(),).launch(context)
                                      : pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.bounceIn,);
                                }, buttonTextColor: Colors.white,),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
