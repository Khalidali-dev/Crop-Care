// ============================================
// EMPLOYEE DASHBOARD
// ============================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../../../providers/auth_provider.dart';

class EmployeeDashboard extends StatelessWidget {
  const EmployeeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Dashboard'),
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
            // Welcome Card
            _buildWelcomeCard(context),
            const SizedBox(height: 20),

            // Today's Tasks
            _buildTasksSection(),
            const SizedBox(height: 20),

            // Quick Actions
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  // ============================================
  // BUILD DRAWER
  // ============================================
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.badge,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10),
                Consumer<AuthProvider>(
                  builder: (context, provider, child) {
                    return const Text(
                      'Employee',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                Consumer<AuthProvider>(
                  builder: (context, provider, child) {
                    return Text(
                      'employee@cropcare.com',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Menu Items
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('My Tasks'),
            onTap: () {
              // Navigate to tasks
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Purchases'),
            onTap: () {
              // Navigate to purchases
            },
          ),
          ListTile(
            leading: const Icon(Icons.sell),
            title: const Text('Sales'),
            onTap: () {
              // Navigate to sales
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Inventory'),
            onTap: () {
              // Navigate to inventory
            },
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
  // BUILD WELCOME CARD
  // ============================================
  Widget _buildWelcomeCard(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.badge,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome, Employee!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'employee@cropcare.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Chip(
                    label: const Text(
                      'EMPLOYEE',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // BUILD TASKS SECTION
  // ============================================
  Widget _buildTasksSection() {
    final tasks = [
      {'title': 'Record morning purchases', 'time': '9:00 AM', 'done': true},
      {'title': 'Update inventory', 'time': '11:00 AM', 'done': true},
      {'title': 'Process sales orders', 'time': '2:00 PM', 'done': false},
      {'title': 'Submit daily report', 'time': '4:00 PM', 'done': false},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's Tasks",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: tasks.map((task) {
                return ListTile(
                  leading: Checkbox(
                    value: task['done'] as bool,
                    onChanged: (value) {},
                  ),
                  title: Text(task['title']!.toString()??''),
                  subtitle: Text(task['time']!.toString()??''),
                  trailing: const Icon(Icons.more_vert),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================
  // BUILD QUICK ACTIONS
  // ============================================
  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _buildActionCard(
              title: 'Add Purchase',
              icon: Icons.shopping_bag,
              color: Colors.green,
              onTap: () {},
            ),
            _buildActionCard(
              title: 'Add Sale',
              icon: Icons.shopping_cart,
              color: Colors.blue,
              onTap: () {},
            ),
            _buildActionCard(
              title: 'Inventory',
              icon: Icons.inventory,
              color: Colors.orange,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: color,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================
  // SHOW LOGOUT CONFIRMATION
  // ============================================
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await context.read<AuthProvider>().logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('LOGOUT'),
            ),
          ],
        );
      },
    );
  }
}