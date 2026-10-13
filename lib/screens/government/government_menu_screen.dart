import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GovernmentMenuScreen extends StatefulWidget {
  const GovernmentMenuScreen({super.key});

  @override
  State<GovernmentMenuScreen> createState() => _GovernmentMenuScreenState();
}

class _GovernmentMenuScreenState extends State<GovernmentMenuScreen> {
  // Track which sections are expanded
  final Map<String, bool> _expandedState = {
    'zones': false,
    'cities': false,
    'regional_sectors': false,
    'kebeles': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Government'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Regional Sectors - Expandable
          _buildExpandableMenuItem(
            context,
            icon: Icons.account_balance,
            title: 'Regional Sectors',
            subtitle: 'Government bureaus and offices',
            color: Colors.blue,
            isExpanded: _expandedState['regional_sectors'] ?? false,
            onTap: () => _toggleSection('regional_sectors'),
            children: [
              _buildSubMenuItem(
                context,
                title: 'Health Bureau',
                subtitle: 'Public health services',
                onTap: () => context.push('/government/regional-sectors'),
              ),
              _buildSubMenuItem(
                context,
                title: 'Education Bureau',
                subtitle: 'Schools and universities',
                onTap: () => context.push('/government/regional-sectors'),
              ),
              _buildSubMenuItem(
                context,
                title: 'Communication Bureau',
                subtitle: 'Public communication',
                onTap: () => context.push('/government/regional-sectors'),
              ),
              _buildSubMenuItem(
                context,
                title: 'View All Sectors →',
                subtitle: 'Show all 12 sectors',
                onTap: () => context.push('/government/regional-sectors'),
                isViewAll: true,
              ),
            ],
          ),

          // Zones - Expandable
          _buildExpandableMenuItem(
            context,
            icon: Icons.location_city,
            title: 'Zones',
            subtitle: 'Administrative zones of Oromia',
            color: Colors.green,
            isExpanded: _expandedState['zones'] ?? false,
            onTap: () => _toggleSection('zones'),
            children: [
              _buildSubMenuItem(
                context,
                title: 'Arsi Zone',
                subtitle: '12 Woredas',
                onTap: () => context.push('/government/hierarchy/zone'),
              ),
              _buildSubMenuItem(
                context,
                title: 'Bale Zone',
                subtitle: '8 Woredas',
                onTap: () => context.push('/government/hierarchy/zone'),
              ),
              _buildSubMenuItem(
                context,
                title: 'Borena Zone',
                subtitle: '10 Woredas',
                onTap: () => context.push('/government/hierarchy/zone'),
              ),
              _buildSubMenuItem(
                context,
                title: 'View All Zones →',
                subtitle: 'Show all 12 zones',
                onTap: () => context.push('/government/hierarchy/zone'),
                isViewAll: true,
              ),
            ],
          ),

          // Woredas - Expandable (nested hint)
          _buildExpandableMenuItem(
            context,
            icon: Icons.map,
            title: 'Woredas',
            subtitle: 'Districts within zones',
            color: Colors.orange,
            isExpanded: _expandedState['woredas'] ?? false,
            onTap: () => _toggleSection('woredas'),
            children: [
              _buildSubMenuItem(
                context,
                title: 'Browse by Zone First',
                subtitle: 'Select a zone to see its woredas',
                onTap: () => context.push('/government/hierarchy/zone'),
                isHint: true,
              ),
              _buildSubMenuItem(
                context,
                title: 'View All Woredas →',
                subtitle: 'Direct access to all woredas',
                onTap: () => context.push('/government/hierarchy/zone'),
                isViewAll: true,
              ),
            ],
          ),

          // Cities - Expandable
          _buildExpandableMenuItem(
            context,
            icon: Icons.apartment,
            title: 'Cities',
            subtitle: 'Urban administrations',
            color: Colors.purple,
            isExpanded: _expandedState['cities'] ?? false,
            onTap: () => _toggleSection('cities'),
            children: [
              _buildSubMenuItem(
                context,
                title: 'Adama',
                subtitle: '5 Sub-Cities',
                onTap: () => context.push('/government/hierarchy/city'),
              ),
              _buildSubMenuItem(
                context,
                title: 'Jimma',
                subtitle: '4 Sub-Cities',
                onTap: () => context.push('/government/hierarchy/city'),
              ),
              _buildSubMenuItem(
                context,
                title: 'Bishoftu',
                subtitle: '3 Sub-Cities',
                onTap: () => context.push('/government/hierarchy/city'),
              ),
              _buildSubMenuItem(
                context,
                title: 'View All Cities →',
                subtitle: 'Show all 5 cities',
                onTap: () => context.push('/government/hierarchy/city'),
                isViewAll: true,
              ),
            ],
          ),

          // Sub-Cities - Expandable (nested hint)
          _buildExpandableMenuItem(
            context,
            icon: Icons.place,
            title: 'Sub-Cities',
            subtitle: 'City subdivisions',
            color: Colors.teal,
            isExpanded: _expandedState['sub_cities'] ?? false,
            onTap: () => _toggleSection('sub_cities'),
            children: [
              _buildSubMenuItem(
                context,
                title: 'Browse by City First',
                subtitle: 'Select a city to see its sub-cities',
                onTap: () => context.push('/government/hierarchy/city'),
                isHint: true,
              ),
              _buildSubMenuItem(
                context,
                title: 'View All Sub-Cities →',
                subtitle: 'Direct access to all sub-cities',
                onTap: () => context.push('/government/hierarchy/city'),
                isViewAll: true,
              ),
            ],
          ),

          // Kebeles - Expandable (nested hint)
          _buildExpandableMenuItem(
            context,
            icon: Icons.house,
            title: 'Kebeles',
            subtitle: 'The smallest administrative unit',
            color: Colors.brown,
            isExpanded: _expandedState['kebeles'] ?? false,
            onTap: () => _toggleSection('kebeles'),
            children: [
              _buildSubMenuItem(
                context,
                title: 'Via Zone → Woreda',
                subtitle: 'Browse through administrative hierarchy',
                onTap: () => context.push('/government/hierarchy/zone'),
              ),
              _buildSubMenuItem(
                context,
                title: 'Via City → Sub-City',
                subtitle: 'Browse through urban hierarchy',
                onTap: () => context.push('/government/hierarchy/city'),
              ),
              _buildSubMenuItem(
                context,
                title: 'View All Kebeles →',
                subtitle: 'Direct access to all kebeles',
                onTap: () => context.push('/government/hierarchy/zone'),
                isViewAll: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleSection(String key) {
    setState(() {
      _expandedState[key] = !(_expandedState[key] ?? false);
    });
  }

  Widget _buildExpandableMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required bool isExpanded,
    required VoidCallback onTap,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color),
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.grey,
            ),
            onTap: onTap,
          ),
          // Expanded content
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                children: children,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSubMenuItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isViewAll = false,
    bool isHint = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: isViewAll
            ? const Color(0xFFc0392b).withOpacity(0.08)
            : isHint
                ? Colors.grey.withOpacity(0.05)
                : Colors.grey.withOpacity(0.03),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        leading: isViewAll
            ? const Icon(Icons.trending_flat, size: 16, color: Color(0xFFc0392b))
            : isHint
                ? const Icon(Icons.info_outline, size: 16, color: Colors.grey)
                : const Icon(Icons.circle, size: 8, color: Color(0xFFc0392b)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: isViewAll ? 14 : 14,
            fontWeight: isViewAll ? FontWeight.w600 : FontWeight.normal,
            color: isViewAll ? const Color(0xFFc0392b) : Colors.black87,
          ),
        ),
        subtitle: subtitle.isNotEmpty
            ? Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              )
            : null,
        trailing: isViewAll
            ? const Icon(Icons.arrow_forward, size: 16, color: Color(0xFFc0392b))
            : const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}