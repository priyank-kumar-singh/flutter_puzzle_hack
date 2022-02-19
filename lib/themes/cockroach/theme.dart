import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/constants/asset.dart';
import 'package:flutter_puzzle_hack/util/utils.dart';
import 'package:rive/rive.dart';

import 'bloc/bomb_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BombBloc(),
      child: _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  void play(BuildContext context) {
    context.read<BombBloc>().add(const BombPlay());
  }

  void explode(BuildContext context) {
    context.read<BombBloc>().add(const BombExplode());
  }

  void stop(BuildContext context) {
    context.read<BombBloc>().add(const BombStop());
  }

  void reset(BuildContext context) {
    context.read<BombBloc>().add(const BombReset());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 400,
              height: 400,
              padding: const EdgeInsets.all(48.0),
              child: ExplodeAnimation(
                duration: 2000,
                rings: 3,
                triggerAnimation: context.select<BombBloc, bool>((bloc) => bloc.state.status == BombStatus.exit),
                repeatOnUpdate: true,
                color: Colors.redAccent,
                child: RiveAnimation.asset(
                  AssetRiveAnims.bomb,
                  stateMachines: const ['state_machine_1'],
                  onInit: context.read<BombBloc>().registerTriggers,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    child: const Icon(Icons.play_arrow),
                    tooltip: 'Play',
                    onPressed: () => play(context),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.personal_injury_rounded),
                    tooltip: 'Explode',
                    onPressed: () => explode(context),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.stop),
                    tooltip: 'Stop',
                    onPressed: () => stop(context),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.replay_outlined),
                    tooltip: 'Reset',
                    onPressed: () => reset(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
