import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/constants/durations.dart';
import '../../../core/models/deed.dart';
import '../../../shared/utils/built_in_deeds.dart';
import 'deed_category_badge.dart';

class SlotSpinner extends StatefulWidget {
  final Deed selectedDeed;
  final VoidCallback onComplete;

  const SlotSpinner({
    super.key,
    required this.selectedDeed,
    required this.onComplete,
  });

  @override
  State<SlotSpinner> createState() => _SlotSpinnerState();
}

class _SlotSpinnerState extends State<SlotSpinner> {
  late final List<FixedExtentScrollController> _controllers;
  late final List<List<Deed>> _columns;
  final _random = Random();
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _columns = List.generate(3, (_) {
      final shuffled = [...builtInDeeds]..shuffle(_random);
      shuffled.add(widget.selectedDeed);
      shuffled.shuffle(_random);
      return shuffled;
    });

    _controllers = List.generate(3, (_) {
      return FixedExtentScrollController(initialItem: 0);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _startSpin());
  }

  void _startSpin() async {
    for (int i = 0; i < 3; i++) {
      final targetIdx = i == 1
          ? _columns[i].indexOf(widget.selectedDeed)
          : _random.nextInt(_columns[i].length);

      final extraRotations = (8 + i * 3) * _columns[i].length;

      Future.delayed(
        Duration(milliseconds: i * NafsDurations.slotCascadeDelay.inMilliseconds),
        () {
          _controllers[i].animateToItem(
            extraRotations + targetIdx,
            duration: NafsDurations.slotSpinDuration +
                Duration(milliseconds: i * 300),
            curve: Curves.decelerate,
          );
        },
      );
    }

    await Future.delayed(
      NafsDurations.slotSpinDuration +
          const Duration(milliseconds: 900) +
          const Duration(milliseconds: 300),
    );

    if (mounted && !_completed) {
      _completed = true;
      widget.onComplete();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Stack(
        children: [
          Row(
            children: List.generate(3, (colIndex) {
              return Expanded(
                child: ListWheelScrollView.useDelegate(
                  controller: _controllers[colIndex],
                  itemExtent: 60,
                  perspective: 0.003,
                  diameterRatio: 2.5,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: _columns[colIndex].map((deed) {
                      return _SpinnerCard(deed: deed);
                    }).toList(),
                  ),
                ),
              );
            }),
          ),
          // Selection highlight
          Center(
            child: IgnorePointer(
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: NafsColors.accentGold.withValues(alpha: 0.4),
                      width: 1.5,
                    ),
                  ),
                  color: NafsColors.accentGold.withValues(alpha: 0.05),
                ),
              ),
            ),
          ),
          // Top/bottom fade
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 60,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    NafsColors.primaryDark,
                    NafsColors.primaryDark.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 60,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    NafsColors.primaryDark,
                    NafsColors.primaryDark.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpinnerCard extends StatelessWidget {
  final Deed deed;

  const _SpinnerCard({required this.deed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: NafsColors.cardSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: NafsColors.accentGold.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          DeedCategoryBadge(category: deed.category, compact: true),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              deed.title,
              style: NafsTextStyles.bodySmall.copyWith(
                color: NafsColors.ivoryText,
                fontSize: 11,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
