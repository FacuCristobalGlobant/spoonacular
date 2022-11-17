import 'package:flutter/material.dart';

import '../../core/util/asset_constants.dart';
import '../../core/util/palette.dart';
import '../../core/util/text_constants.dart';

extension TimeExtension on TimeOfDay {
  formatHour() => '$hour ${hour == 1 ? 'hour' : 'hours'}';
  formatMinutes() => '$minute ${minute == 1 ? 'minute' : 'minutes'}';
  formatShortenedHour() => '$hour${TextConstants.hoursIdentifier}';
  formatShortenedMinute() => '$minute${TextConstants.minutesIdentifier}';
}

class CookingTime extends StatelessWidget {
  static const double timerSize = 80;
  static const double timerIconSize = 30;

  final TimeOfDay time;

  const CookingTime({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message:
          'Ready in ${time.hour > 0 ? '${time.formatHour()} and ' : ''}${time.formatMinutes()}.',
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: timerSize,
            height: timerSize,
            decoration: const BoxDecoration(
              color: Palette.darkOverlay,
              shape: BoxShape.circle,
            ),
          ),
          Column(
            children: [
              Image.asset(
                AssetConstants.timerIcon,
                fit: BoxFit.fill,
                color: Colors.white,
                width: timerIconSize,
                height: timerIconSize,
                filterQuality: FilterQuality.medium,
              ),
              Text(
                '${time.hour > 0 ? time.formatShortenedHour() : ''} ${time.minute > 0 ? time.formatShortenedMinute() : ''}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
