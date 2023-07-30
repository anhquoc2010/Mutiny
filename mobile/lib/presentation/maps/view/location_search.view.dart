import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mutiny/common/theme/text_styles.dart';
import 'package:mutiny/common/widgets/common_text_form_field.dart';
import 'package:mutiny/data/models/place.model.dart';
import 'package:mutiny/data/repositories/place.repository.dart';
import 'package:mutiny/di/di.dart';
import 'package:mutiny/presentation/maps/bloc/location_search/location_search.bloc.dart';

class LocationSearchPage extends StatelessWidget {
  const LocationSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          LocationSearchBloc(placeRepository: getIt.get<PlaceRepository>()),
      child: const _LocationSearchView(),
    );
  }
}

class _LocationSearchView extends StatelessWidget {
  const _LocationSearchView();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tìm kiếm địa chỉ',
          style: TextStyles.s17BoldText.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CommonTextFormField(
              borderRadius: 30,
              onChanged: (value) {
                context
                    .read<LocationSearchBloc>()
                    .add(LocationSearchChanged(input: value));
              },
              hintText: 'Địa chỉ đến',
            ),
            BlocBuilder<LocationSearchBloc, LocationSearchState>(
              builder: (context, state) {
                return ListView.separated(
                  itemCount: state.places.length,
                  itemBuilder: (_, index) {
                    final PlaceModel currentPlace = state.places[index];

                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.of(context).pop({
                          'description': currentPlace.description,
                          'destination': currentPlace.location,
                        });
                      },
                      child: SizedBox(
                        height: 25,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            currentPlace.description,
                            style: TextStyles.s14RegularText,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const Divider(
                      thickness: 1.2,
                    );
                  },
                  shrinkWrap: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
