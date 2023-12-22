import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_app_irfans/presentation/quiz/bloc/quest_list/quest_list_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/constants/colors.dart';
import 'answer_choices.dart';

class QuizMultipleChoice extends StatefulWidget {
  const QuizMultipleChoice({super.key});

  @override
  State<QuizMultipleChoice> createState() => _QuizMultipleChoiceState();
}

class _QuizMultipleChoiceState extends State<QuizMultipleChoice> {
  final String selectedAnswer = "";
  final String answer="";
  
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
                          // selectedAnswer = value
                          },
                      ),
                      const SizedBox(height: 16.0),
                      AnswerChoices(
                        label: data[index].optionB,
                        isSelected: selectedAnswer == data[index].optionB,
                        onChanged: (value) { 
                          // selectedAnswer = value
                          },
                      ),
                      const SizedBox(height: 16.0),
                      AnswerChoices(
                        label: data[index].optionC,
                        isSelected: selectedAnswer == data[index].optionC,
                        onChanged: (value) { 
                          // selectedAnswer = value
                          },
                        answerCorrection: AnswerCorrection.none,
                      ),
                      const SizedBox(height: 16.0),
                      AnswerChoices(
                        label: data[index].optionD,
                        isSelected: selectedAnswer == data[index].optionD,
                        onChanged: (value) { 
                          // selectedAnswer = value
                          },
                        answerCorrection: AnswerCorrection.selected,
                      ),
                    ],
                  ),
                  const SizedBox(height: 38.0),
                  isNext ?
                  Button.filled(
                    onPressed: () {
                      context
                          .read<QuestListBloc>()
                          .add(const QuestListEvent.nextQuest());
                    },
                    label: 'Next',
                  ) : 
                  Button.filled(
                          onPressed: () {
                            // submit answer
                          },
                          label: 'Done',
                        ),
                ],
              );
          }
        );
        
      },
    );
  }
}
