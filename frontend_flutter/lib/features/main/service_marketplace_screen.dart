// lib/features/main/service_marketplace_screen.dart

import 'package:flutter/material.dart';
import '../../models/service_model.dart';
import '../../widgets/service/service_card.dart';
import '../../widgets/service/category_selector.dart';
import '../../widgets/service/nearby_provider_tile.dart';
import './service_detail_screen.dart';

class ServiceMarketplaceScreen extends StatefulWidget {
  const ServiceMarketplaceScreen({super.key});

  @override
  State<ServiceMarketplaceScreen> createState() => _ServiceMarketplaceScreenState();
}

class _ServiceMarketplaceScreenState extends State<ServiceMarketplaceScreen> {
  int _activeCategoryIndex = 0;

  // --- LOCAL MOCK PAYLOAD DATA ---
  final List<Map<String, dynamic>> _categories = const [
    {'label': 'Tất cả', 'icon': Icons.grid_view_rounded},
    {'label': 'Sửa chữa thiết bị', 'icon': Icons.computer_rounded},
    {'label': 'Cho thuê thiết bị', 'icon': Icons.precision_manufacturing_rounded},
  ];

  final List<ServiceModel> _allServices = const [
    ServiceModel(
      id: '1',
      title: 'Chẩn đoán & Sửa chữa Toàn diện',
      subtitle: 'Sửa laptop, sửa PC, diệt virus',
      providerName: 'TechPro VN',
      price: '450.000 VND',
      rating: 4.9,
      tags: ['Repair', 'Warranty', 'Fast Delivery'],
    ),
    ServiceModel(
      id: '2',
      title: 'Lắp ráp PC Gaming Cấu hình cao',
      subtitle: 'Thay thế linh kiện & tối ưu hóa hiệu năng phần cứng',
      providerName: 'Linh System',
      price: '75.000.000 VND',
      rating: 5.0,
      tags: ['Repair', 'Expert Only'],
    ),
    ServiceModel(
      id: '3',
      title: 'Combo Máy PS5 & Kính thực tế ảo VR',
      subtitle: 'Thuê máy chơi game thế hệ mới kèm 2 tay cầm dualsense',
      providerName: 'BrokerViet Core Rental',
      price: '30.000 VND/ngày',
      rating: 4.8,
      tags: ['Rental', 'Gaming Device'],
    ),
    ServiceModel(
      id: '4',
      title: 'Bộ Màn hình Creator 4K & Máy ảnh',
      subtitle: 'Thiết lập không gian studio chuyên nghiệp & đa màn hình',
      providerName: 'Danang Tech Equipment',
      price: '50.000 VND/ngày',
      rating: 4.7,
      tags: ['Rental', 'Monitors'],
    ),
  ];

  final List<Map<String, String>> _nearbyProviders = const [
    {'name': 'TechPro VN', 'distance': 'Cách đây 0.8 km', 'score': '4.9'},
    {'name': 'Linh System', 'distance': 'Cách đây 1.2 km', 'score': '4.8'},
    {'name': 'FixIt Fast', 'distance': 'Cách đây 2.5 km', 'score': '4.7'},
  ];

  List<ServiceModel> get _filteredServices {
    return _allServices.where((service) {
      if (_activeCategoryIndex == 0) return true;
      if (_activeCategoryIndex == 1) return service.tags.contains('Repair');
      if (_activeCategoryIndex == 2) return service.tags.contains('Rental');
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredServices;
    final currentCategoryLabel = _categories[_activeCategoryIndex]['label'];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          _buildSearchBar(),
          const SizedBox(height: 24),
          _buildSectionHeader('Danh mục dịch vụ'),
          const SizedBox(height: 12),
          CategorySelector(
            activeIndex: _activeCategoryIndex,
            categories: _categories,
            onCategorySelected: (index) => setState(() => _activeCategoryIndex = index),
          ),
          const SizedBox(height: 24),
          _buildNearbyProvidersSection(),
          const SizedBox(height: 24),
          _buildSectionHeader(
            _activeCategoryIndex == 0 ? 'Dịch vụ phổ biến' : 'Dịch vụ $currentCategoryLabel',
          ),
          const SizedBox(height: 12),
          _buildServicesList(filtered),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Tìm kiếm dịch vụ, sửa chữa, thuê thiết bị...',
          prefixIcon: const Icon(Icons.search, color: Color(0xFF737686)),
          filled: true,
          fillColor: const Color(0xFFE5EEFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30)),
      ),
    );
  }

  Widget _buildNearbyProvidersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Đơn vị cung cấp gần bạn',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30)),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Xem tất cả',
                  style: TextStyle(color: Color(0xFF004AC6), fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _nearbyProviders.length,
            itemBuilder: (context, index) {
              final provider = _nearbyProviders[index];
              return NearbyProviderTile(
                name: provider['name']!,
                distance: provider['distance']!,
                score: provider['score']!,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildServicesList(List<ServiceModel> services) {
    if (services.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: Text(
            'Không tìm thấy dịch vụ nào trong danh mục này.',
            style: TextStyle(color: Colors.black38),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return ServiceCard(
            service: services[index],
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ServiceDetailScreen()),
            ),
          );
        },
      ),
    );
  }
}