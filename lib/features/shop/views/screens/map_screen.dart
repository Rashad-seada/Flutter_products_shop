import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bloc/map/map_cubit.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) {},
        builder: (context, state) {
          return GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: context.read<MapCubit>().initialPosition,
              onMapCreated: (_)=> context.read<MapCubit>().onMapCreated(_)
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=> context.read<MapCubit>().onTap(),
        label: const Text('To My Location'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }
}


