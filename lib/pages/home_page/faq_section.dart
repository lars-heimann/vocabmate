import 'package:vocabmate/widgets/animated_swap.dart';
import 'package:vocabmate/widgets/max_width_constrained_box.dart';
import 'package:vocabmate/widgets/section_title.dart';
import 'package:vocabmate/providers/home_page_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

TextStyle _getAnswerTextStyle(BuildContext context) =>
    DefaultTextStyle.of(context).style.copyWith(
          fontSize: 16,
          color: const Color.fromARGB(255, 0, 0, 0),
        );

class FaqSection extends ConsumerWidget {
  const FaqSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaxWidthConstrainedBox(
      key: ref.read(homePageScrollViewProvider).faqSectionKey,
      maxWidth: 850,
      child: const Column(
        children: [
          SectionTitle(title: 'FAQ'),
          SizedBox(height: 48),
          _IsVocabmateOpenSource(),
          _WhichLanguagesAreSupported(),
          _WhichModelIsUsed(),
          _AreMyDataUsedForTraining(),
          _DoesItWorkWithOtherApps(),
          _CurrentLimits(),
          _CouldHaveFalseInformation(),
          _IsVocabmateRelatedToAnkiGPT(),
          _HowDoesVocabmateWork(),
        ],
      ),
    );
  }
}

class _IsVocabmateOpenSource extends StatelessWidget {
  const _IsVocabmateOpenSource();

  @override
  Widget build(BuildContext context) {
    return const _FaqCard(
      question: Text('Is the source code of Vocabmate public?'),
      answer: _MarkdownAnswer(
        text:
            "Yes, the source code of the client for Vocabmate is public and can be accessed by anyone interested. You can explore or even contribute to the project by visiting the GitHub repository [lars0530/vocabmate](https://github.com/lars0530/vocabmate). However, it's important to note that while the client's code is open, the backend (including the prompts) is closed source. We greatly value community input and appreciate all contributions to improve Vocabmate. It is also important to note that this project is greatly inspired by [AnkiGPT](https://ankigpt.help/) by Nils Reichardt",
      ),
    );
  }
}

class _WhichLanguagesAreSupported extends StatelessWidget {
  const _WhichLanguagesAreSupported();

  @override
  Widget build(BuildContext context) {
    return const _FaqCard(
      question: Text('Which languages are supported?'),
      answer: Text(
          'Vocabmate is designed to be a globally accessible tool, and as such, it supports nearly all languages. This broad language coverage allows users from various linguistic backgrounds to utilize Vocabmate effectively. However, the level of support might vary depending on the language due to complexities in language structures and available datasets. We are consistently working on improving our support for all languages to ensure the best user experience possible.'),
    );
  }
}

class _WhichModelIsUsed extends StatelessWidget {
  const _WhichModelIsUsed();

  @override
  Widget build(BuildContext context) {
    return const _FaqCard(
      question: Text('Which model is used for Vocabmate?'),
      answer: _MarkdownAnswer(
        text:
            "Vocabmate primarily utilizes the GPT-4o-mini by OpenAI to generate flashcards, offering a seamless integration of advanced AI technology for effective learning. For users who opt for the Vocabmate Plus version, they gain the enhanced capability to generate an increased number of flashcards per month using the more advanced [GPT-4o model](https://openai.com/index/hello-gpt-4o/), ensuring even more sophisticated and nuanced content creation.",
      ),
    );
  }
}

class _AreMyDataUsedForTraining extends StatelessWidget {
  const _AreMyDataUsedForTraining();

  @override
  Widget build(BuildContext context) {
    return const _FaqCard(
      question:
          Text('Is the content from my submitted texts used for AI training?'),
      answer: _MarkdownAnswer(
        text:
            "No, your submitted content is not used for AI training. Vocabmate leverages GPT models from OpenAI, which have a strong commitment to user privacy. OpenAI do not use customer-submitted data via their API to train or improve their models (Source: [API data usage policies](https://openai.com/policies/api-data-usage-policies)). Your text content is only processed to create flashcards and is not used for any other purposes, ensuring your information remains private and secure.",
      ),
    );
  }
}

