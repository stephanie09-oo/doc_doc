import 'package:flutter/material.dart';

import '../cashe_helper.dart';
import 'home_repo.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  Map<String, dynamic>? homeData;
  @override
  void initState() {
    super.initState();
    getHomeData();
  }

  Future<void> getHomeData() async {
    try {
      final data = await HomeRepo().getHomeData();

      setState(() {
        homeData = data;
      });

      print(data);
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    final username = CacheHelper.getUserName();
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FC),
      body: SafeArea(
        child: homeData == null
            ?  Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue.shade100,
                          child: Icon(
                            Icons.person,
                            color: Colors.blue.shade600,
                          ),
                        ),
                         SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              'Hi,',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              username,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:Icon(Icons.notifications_none),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey.shade500),
                          SizedBox(width: 10),
                          Text(
                            'Search doctors...',
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    ),
                     SizedBox(height: 25),
                    Text(
                      'Doctors',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(height: 15),
                    ...List.generate((homeData!['data'] ?? []).length, (index) {
                      final specialty = homeData!['data'][index];
                      final doctors = specialty['doctors'] ?? [];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            specialty['name'] ?? '',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                           SizedBox(height: 10),
                          ...List.generate(doctors.length, (doctorIndex) {
                            final doctor = doctors[doctorIndex];
                            return Container(
                              margin:EdgeInsets.only(bottom: 12),
                              padding:EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      doctor['photo'] ?? '',
                                      width: 75,
                                      height: 75,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              width: 75,
                                              height: 75,
                                              color: Colors.blue.shade50,
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.blue.shade400,
                                                size: 35,
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                  SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doctor['name'] ?? 'Doctor',
                                          style:TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          doctor['degree'] ?? '',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          doctor['city']?['name'] ?? '',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                   Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            );
                          }),
                          SizedBox(height: 15),
                        ],
                      );
                    }),
                     SizedBox(height: 80),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: Icon(Icons.search, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
