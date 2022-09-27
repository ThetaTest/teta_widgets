// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teta_core/src/design_system/dialogs/cms/db/custom_query_documentation.dart';
import 'package:teta_core/src/utils/code_text_field/code_text_field.dart';
import 'package:teta_core/src/utils/code_theme.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class CodeFieldControl extends StatefulWidget {
  const CodeFieldControl({
    required this.value,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FTextTypeInput value;
  final Function(FTextTypeInput, FTextTypeInput) callBack;

  @override
  CodeFieldControlState createState() => CodeFieldControlState();
}

class CodeFieldControlState extends State<CodeFieldControl> {
  final CodeController codeController = CodeController(
    theme: tetaTheme,
  );
  bool isChanged = false;

  @override
  void initState() {
    codeController
      ..text = widget.value.value ?? ''
      ..addListener(() {
        setState(() {
          isChanged = true;
        });
      });
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const THeadline3(
              'Write your query using AYAYA',
            ),
            CButton(
              label: 'Docs',
              isPrimary: false,
              maxWidth: 80,
              callback: () {
                showDialog<void>(
                  context: context,
                  builder: (final context) =>
                      const CustomQueryDocumentationAlert(),
                );
              },
            ),
          ],
        ),
        const Gap(Grid.small),
        SizedBox(
          height: 350,
          child: CodeField(
            controller: codeController,
            withRightPadding: false,
            lineNumberBuilder: (final index, final style) {
              return TextSpan(
                text: index.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              );
            },
            lineNumberStyle: LineNumberStyle(
              textStyle: GoogleFonts.sourceCodePro(
                fontSize: 14,
                height: 1.6,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
              ),
            ),
            textStyle: GoogleFonts.sourceCodePro(
              fontSize: 14,
              height: 1.6,
              fontWeight: FontWeight.normal,
            ),
            wrap: true,
          ),
        ),
        const Gap(Grid.small),
        CButton(
          label: 'Confirm',
          isPrimary: isChanged,
          callback: () {
            if (isChanged) {
              final old = widget.value;
              widget.value.value = codeController.text;
              widget.callBack(widget.value, old);
              setState(() {
                isChanged = false;
              });
            }
          },
        ),
      ],
    );
  }
}
