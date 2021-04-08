import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testable_web_app/sample/timer/bloc/timer_bloc.dart';

class TimerActions extends StatelessWidget {
  const TimerActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(
        timerBloc: BlocProvider.of<TimerBloc>(context),
      ),
    );
  }

  /// Shallow List of button widgets is ok.~
  ///
  /// This part also seems somewhat lazy
  /// using a quick function for a long spaghetti implementation
  ///
  /// rather than creating a widget per Flutter optimised convention
  ///
  /// Even library maintainers do not follow standard/better conventions
  /// the majority of the time
  ///
  /// https://github.com/flutter/flutter/issues/19269
  /// There is nothing wrong with functions, but Widgets can be const and can have keys. Those are both very important features
  /// https://www.reddit.com/r/FlutterDev/comments/avhvco/extracting_widgets_to_a_function_is_not_an/
  /// https://stackoverflow.com/questions/53234825/what-is-the-difference-between-functions-and-classes-to-create-reusable-widgets
  /// https://stackoverflow.com/questions/53234825/what-is-the-difference-between-functions-and-classes-to-create-reusable-widgets/53234826#53234826
  /// https://chat.stackoverflow.com/rooms/218253/discussion-on-answer-by-remi-rousselet-what-is-the-difference-between-functions
  /// https://stackoverflow.com/questions/58825316/flutter-widgets-best-practices-inner-class-vs-function
  ///
  /// verbose
  /// https://github.com/rrousselGit/functional_widget
  ///
  /// It is more work to rebuild deep widget trees as it would not be able to tree shake
  /// the nested parts within this function
  ///
  ///
  /// If the whole widget needs to be rebuilt anyway, the fn vs construction is similar
  ///
  /// ==() override? const constructor
  List<Widget> _mapStateToActionButtons({
    required TimerBloc timerBloc,
  }) {
    final TimerState currentState = timerBloc.state;
    // Sample code "concise" is hard to read and smelly.
    // Documented samples should set the scene on how maintainable bloc projects
    // are developed..
    //
    // https://github.com/felangel/bloc/issues/934
    // https://github.com/felangel/bloc/issues/1024
    // Change to a better maintained sample like Car or Todos.
    //
    //
    if (currentState is TimerInitial) {
      return [
        FloatingActionButton(
          onPressed: () =>
              timerBloc.add(TimerStarted(duration: currentState.duration)),
          child: const Icon(Icons.play_arrow),
        ),
      ];
    }

    // Hard to read like this...
    if (currentState is TimerRunInProgress) {
      return [
        FloatingActionButton(
          onPressed: () => timerBloc.add(TimerPaused()),
          child: const Icon(Icons.pause),
        ),
        FloatingActionButton(
          onPressed: () => timerBloc.add(TimerReset()),
          child: const Icon(Icons.replay),
        ),
      ];
    }
    if (currentState is TimerRunPause) {
      return [
        FloatingActionButton(
          onPressed: () => timerBloc.add(TimerResumed()),
          child: const Icon(Icons.play_arrow),
        ),
        FloatingActionButton(
          onPressed: () => timerBloc.add(TimerReset()),
          child: const Icon(Icons.replay),
        ),
      ];
    }
    if (currentState is TimerRunCompleteResettable) {
      return [
        FloatingActionButton(
          onPressed: () => timerBloc.add(TimerReset()),
          child: const Icon(Icons.replay),
        ),
      ];
    }
    return [];
  }
}
