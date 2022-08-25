

import 'package:accordion/accordion.dart';
import 'package:accordion/accordion_section.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';

/// Main example page
class AccordionPage extends StatefulWidget //__
    {
  const AccordionPage({Key? key}) : super(key: key);

  @override
  State<AccordionPage> createState() => _AccordionPageState();
}

class _AccordionPageState extends State<AccordionPage> {
  final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);

  final _contentStyleHeader = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);

  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

  final _loremIpsum =
  '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';

  final List<AccordionSection> farmerAccordionList = [];

  @override
  void initState() {
    farmerAccordionList.add(AccordionSection(
      isOpen: true,
      leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
      headerBackgroundColor: Colors.black,
      headerBackgroundColorOpened: Colors.red,
      header: Text('Farmer', style: _headerStyle),
      content: farmerForm(),
      contentHorizontalPadding: 20,
      contentBorderWidth: 1,
      // onOpenSection: () => print('onOpenSection ...'),
      // onCloseSection: () => print('onCloseSection ...'),
    ));
    super.initState();
  }

  @override
  build(context) => Scaffold(
    backgroundColor: Colors.blueGrey[100],
    appBar: AppBar(
      title: const Text('Accordion'),
    ),
    body: Column(
      children: [
        Accordion(
          maxOpenSections: 1,
          headerBackgroundColorOpened: Colors.black54,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          headerPadding:
          const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: farmerAccordionList,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(8)),
            child: MaterialButton(
              onPressed: () {
                farmerAccordionList.add(farmerAccordionList[0]);
                setState(() {});
              },
              child: const Text(
                "Add Farmer",
                style: TextStyle(color: Colors.white),
              ),
            ))
      ],
    ),
  );

  Widget farmerForm() {
    return Column(
      children: const [TextField(), TextField(), TextField()],
    );
  }
}