class _DoesItWorkWithOtherApps extends StatelessWidget {
  const _DoesItWorkWithOtherApps();

  @override
  Widget build(BuildContext context) {
    return _FaqCard(
      question: const Text(
          'Does Vocabmate work with other Flashcard Apps than Anki?'),
      answer: MarkdownBody(
        data:
            "Yes! As Vocabmate creates Flashcards in CSV-Format, the flashcards can be imported into most known flashcard applications. However, we encourage users to utilize Vocabmate with the [Anki](https://apps.ankiweb.net) app for the best performance and reliability.",
        styleSheet: MarkdownStyleSheet(
          a: _getAnswerTextStyle(context).copyWith(
            decoration: TextDecoration.underline,
          ),
          p: _getAnswerTextStyle(context),
        ),
        onTapLink: (text, href, title) => launchUrl(Uri.parse(href!)),
      ),
    );
  }
}

class _CurrentLimits extends StatelessWidget {
  const _CurrentLimits();

  @override
  Widget build(BuildContext context) {
    return const _FaqCard(
      question: Text('What are the current limitations?'),
      answer: _MarkdownAnswer(
        text:
            """While Vocabmate is a powerful tool, it does have a few limitations to keep in mind:

* Firstly, remember that AI, including Vocabmate, is not infallible. There will be occasional errors in the generated flashcards, as with any AI technology. Always review your flashcards for accuracy.

* Secondly, GPT models, at the current stage of development, aren't able to fully understand every language to the same degree. While Vocabmate supports nearly all languages, the level of support may vary depending on the language.

* Lastly, Vocabmate is continually under development, which means, that some features might not work as expected. Some might also be added or removed without further notice. 

We're continually working on refining and expanding Vocabmate's capabilities to improve your learning experience. Stay tuned for future updates and enhancements.""",
      ),
    );
  }
}

class _CouldHaveFalseInformation extends StatelessWidget {
  const _CouldHaveFalseInformation();

  @override
  Widget build(BuildContext context) {
    return const _FaqCard(
      question: Text(
          'Is it possible that the flashcards have incorrect information?'),
      answer: Text(
          "Yes, it's possible that the flashcards generated by Vocabmate may contain inaccuracies. Even with its advanced technology, AI is not perfect and can occasionally produce errors. Therefore, Vocabmate should be used as an assistant to your study process, not a replacement for creating your own flashcards. We recommend that users always review and cross-verify the information on the flashcards to ensure accuracy. We're continually working to improve the reliability and precision of our tool, but human oversight remains an important part of the process to guarantee quality learning outcomes."),
    );
  }
}

class _IsVocabmateRelatedToAnkiGPT extends StatelessWidget {
  const _IsVocabmateRelatedToAnkiGPT();

  @override
  Widget build(BuildContext context) {
    return const _FaqCard(
      question: Text('Is Vocabmate related to AnkiGPT?'),
      answer: _MarkdownAnswer(
          text:
              "Yes, Vocabmate draws significant inspiration from [AnkiGPT](https://ankigpt.help), a project by [Nils Reichardt](https://www.linkedin.com/in/nilsreichardt). While the frontend of Vocabmate, built using Flutter, shares major similarities with AnkiGPT, the backend infrastructure is entirely developed and maintained independently by Lars Heimann."),
    );
  }
}

class _HowDoesVocabmateWork extends StatelessWidget {
  const _HowDoesVocabmateWork();

