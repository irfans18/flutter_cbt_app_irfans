import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_app_irfans/presentation/home/bloc/content/content_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/custom_scaffold.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  void initState() {
    context.read<ContentBloc>().add(const ContentEvent.getContentById(1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: const Text('About US'),
      body: BlocBuilder<ContentBloc, ContentState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(
                child: Text("Error"),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            success: (data) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Assets.images.menu.aboutUs.image(),
                  Text(
                    data.data.isEmpty ? 'No Content' : data.data[0].content,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
