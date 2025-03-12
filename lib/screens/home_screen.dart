import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            // Menü-Logik
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              // Benachrichtigungs-Logik
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildProfileHeader(),
              SizedBox(height: 24),
              _buildProgressSection(),
              SizedBox(height: 24),
              _buildHealthDataSection(),
              SizedBox(height: 24),
              _buildNutritionSection(),
              SizedBox(height: 24),
              _buildTrainingDiagram(),
              SizedBox(height: 24),
              _buildNutritionDiagram(),
              SizedBox(height: 24),
              _buildQuickWorkout(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildHealthDataSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Health Data',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildHealthDataItem('10,000', 'Steps'),
            _buildHealthDataItem('150', 'BPM'),
            _buildHealthDataItem('8', 'Hours Sleep'),
          ],
        ),
      ],
    );
  }

  Widget _buildHealthDataItem(String value, String label) {
    return Column(
      children: <Widget>[
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: <Widget>[
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[900], // Dunkelgrauer Hintergrund
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello,',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
            Text(
              'John Doe',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Pro',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nutrition',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildNutritionItem('2,500', 'Calories'),
            _buildNutritionItem('150', 'Protein'),
            _buildNutritionItem('50', 'Carbs'),
          ],
        ),
      ],
    );
  }

  Widget _buildNutritionItem(String value, String label) {
    return Column(
      children: <Widget>[
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildTrainingDiagram() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Training Diagram',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Container(
          height: 200,
          color: Colors.grey[900], // Platzhalter für Diagramm
          child: Center(
            child: Text(
              'Training Diagram Here',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionDiagram() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nutrition Diagram',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Container(
          height: 200,
          color: Colors.grey[900], // Platzhalter für Diagramm
          child: Center(
            child: Text(
              'Nutrition Diagram Here',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickWorkout() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.redAccent, // Akzentfarbe
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Text(
          'Quick Workout',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Your Progress',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Weeks',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildProgressItem('16', 'Workout'),
            _buildProgressItem('10412', 'Kcal'),
            _buildProgressItem('03:21', 'Minute'),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildProgressWeek('24'),
            _buildProgressWeek('25'),
            _buildProgressWeek('25'),
            _buildProgressWeek('27'),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressItem(String value, String label) {
    return Column(
      children: <Widget>[
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildProgressWeek(String week) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        week,
        style: GoogleFonts.poppins(color: Colors.white),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Category',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'See All',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              _buildCategoryChip('All'),
              SizedBox(width: 8),
              _buildCategoryChip('Chest'),
              SizedBox(width: 8),
              _buildCategoryChip('Back'),
              SizedBox(width: 8),
              _buildCategoryChip('Arms'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String category) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category,
        style: GoogleFonts.poppins(color: Colors.white),
      ),
    );
  }

  Widget _buildPopularSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Popular',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'See All',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              _buildWorkoutCard(
                'Arm Power Boost',
                'Intermediate',
                'assets/arm_workout.jpg',
                'Strength Starter',
                '15 Minute',
              ),
              SizedBox(width: 16),
              _buildWorkoutCard(
                'Shoulder Flex Stability',
                'Intermediate',
                'assets/shoulder_workout.jpg',
                'Endurance Builder',
                '20 Minute',
              ),
              SizedBox(width: 16),
              _buildWorkoutCard(
                'Leg Poses',
                'Intermediate',
                'assets/leg_workout.jpg',
                'Power Soulnt',
                '45 Minute',
              ),
            ],
          ),
        ),
      ],
    );
  }

Widget _buildIntermediateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Intermediate',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'See All',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              _buildWorkoutCard(
                'Arm Power Boost',
                'Intermediate',
                'assets/arm_workout.jpg',
                'Strength Starter',
                '15 Minute',
              ),
              SizedBox(width: 16),
              _buildWorkoutCard(
                'Endurance Builder',
                'Intermediate',
                'assets/endurance_workout.jpg',
                'Endurance Builder',
                '20 Minute',
              ),
              SizedBox(width: 16),
              _buildWorkoutCard(
                'Power Soulnt',
                'Intermediate',
                'assets/power_workout.jpg',
                'Power Soulnt',
                '45 Minute',
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildWorkoutCard(
    String title, String level, String imagePath, String subtitle, String duration) {
  return Container(
    width: 200,
    decoration: BoxDecoration(
      color: Colors.grey[900], // Dunkelgrauer Hintergrund
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          child: Image.asset(
            imagePath,
            width: 200,
            height: 120, // Höhe des Bildes
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                level,
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      subtitle,
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                  Text(
                    duration,
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
Widget _buildTrainWithMeButton() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      color: Colors.orange, // Orange Hintergrund
      borderRadius: BorderRadius.circular(24),
    ),
    child: Center(
      child: Text(
        'Train with Me!',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}