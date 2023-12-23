// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_app_irfans/presentation/quiz/bloc/answer/answer_bloc.dart';

import 'package:flutter_cbt_app_irfans/presentation/quiz/bloc/count_score/count_score_bloc.dart';
import 'package:flutter_cbt_app_irfans/presentation/quiz/bloc/quest_list/quest_list_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/constants/colors.dart';
import 'answer_choices.dart';

class QuizMultipleChoice extends StatefulWidget {
  final String category;
  const QuizMultipleChoice({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<QuizMultipleChoice> createState() => _QuizMultipleChoiceState();
}

class _QuizMultipleChoiceState extends State<QuizMultipleChoice> {
  String selectedAnswer = "";
  String answer = "";

  @override
  Widget build(BuildContext context) {
    // final ValueNotifier<String> selectedAnswer = ValueNotifier("");

    return BlocBuilder<QuestListBloc, QuestListState>(
      builder: (context, state) {
        return state.maybeWhen(
            orElse: () => const Center(child: CircularProgressIndicator()),
            success: (data, index, isNext) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.14),
                          blurRadius: 17,
                          offset: const Offset(0, 8),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Text(
                      data[index].question,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 34.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnswerChoices(
                        label: data[index].optionA,
                        isSelected: selectedAnswer == data[index].optionA,
                        onChanged: (value) {
                          setState(() {
                            selectedAnswer = value;
                            answer = "a";
                          });
                        },
                      ),
                      const SizedBox(height: 16.0),
                      AnswerChoices(
                        label: data[index].optionB,
                        isSelected: selectedAnswer == data[index].optionB,
                        onChanged: (value) {
                          setState(() {
                            selectedAnswer = value;
                            answer = "b";
                          });
                        },
                      ),
                      const SizedBox(height: 16.0),
                      AnswerChoices(
                        label: data[index].optionC,
                        isSelected: selectedAnswer == data[index].optionC,
                        onChanged: (value) {
                          setState(() {
                            selectedAnswer = value;
                            answer = "c";
                          });
                        },
                        answerCorrection: AnswerCorrection.none,
                      ),
                      const SizedBox(height: 16.0),
                      AnswerChoices(
                        label: data[index].optionD,
                        isSelected: selectedAnswer == data[index].optionD,
                        onChanged: (value) {
                          setState(() {
                            selectedAnswer = value;
                            answer = "d";
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 38.0),
                  answer.isEmpty
                      ? Button.filled(
                          disabled: true,
                          onPressed: () {},
                          label: "Next",
                        )
                      : isNext
                          ? Button.filled(
                              onPressed: () {
                                context.read<AnswerBloc>().add(
                                    AnswerEvent.setAnswer(
                                        data[index].id, answer));
                                context
                                    .read<QuestListBloc>()
                                    .add(const QuestListEvent.nextQuest());
                              },
                              label: "Next",
                            )
                          : Button.filled(
                              onPressed: () {
                                // submit answer
                                context.read<CountScoreBloc>().add(
                                    CountScoreEvent.countScore(
                                        widget.category));
                              },
                              label: "Done",
                            ),
                ],
              );
            });
      },
    );
  }
}
