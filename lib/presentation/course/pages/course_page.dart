import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_app_irfans/presentation/course/bloc/bloc/course_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/custom_scaffold.dart';
import '../models/course_model.dart';
import '../widgets/course_card.dart';

class CoursePage extends StatefulWidget {
  final bool showBackButton;
  const CoursePage({super.key, this.showBackButton = true});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  void initState() {
    context.read<CourseBloc>().add(const CourseEvent.getAllCourse());
    super.initState();
  }

  // final List<MateriModel> datas = [
  //   MateriModel(
  //     image: Assets.images.materi1.path,
  //     name: 'Lorem ipsum dolor sit amet, consect.',
  //     dateTime: DateTime.now().subtract(const Duration(hours: 17)),
  //     description:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam accumsan sem ut ligu. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam accumsan sem ut ligu.',
  //   ),
  //   MateriModel(
  //     image: Assets.images.materi2.path,
  //     name: 'Lorem ipsum dolor sit amet, coadipisc',
  //     dateTime: DateTime.now().subtract(const Duration(days: 1)),
  //     description:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam accumsan sem ut ligu.',
  //   ),
  //   MateriModel(
  //     image: Assets.images.materi1.path,
  //     name: 'Lorem ipsum dolor sit amet, consect.',
  //     dateTime: DateTime.now().subtract(const Duration(days: 2)),
  //     description:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam accumsan sem ut ligu. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam accumsan sem ut ligu.',
  //   ),
  // ];
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackButton: widget.showBackButton,
      appBarTitle: const Text('Materi TPA'),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 24.0),
        children: [
          BlocBuilder<CourseBloc, CourseState>(
            builder: (context, state) {
              return state.maybeWhen(
                  orElse: () => const Center(child: Text("Error"),),
                  loading: () => const Center(
                      child: CircularProgressIndicator(),
                  ),
                  success: (data) {
                    return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.data.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16.0),
                    itemBuilder: (context, index) => CourseCard(
                      data: data.data[index],
                    ),
                  );
                  },);
            },
          ),
        ],
      ),
    );
  }
}
