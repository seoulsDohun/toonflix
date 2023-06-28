import 'package:flutter/material.dart';
import 'package:toonflix/widgets/button.dart';
import 'package:toonflix/widgets/currency_card.dart';

void main() {
  runApp(const App()); // 위젯을 파라미터로 필요로함.
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Hey, dohun',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Welcome back',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Tatal Balance',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '\$ 5 194 382',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                      text: 'Transfer',
                      bgColor: Color(0xFFF1B33B),
                      textColor: Colors.black,
                    ),
                    Button(
                      text: 'Request',
                      bgColor: Color(0xFF1f2123),
                      textColor: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Wallets',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CurrencyCards(
                  cards: [
                    CurrencyCard(
                      name: 'Euro',
                      amount: '6 428',
                      code: 'EUR',
                      icon: Icons.euro_rounded,
                    ),
                    CurrencyCard(
                      name: 'Bitcoin',
                      amount: '9 785',
                      code: 'BTC',
                      icon: Icons.currency_bitcoin,
                    ),
                    CurrencyCard(
                      name: 'Dollar',
                      amount: '428',
                      code: 'USD',
                      icon: Icons.attach_money,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
