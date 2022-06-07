//import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thesis/pages/exercise_page_test_2.dart';

class ExerciseUnit extends StatefulWidget {
  final String courseID;
  final String categoryID;
  final String sentenceID;
  final String languageTo = 'English';
  final String languageFrom = 'Russian';
  final double _progressValue = 0;

  final int startAt;

  //final _random = new Random();

  const ExerciseUnit(
      {Key? key,
        required this.sentenceID,
        required this.courseID,
        required this.categoryID,
        required this.startAt,
      }) : super(key: key);
  static const routeName = '/unit';
  @override
  _ExerciseUnitState createState() => _ExerciseUnitState();
}

class _ExerciseUnitState extends State<ExerciseUnit> {

  late String _sentenceID;

  late DocumentSnapshot<Map<String, dynamic>> _taskData;

  TextEditingController _controller = TextEditingController();

  Widget _sentenceWidget = LinearProgressIndicator();
  Widget _labelWidget = LinearProgressIndicator();
  Widget _inputWidget = CircularProgressIndicator();
  Widget _progressWidget = LinearProgressIndicator(value: 0);
  Widget _inputMode = Text('Loading..');
  Widget _checkWidget = Text('Loading..');

  bool _isButtonDisabled = true;
  bool? _rightAnswer = null;
  bool _textFieldEnabled = true;
  bool _checked = false;

  String _text = '';

  void initState() {
    //super.initState();

    setProgress(widget._progressValue);
    setLabel(widget.languageFrom);
    getExerciseDataUnit('base', widget.sentenceID);

    _controller.addListener(() {
      _text = _controller.text; //.toLowerCase();
      final String text = _controller.text; //.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
      //_text.length>0 ? print(_text[_text.length-1]) : print(_text.length);
    } // ToDo make function
        );

    // these two are bounded together
    setInputMode(widget.languageFrom);
    setInputMethod(_inputMode);
    // the end of the bounding

    _rightAnswer == null
        ? setCheckArea(_isButtonDisabled)
        : setNextArea(_rightAnswer);
  }

  void checking() {
    if (_text != '') {
      _rightAnswer = answerStatus();
      _textFieldEnabled = false;
      _checked = true;
      initState();
    }
  }

  void nextUnit() {

    /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return ExerciseUnit(sentenceID: 'a_black_shirt', courseID: '', categoryID: '',);
    }));*/

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return ExPgTest2(
        courseID: widget.courseID,
        categoryID: widget.categoryID,
        startAt: widget.startAt+1,
      );
    }));
  }

  Future<void> getExerciseDataUnit(courseID, sentenceID) async {
    final DocumentReference<Map<String, dynamic>> _docRef = FirebaseFirestore
        .instance
        .collection('courses')
        .doc(courseID)
        .collection('sentences')
        .doc(sentenceID);
    _taskData = await _docRef.get();
    setState(() => _sentenceWidget = Text(_taskData['sentence']));
  }

  Future<void> setLabel(language) async {
    setState(() => _labelWidget = Text("Write in $language",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        )
    ));
  }

  Future<void> setInputMode(language) async {
    //print('setInputMode started');
    //print('_textFieldEnabled = $_textFieldEnabled');
    TextStyle textStyle = const TextStyle();
    if (_rightAnswer != null) if (_rightAnswer == true) {
      textStyle = TextStyle(color: Colors.green);
    } else {
      textStyle = TextStyle(color: Colors.red);
    }

    _inputMode = Padding(
        padding: const EdgeInsets.all(50),
        child: Focus(
          onKey: (FocusNode node, RawKeyEvent event) {

            if (event is RawKeyDownEvent){
              if (event.logicalKey == LogicalKeyboardKey.enter ||
                  event.logicalKey == LogicalKeyboardKey.numpadEnter) {
                if (!_checked) {
                  checking();
                  return KeyEventResult.handled;
                } else {
                  nextUnit();
                  return KeyEventResult.handled;
                }
              } else {
                if (_textFieldEnabled) {
                  return KeyEventResult.ignored;
                } else {
                  return KeyEventResult.handled;
                }
              }
            } else {
              return KeyEventResult.handled;
            }
          },
          child: TextFormField(
              style: textStyle,
              //enabled: _textFieldEnabled,
              controller: _controller,
              decoration: new InputDecoration(
                hintText: "Type in $language ",
                contentPadding: EdgeInsets.all(20),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onChanged: (value) {
                _isButtonDisabled = value.isEmpty;
                setCheckArea(_isButtonDisabled);
              }),
        ));
  }

  Future<void> setInputMethod(method) async {
    setState(() => _inputWidget = method);
  }

  Future<void> setProgress(progress) async {
    setState(() => _progressWidget = LinearProgressIndicator(value: progress));
  }

  Future<void> setCheckArea(isButtonDisabled) async {
    //print('setCheck function is working');
    Color color;
    if (isButtonDisabled) {
      color = Colors.grey;
    } else {
      color = Theme.of(context).colorScheme.primary;
    }

    setState(() => _checkWidget = IgnorePointer(
          ignoring: _text == '',
          child: TextButton.icon(
            icon: Icon(Icons.check, color: color),
            label: Text('Check', style: TextStyle(color: color)),
            onPressed: () {
              checking();
            },
          ),
        ));
  }

  Future<void> setNextArea(rightAnswer) async {
    //print('setNext function is working');
    Icon icon;
    String translation;
    if (rightAnswer) {
      icon = Icon(FontAwesomeIcons.checkDouble, color: Colors.green);
      translation = 'Great!';
    } else {
      icon = Icon(FontAwesomeIcons.notEqual, color: Colors.red);
      translation = _taskData['translation'];
    }

    setState(() => _checkWidget = Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              Text(translation),
              icon,
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              TextButton.icon(
                icon: Icon(Icons.arrow_forward, color: Colors.green),
                label: Text('Next', style: TextStyle(color: Colors.green)),
                onPressed: () {
                  //print('next task');
                  nextUnit();
                },
              ),
            ],
          ),
        ));
  }

  bool answerStatus() {
    print(_taskData['translation']);
    print(_text);
    return _taskData['translation'] == _text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _progressWidget,
            Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
            _labelWidget,
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            _sentenceWidget,
            _inputWidget,
            _checkWidget,
          ]),
    );
  }
}
