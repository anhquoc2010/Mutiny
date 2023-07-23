import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mutiny/presentation/maps/maps.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapsBloc(),
      child: const _MapsView(),
    );
  }
}

class _MapsView extends StatelessWidget {
  const _MapsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapsBloc, MapsState>(
      builder: (context, state) {
        // TODO: return correct widget based on the state.
        return const Scaffold();
      },
    );
  }
}
