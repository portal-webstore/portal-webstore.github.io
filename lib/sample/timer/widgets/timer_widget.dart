import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider;
import 'package:testable_web_app/sample/timer/bloc/timer_bloc.dart';

part 'timer_actions_widget.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    Key? key,
  }) : super(key: key);

  static const TextStyle timerTextStyle = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.bold,
  );

  /// Needs to be rebuilt on each tick anyway
  static Widget getTimerText(
    BuildContext context,
    TimerState state,
  ) {
    final timeTextMmss = getTimeTextFromDuration(state.duration);

    return Text(
      timeTextMmss,
      style: TimerWidget.timerTextStyle,
    );
  }

  static String getTimeTextFromDuration(
    int duration,
  ) {
    // Dart is non-integer division.
    // Fractional part is not discarded automatically
    final double minutes = duration / 60;
    final double hourRemainderInMinutesDenomination = minutes % 60;
    final double minutesRemainderInSeconds = duration % 60;

    final int minutesRoundedDown = hourRemainderInMinutesDenomination.floor();
    final String minutesText = minutesRoundedDown.toString().padLeft(2, '0');

    final secondsRoundedDown = minutesRemainderInSeconds.floor();

    final String secondsText = secondsRoundedDown.toString().padLeft(2, '0');
    return '$minutesText:$secondsText';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 100.0),
          child: Center(
            child: BlocBuilder<TimerBloc, TimerState>(
              builder: getTimerText,
            ),
          ),
        ),
        BlocBuilder<TimerBloc, TimerState>(
          buildWhen: (previousState, state) =>
              state.runtimeType != previousState.runtimeType,
          // `const` results in this never being re-evaluated
          // Remove const to see the button displays change based on state.
          // Provided in the nested BlocProvider
          builder: (context, state) => /* const */_TimerActions(),
        ),
      ],
    );
  }
}
