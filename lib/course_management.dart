
import 'package:flutter/material.dart';

class CourseManagementApp extends StatelessWidget {
  const CourseManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Management App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const CourseSplashScreen(),
    );
  }
}

class Course {
  final String name;
  final String faculty;
  final String duration;
  final String fees;
  final String description;

  const Course({
    required this.name,
    required this.faculty,
    required this.duration,
    required this.fees,
    required this.description,
  });
}

// SPLASH SCREEN
class CourseSplashScreen extends StatefulWidget {
  const CourseSplashScreen({super.key});

  @override
  State<CourseSplashScreen> createState() => _CourseSplashScreenState();
}

class _CourseSplashScreenState extends State<CourseSplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  Future<void> navigateToHome() async {
    await Future.delayed(const Duration(seconds: 10));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const CourseHomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade800,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 65,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.school,
                size: 75,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'COURSE MANAGEMENT',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Manage Your Courses Easily',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 35),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

// HOME SCREEN AND BOTTOM NAVIGATION
class CourseHomeScreen extends StatefulWidget {
  const CourseHomeScreen({super.key});

  @override
  State<CourseHomeScreen> createState() => _CourseHomeScreenState();
}

class _CourseHomeScreenState extends State<CourseHomeScreen> {
  int selectedIndex = 0;
  final List<Course> courses = [];
  Course? selectedCourse;

  void addCourse(Course course) {
    setState(() {
      courses.add(course);
      selectedCourse = course;
      selectedIndex = 2;
    });
  }

  void selectCourse(Course course) {
    setState(() {
      selectedCourse = course;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      CourseDashboard(
        totalCourses: courses.length,
        onAdd: () => setState(() => selectedIndex = 1),
        onView: () => setState(() => selectedIndex = 2),
      ),
      CourseFormScreen(onSubmit: addCourse),
      CourseListScreen(
        courses: courses,
        selectedCourse: selectedCourse,
        onCourseTap: selectCourse,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Course Management',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box_outlined),
            selectedIcon: Icon(Icons.add_box),
            label: 'Course Form',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Course List',
          ),
        ],
      ),
    );
  }
}

// HOME DASHBOARD
class CourseDashboard extends StatelessWidget {
  final int totalCourses;
  final VoidCallback onAdd;
  final VoidCallback onView;

  const CourseDashboard({
    super.key,
    required this.totalCourses,
    required this.onAdd,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Welcome!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add and manage your courses in one place.',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 25),
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.school, size: 32),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Courses',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$totalCourses',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('Add New Course'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onView,
              icon: const Icon(Icons.list),
              label: const Text('View Course List'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// COURSE FORM
class CourseFormScreen extends StatefulWidget {
  final ValueChanged<Course> onSubmit;

  const CourseFormScreen({
    super.key,
    required this.onSubmit,
  });

  @override
  State<CourseFormScreen> createState() => _CourseFormScreenState();
}

class _CourseFormScreenState extends State<CourseFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final facultyController = TextEditingController();
  final durationController = TextEditingController();
  final feesController = TextEditingController();
  final descriptionController = TextEditingController();

  void submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final course = Course(
      name: nameController.text.trim(),
      faculty: facultyController.text.trim(),
      duration: durationController.text.trim(),
      fees: feesController.text.trim(),
      description: descriptionController.text.trim(),
    );

    widget.onSubmit(course);

    nameController.clear();
    facultyController.clear();
    durationController.clear();
    feesController.clear();
    descriptionController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Course added successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    facultyController.dispose();
    durationController.dispose();
    feesController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Course Details',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 22),
            TextFormField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Course Name',
                prefixIcon: Icon(Icons.menu_book),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter course name';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: facultyController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Faculty Name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter faculty name';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: durationController,
              decoration: const InputDecoration(
                labelText: 'Duration (e.g. 6 Months)',
                prefixIcon: Icon(Icons.schedule),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter course duration';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: feesController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Fees (₹)',
                prefixIcon: Icon(Icons.currency_rupee),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter course fees';
                }

                final fees = double.tryParse(value.trim());

                if (fees == null || !fees.isFinite || fees <= 0) {
                  return 'Enter a valid fee greater than zero';
                }

                return null;
              },
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Course Description',
                prefixIcon: Icon(Icons.description),
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter course description';
                }
                return null;
              },
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: submitForm,
                icon: const Icon(Icons.save),
                label: const Text('Save Course'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// COURSE LIST AND SELECTED COURSE CARD
class CourseListScreen extends StatelessWidget {
  final List<Course> courses;
  final Course? selectedCourse;
  final ValueChanged<Course> onCourseTap;

  const CourseListScreen({
    super.key,
    required this.courses,
    required this.selectedCourse,
    required this.onCourseTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Course List',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
              Chip(label: Text('${courses.length} Courses')),
            ],
          ),
        ),
        Expanded(
          child: courses.isEmpty
              ? const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.school_outlined,
                  size: 65,
                  color: Colors.grey,
                ),
                SizedBox(height: 12),
                Text(
                  'No courses added yet.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              final isSelected = selectedCourse == course;

              return Card(
                color: isSelected
                    ? Colors.teal.shade50
                    : Colors.white,
                elevation: isSelected ? 4 : 1,
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  onTap: () => onCourseTap(course),
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal.shade100,
                    child: const Icon(
                      Icons.menu_book,
                      color: Colors.teal,
                    ),
                  ),
                  title: Text(
                    course.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${course.faculty} • ${course.duration}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              );
            },
          ),
        ),
        if (selectedCourse != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
            child: Card(
              color: Colors.teal.shade50,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.teal),
                        SizedBox(width: 8),
                        Text(
                          'Course Details',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    detailRow('Course', selectedCourse!.name),
                    detailRow('Faculty', selectedCourse!.faculty),
                    detailRow('Duration', selectedCourse!.duration),
                    detailRow('Fees', '₹${selectedCourse!.fees}'),
                    detailRow(
                      'Description',
                      selectedCourse!.description,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 105,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

