import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_puzzle_hack/util/ui/animations/explosion.dart';
import 'package:rive/rive.dart';

import 'package:flutter_puzzle_hack/constants/asset.dart';

import 'bloc/bomb_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BombBloc(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatefulWidget {
  const _DashboardView({Key? key}) : super(key: key);

  @override
  State<_DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<_DashboardView> {
  void onRiveInit(BuildContext context, Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard, 'state_machine_1', onStateChange: ((machine, state) {
        // context.read<BombBloc>().add(BombStateChange(state));
      }));
    artboard.addController(controller!);
    context.read<BombBloc>().play = controller.findInput<bool>('play') as SMITrigger;
    context.read<BombBloc>().explode = controller.findInput<bool>('explode') as SMITrigger;
    context.read<BombBloc>().stop = controller.findInput<bool>('stop') as SMITrigger;
    context.read<BombBloc>().reset = controller.findInput<bool>('reset') as SMITrigger;

    controller.findInput<bool>('black_residue')?.value = true;
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
                triggerAnimation: context.read<BombBloc>().state is BombExit,
                color: Colors.redAccent,
                child: RiveAnimation.asset(
                  AssetRiveAnims.bomb,
                  stateMachines: const ['state_machine_1'],
                  onInit: (artboard) => onRiveInit(context, artboard),
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
                    onPressed: () {
                      context.read<BombBloc>().add(const BombTrigger('play'));
                    },
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.personal_injury_rounded),
                    tooltip: 'Explode',
                    onPressed: () {
                      context.read<BombBloc>().add(const BombTrigger('explode'));
                    },
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.stop),
                    tooltip: 'Stop',
                    onPressed: () {
                      context.read<BombBloc>().add(const BombTrigger('stop'));
                    },
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.replay_outlined),
                    tooltip: 'Reset',
                    onPressed: () {
                      context.read<BombBloc>().add(const BombTrigger('reset'));
                    },
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
