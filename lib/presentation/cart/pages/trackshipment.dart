import 'package:flutter/material.dart';

class TrackShipmentPage extends StatefulWidget {
  const TrackShipmentPage({Key? key}) : super(key: key);

  @override
  State<TrackShipmentPage> createState() => _TrackShipmentPageState();
}

class _TrackShipmentPageState extends State<TrackShipmentPage> {
  final TextEditingController _orderController = TextEditingController();
  String? _orderNumber;
  Map<String, String> _orderStatus = {};
  bool _isTracking = false;

  // Mock Data (Simulasi data pesanan untuk testing)
  final Map<String, Map<String, String>> _mockOrderData = {
    "12345": {
      "status": "Shipped",
      "deliveryDate": "October 20, 2024",
    },
    "67890": {
      "status": "Processing",
      "deliveryDate": "October 25, 2024",
    },
    "54321": {
      "status": "Delivered",
      "deliveryDate": "October 15, 2024",
    },
  };

  void _trackOrder() {
    setState(() {
      _orderNumber = _orderController.text.trim();
      _isTracking = true;

      if (_mockOrderData.containsKey(_orderNumber)) {
        _orderStatus = _mockOrderData[_orderNumber]!;
      } else {
        _orderStatus = {};
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Shipment'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Field
            TextField(
              controller: _orderController,
              decoration: InputDecoration(
                labelText: 'Enter Order Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Track Button
            ElevatedButton(
              onPressed: _trackOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                'Track',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
            // Order Status Section
            if (_isTracking)
              _orderStatus.isNotEmpty
                  ? _buildOrderStatusSection()
                  : const Text(
                      'Order not found. Please check your order number.',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatusSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Status',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Status: ${_orderStatus["status"]}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Estimated Delivery: ${_orderStatus["deliveryDate"]}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          // Tracking Steps
          const Text(
            'Tracking Steps:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildTrackingSteps(_orderStatus["status"]!),
        ],
      ),
    );
  }

  Widget _buildTrackingSteps(String currentStatus) {
    const statuses = ['Order Placed', 'Processing', 'Shipped', 'Delivered'];
    final currentIndex = statuses.indexOf(currentStatus);

    return Column(
      children: statuses.map((status) {
        final isCompleted = statuses.indexOf(status) <= currentIndex;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(
                isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isCompleted ? Colors.green : Colors.grey,
              ),
              const SizedBox(width: 10),
              Text(
                status,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                  color: isCompleted ? Colors.black87 : Colors.grey,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
