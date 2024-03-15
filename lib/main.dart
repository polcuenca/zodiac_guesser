import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zodiac App',
      theme: ThemeData(
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.grey)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> zodiacSigns = [
    {
      'name': 'Error',
      'image': 'what.png',
      'date': DateTimeRange(start: DateTime(0, 0, 0), end: DateTime(0, 40, 0)),
    },
    {
      'name': 'Capricorn',
      'image': 'capricorn.png',
      'date': DateTimeRange(
          start: DateTime(2022, 1, 1), end: DateTime(2022, 1, 19)),
    },
    {
      'name': 'Aries',
      'image': 'aries.png',
      'date': DateTimeRange(
          start: DateTime(2022, 3, 21), end: DateTime(2022, 4, 19)),
    },
    {
      'name': 'Taurus',
      'image': 'taurus.png',
      'date': DateTimeRange(
          start: DateTime(2022, 4, 20), end: DateTime(2022, 5, 20)),
    },
    {
      'name': 'Gemini',
      'image': 'gemini.png',
      'date': DateTimeRange(
          start: DateTime(2022, 5, 21), end: DateTime(2022, 6, 20)),
    },
    {
      'name': 'Cancer',
      'image': 'cancer.png',
      'date': DateTimeRange(
          start: DateTime(2022, 6, 21), end: DateTime(2022, 7, 22)),
    },
    {
      'name': 'Leo',
      'image': 'leo.png',
      'date': DateTimeRange(
          start: DateTime(2022, 7, 23), end: DateTime(2022, 8, 22)),
    },
    {
      'name': 'Virgo',
      'image': 'virgo.png',
      'date': DateTimeRange(
          start: DateTime(2022, 8, 23), end: DateTime(2022, 9, 22)),
    },
    {
      'name': 'Libra',
      'image': 'libra.png',
      'date': DateTimeRange(
          start: DateTime(2022, 9, 23), end: DateTime(2022, 10, 22)),
    },
    {
      'name': 'Scorpio',
      'image': 'scorpio.png',
      'date': DateTimeRange(
          start: DateTime(2022, 10, 23), end: DateTime(2022, 11, 21)),
    },
    {
      'name': 'Sagittarius',
      'image': 'sagittarius.png',
      'date': DateTimeRange(
          start: DateTime(2022, 11, 22), end: DateTime(2022, 12, 21)),
    },
    {
      'name': 'Capricorn',
      'image': 'capricorn.png',
      'date': DateTimeRange(
          start: DateTime(2022, 12, 22), end: DateTime(2022, 12, 31)),
    },
    {
      'name': 'Aquarius',
      'image': 'aquarius.png',
      'date': DateTimeRange(
          start: DateTime(2022, 1, 20), end: DateTime(2022, 2, 18)),
    },
    {
      'name': 'Pisces',
      'image': 'pisces.png',
      'date': DateTimeRange(
          start: DateTime(2022, 2, 19), end: DateTime(2022, 3, 20)),
    },
  ];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  String name = '';
  final TextEditingController _dateController = TextEditingController();

  late DateTime _birthdate = DateTime.now();
  int _currIndex = 0;
  bool _Switched = false;
  bool _isChanged = false;

  Future<void> _setBirthdate(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: _birthdate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
    ).then((date) async {
      if (date != null) {
        setState(() {
          _birthdate = date;
          _dateController.text = '${date.day}/${date.month}/${date.year}';
        });

        await Future.delayed(const Duration(milliseconds: 400));
        _showZodiacSign();
      }
    });
  }

  Future<void> _showZodiacSign() async {
    if (_formKey.currentState!.validate()) {
      // Check if the birthdate is within the zodiac signs range of date
      for (int i = 0; i < zodiacSigns.length; i++) {
        final DateTime start = DateTime(
            _birthdate.year,
            zodiacSigns[i]['date'].start.month,
            zodiacSigns[i]['date'].start.day);
        final DateTime end = DateTime(_birthdate.year,
            zodiacSigns[i]['date'].end.month, zodiacSigns[i]['date'].end.day);

        bool isBeforeOrSame =
            start.isBefore(_birthdate) || start.isAtSameMomentAs(_birthdate);
        bool isAfterOrSame =
            end.isAfter(_birthdate) || end.isAtSameMomentAs(_birthdate);

        if (isBeforeOrSame && isAfterOrSame) {
          setState(() {
            _currIndex = i;
            _Switched = !_Switched;
            _isChanged = true;
          });

          break;
        }
      }
    }
  }

  String formatDate(DateTime date) {
    final monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    return "${monthNames[date.month - 1]} ${date.day}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      backgroundColor: Color(0xff111017),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/cards/${zodiacSigns[_currIndex]['image']}'),
                      fit: BoxFit.cover,
                    )),
                width: 170 * 1.5,
                height: 240 * 1.5,
              ),
              const SizedBox(height: 20.0),
              Column(
                children: [
                  Text(
                    _nameController.text.isEmpty
                        ? ''
                        : 'User: ${_nameController.text}',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    _nameController.text.isEmpty
                        ? ''
                        : 'Zodiac Sign: ${zodiacSigns[_currIndex]['name']}',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    _nameController.text.isEmpty
                        ? ''
                        : 'Birthday: ${formatDate(_birthdate)}',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: _nameController,
                validator: (name) => name == null || name.isEmpty
                    ? 'Please enter your name'
                    : null,
                decoration: InputDecoration(
                  label: const Text(
                    'Name',
                    style: TextStyle(color: Colors.grey),
                  ),
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xffFFD700), width: 2),
                      borderRadius: BorderRadius.circular(15)),
                ),
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                onTap: () => _setBirthdate(context),
                validator: (date) => date == null || date.isEmpty
                    ? 'Please enter your birthdate'
                    : null,
                decoration: InputDecoration(
                  labelText: 'Birthdate',
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintText: _dateController.text.isEmpty
                      ? 'dd/mm/yyyy'
                      : _dateController.text,
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  suffixIcon:
                      Icon(Icons.calendar_month, color: Color(0xffFFD700)),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      title: Text(
        'ZODIAC SIGN',
        style: TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Color(0xff111017),
    );
  }
}
