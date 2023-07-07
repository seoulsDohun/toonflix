import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int selectedIndex = 0; // 선택된 timer index
  int totalSeconds = 10;
  bool isRunning = false;
  bool isResting = false;
  int roundCount = 4;
  int goalCount = 0;
  late Timer timer;

  /* 시간 초 > 시간 format */
  String hoursFormat(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.')[0].substring(2, 4);
  }

  /* 시간 초 > 분 format */
  String minutesFormat(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.')[0].substring(5, 7);
  }

  /* 시작 버튼 클릭 */
  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), startTick);
    setState(() {
      isRunning = true;
    });
  }

  /* 정지 버튼 클릭 */
  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  /* 1초마다 발생할 이벤트 */
  void startTick(Timer timer) {
    if (totalSeconds == 0) {
      isResting = !isResting;
      if (isResting) {
        totalSeconds = 300;
        setRound();
      } else {
        isRunning = false;
        totalSeconds = 60 * (15 + (selectedIndex * 5));
        timer.cancel();
        setState(() {});
      }
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  }

  /* 라운드(ROUND) 세팅 */
  void setRound() {
    if (roundCount != 4) {
      roundCount += 1;
    } else {
      roundCount = 0;
      setGoal();
    }
    setState(() {});
  }

  /* 목표(GOAL) 세팅 */
  void setGoal() {
    if (goalCount != 12) {
      goalCount += 1;
    } else {
      goalCount = 0;
      roundCount = 0;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose(); // ScrollController를 해제합니다.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          // 헤더
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 40,
              ),
              child: const Text(
                'POMOTIMER',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // 시간 표시
          Flexible(
            flex: 2,
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TimeContainer(
                        time: hoursFormat(totalSeconds),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        ":",
                        style: TextStyle(
                          fontSize: 70,
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TimeContainer(
                        time: minutesFormat(totalSeconds),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    isResting ? "Resting..." : "",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 시간 선택
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 35,
                ),
                scrollDirection: Axis.horizontal,
                controller:
                    _scrollController, // ScrollController를 ListView에 연결합니다.
                itemBuilder: (context, index) {
                  return selectTimerButton(index, context);
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: 20,
                ),
                itemCount: 5,
              ),
            ),
          ),
          // 재생 & 정지 버튼
          Flexible(
            flex: 2,
            child: Center(
              child: IconButton(
                iconSize: 100,
                color: Colors.white,
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: Icon(isRunning
                    ? Icons.pause_circle_filled_outlined
                    : Icons.play_circle_fill_outlined),
              ),
            ),
          ),
          // 진행상황
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CountColumn(
                    counting: roundCount,
                    maxCount: 4,
                    countText: "ROUND",
                  ),
                  CountColumn(
                    counting: goalCount,
                    maxCount: 12,
                    countText: "GOAL",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlinedButton selectTimerButton(int index, BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: selectedIndex == index
            ? Theme.of(context).colorScheme.background
            : Colors.white.withOpacity(0.5),
        backgroundColor: selectedIndex == index
            ? Colors.white
            : Theme.of(context).colorScheme.background,
        side: BorderSide(
          color: selectedIndex == index
              ? Colors.white
              : Colors.white.withOpacity(0.5),
        ),
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 10,
        ),
      ),
      onPressed: () {
        setState(() {
          selectedIndex = index;
          totalSeconds = 60 * (15 + (index * 5));
          if (isRunning) {
            timer.cancel();
          }
          isRunning = false;
          isResting = false;
        });
        // 선택된 버튼의 인덱스로 스크롤합니다.
        _scrollController.animateTo(
          index * 100.0, // 버튼의 폭에 따라 적절한 스크롤 위치를 계산합니다.
          duration:
              const Duration(milliseconds: 500), // 스크롤 애니메이션의 지속 시간을 설정합니다.
          curve: Curves.easeInOut, // 스크롤 애니메이션의 곡선을 설정합니다.
        );
      },
      child: Text("${15 + (index * 5)}"),
    );
  }
}

class CountColumn extends StatelessWidget {
  const CountColumn({
    super.key,
    required this.counting,
    required this.maxCount,
    required this.countText,
  });

  final int counting;
  final int maxCount;
  final String countText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$counting/$maxCount',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        Text(
          countText,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class TimeContainer extends StatelessWidget {
  final String time;

  const TimeContainer({
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 70,
            color: Theme.of(context).colorScheme.background,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