  @override
  Widget build(BuildContext context) {
    return const _FaqCard(
      question: Text('How does Vocabmate work?'),
      answer: _MarkdownAnswer(
        text:
            """Vocabmate is a tool designed to generate flashcards from the text you wish to learn. It leverages the GPT-4o-mini model by OpenAI to create these flashcards. The process is straightforward: you submit the text you want to learn, and Vocabmate generates flashcards based on that content. You can then review and export these flashcards to [Anki](https://apps.ankiweb.net) for further study. Vocabmate aims to streamline the flashcard creation process, making it easier and more efficient for users to learn new information.
        
On a more technical level, Vocabmate consists of two main components: the frontend and the backend.

**Frontend:**
* Built using [Flutter](https://flutter.dev/), an app development framework by Google, utilizing the [Dart programming language](https://dart.dev/).
* Hosted using AWS Amplify.
* Communicates with the backend for data processing and displays the results.

**Backend:**
* An [Express](https://expressjs.com/) web server developed using [Node.js](https://nodejs.org/en/) of the [Typescript](https://www.typescriptlang.org/) Flavour.
* Containerized and deployed to AWS.
* Hosting:
  * Containers are hosted on AWS infrastructure managed with [OpenTofu](https://opentofu.org/).
  * Infrastructure consists of an ECS cluster with the EC2 launch type, continuously deploying the latest version of the backend to two availability zones.
  * An Elastic Load Balancer distributes requests across instances.

**Networking:**
* The frontend communicates with the backend using a REST API.
* Domains are managed using [Squarespace](https://domains.squarespace.com/de/).

Input on the architecture and design of Vocabmate is always welcome, as we strive to improve the tool and provide the best possible user experience.
        """,
      ),
    );
  }
}

/// A card that displays a question and optionally the answer, when the user
/// expands the card.
class _FaqCard extends StatefulWidget {
  const _FaqCard({
    required this.question,
    required this.answer,
  });

  final Widget question;
  final Widget answer;

  @override
  State<_FaqCard> createState() => _FaqCardState();
}

class _FaqCardState extends State<_FaqCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: GestureDetector(
            key: ValueKey(widget.question),
            onTap: () {
              setState(() => isExpanded = !isExpanded);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFDBAEEA),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOutQuart,
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    child: DefaultTextStyle(
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 18,
                          ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: widget.question),
                              const SizedBox(width: 8),
                              AnimatedSwap(
                                duration: const Duration(milliseconds: 275),
                                child: isExpanded
                                    ? const _HideAnswerIcon()
                                    : const _ShowAnswerIcon(),
                              ),
                            ],
                          ),
                          AnimatedSwitcher(
                            // Adding the default transitionBuilder here fixes
                            // https://github.com/flutter/flutter/issues/121336. The bug can occur
                            // when clicking the card very quickly.
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            duration:
                                Duration(milliseconds: isExpanded ? 100 : 500),
                            child: isExpanded
                                ? Column(
                                    children: [
                                      const SizedBox(height: 18),
                                      DefaultTextStyle(
                                        style: _getAnswerTextStyle(context),
                                        child: widget.answer,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShowAnswerIcon extends StatelessWidget {
  const _ShowAnswerIcon();

  @override
  Widget build(BuildContext context) {
    return const Tooltip(
      key: ValueKey('ShowAnswer'),
      message: 'Show answer',
      child: Icon(
        Icons.keyboard_arrow_down,
      ),
    );
  }
}

class _HideAnswerIcon extends StatelessWidget {
  const _HideAnswerIcon();

  @override
  Widget build(BuildContext context) {
    return const Tooltip(
      key: ValueKey('HideAnswer'),
      message: 'Hide answer',
      child: Icon(
        Icons.keyboard_arrow_up,
      ),
    );
  }
}

class _MarkdownAnswer extends StatelessWidget {
  const _MarkdownAnswer({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: text,
      onTapLink: (_, href, __) {
        if (href == null) return;
        launchUrl(Uri.parse(href));
      },
      styleSheet: MarkdownStyleSheet(
        a: _getAnswerTextStyle(context).copyWith(
          decoration: TextDecoration.underline,
        ),
        p: _getAnswerTextStyle(context),
      ),
    );
  }
}
