import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String name, code, amount;
  final IconData icon;
  final Color blackColor = const Color(0xFF1F2123);
  bool isInverted;
  double offset;

  CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    this.isInverted = false,
    this.offset = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, offset),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isInverted ? Colors.white : blackColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: isInverted ? blackColor : Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        amount,
                        style: TextStyle(
                          color: isInverted ? blackColor : Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        code,
                        style: TextStyle(
                          color: isInverted
                              ? blackColor
                              : Colors.white.withOpacity(0.8),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.scale(
                scale: 2.2,
                child: Transform.translate(
                  offset: const Offset(-5, 12),
                  child: Icon(
                    icon,
                    color: isInverted ? blackColor : Colors.white,
                    size: 88,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrencyCards extends StatelessWidget {
  final List<CurrencyCard> cards;

  const CurrencyCards({
    super.key,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: () {
        int i = 0;
        return cards.map((card) {
          card.offset = (i * -20);
          card.isInverted = (i % 2 == 1);
          i++;
          return card;
        }).toList();
      }(),
    );
  }
}
