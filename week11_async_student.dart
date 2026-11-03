// PC16 - Week 11: Your Turn - Add Async Behavior to Your OOP App
// Individual task: OOP classes (Week 9-10) + a Future-returning async method.

// ---------- Base class ----------
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void introduce() {
    print('Hi, I am $name and I am $age years old.');
  }
}

// ---------- Derived class ----------
class Student extends Person {
  String studentId;
  String course;

  Student(String name, int age, this.studentId, this.course)
      : super(name, age);

  @override
  void introduce() {
    super.introduce();
    print('Student ID: $studentId | Course: $course');
  }

  // NEW: async method that returns a Future<String>.
  // It simulates saving this student's record to a server.
  Future<String> saveRecord() async {
    print('Saving record for $name... please wait.');

    // Simulate a 3-second delay (like a slow network or database).
    await Future.delayed(Duration(seconds: 3));

    return 'Record for $name ($studentId) saved successfully!';
  }
}

// ---------- main() is marked async so we can use await ----------
Future<void> main() async {
  print('=== Program started ===');

  Student student = Student('Ana Reyes', 19, '2026-0042', 'BS Information Technology');
  student.introduce();

  print('\nCalling saveRecord()...');

  // Start the save. This returns a Future immediately (does not block).
  Future<String> pendingResult = student.saveRecord();

  // This prints right away, BEFORE the delayed result is ready.
  print('This message appears BEFORE the save finishes (non-blocking!).');

  // await pauses only main() until the Future completes.
  String result = await pendingResult;

  // Only printed once the result is ready.
  print(result);

  print('=== Program finished ===');
}
