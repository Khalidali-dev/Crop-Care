// ============================================
// ADMIN DASHBOARD - SAFE VERSION (NO PROVIDER)
// ============================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutConfirmation(context),
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(),
            const SizedBox(height: 20),

            _buildQuickStats(),
            const SizedBox(height: 20),

            _buildQuickActions(),
            const SizedBox(height: 30),

            // EMPLOYEE APPROVAL (SAMPLE DATA)
            const Text(
              'Pending Employee Approvals',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                children: const [
                  _EmployeeCard(name: 'Ali Khan', email: 'ali@gmail.com'),
                  _EmployeeCard(name: 'Ahmed Raza', email: 'ahmed@gmail.com'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // DRAWER
  // ============================================
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.admin_panel_settings,
                    size: 40,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Administrator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'admin@cropcare.com',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Manage Employees'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => _showLogoutConfirmation(context),
          ),
        ],
      ),
    );
  }

  // ============================================
  // WELCOME CARD
  // ============================================
  Widget _buildWelcomeCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: const [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.admin_panel_settings,
                size: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, Administrator!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Chip(
                  label: Text('ADMIN', style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // QUICK STATS
  // ============================================
  Widget _buildQuickStats() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.5,
      children: const [
        _StatCard(title: 'Employees', value: '24', icon: Icons.people),
        _StatCard(title: 'Active', value: '18', icon: Icons.check_circle),
        _StatCard(title: 'Pending', value: '2', icon: Icons.pending),
        _StatCard(title: 'Revenue', value: '₹1,25,430', icon: Icons.money),
      ],
    );
  }

  // ============================================
  // QUICK ACTIONS
  // ============================================
  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            _ActionCard(title: 'Add Employee', icon: Icons.person_add),
            _ActionCard(title: 'Reports', icon: Icons.analytics),
            _ActionCard(title: 'Settings', icon: Icons.settings),
          ],
        ),
      ],
    );
  }

  // ============================================
  // LOGOUT
  // ============================================
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Get.offAllNamed('/start'); // back to start screen
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

// ============================================
// EMPLOYEE CARD (SAMPLE)
// ============================================

class _EmployeeCard extends StatelessWidget {
  final String name;
  final String email;

  const _EmployeeCard({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(name),
        subtitle: Text(email),
        trailing: ElevatedButton(
          onPressed: () {
            Get.snackbar('Approved', '$name approved');
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text('APPROVE'),
        ),
      ),
    );
  }
}

// ============================================
// SMALL WIDGETS
// ============================================

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 18)),
          Text(title),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _ActionCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30),
            const SizedBox(height: 6),
            Text(title),
          ],
        ),
      ),
    );
  }
}
