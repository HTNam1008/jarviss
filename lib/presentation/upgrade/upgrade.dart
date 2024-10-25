import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class UpgradeView extends StatefulWidget {
  const UpgradeView({super.key});

  @override
  _UpgradeViewState createState() => _UpgradeViewState();
}

class _UpgradeViewState extends State<UpgradeView> {
  bool isFreeTrialEnabled = false;
  String? selectedPlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeaderBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "CyneAI Pro",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              Text(
                "Nâng cao Hiệu suất của Bạn",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 20),
              const FeatureItem(
                title: "Bậc thầy Chế giễu và tương tự: Không cần xếp hàng",
                subtitle: "Tạo ngay Chế giễu AI và tương tự",
              ),
              const SizedBox(height: 16),
              const FeatureItem(
                title: "Truy cập GPT-4o & Claude",
                subtitle: "Nhận câu trả lời chính xác và chi tiết hơn",
              ),
              const SizedBox(height: 16),
              const FeatureItem(
                title: "Tóm tắt trang web & YouTube",
                subtitle: "Kích hoạt tóm tắt nổi bật chỉ bằng một lần nhấp",
              ),
              const SizedBox(height: 16),
              const FeatureItem(
                title: "Tạo dễ dàng với trí tuệ nhân tạo",
                subtitle: "Kích hoạt sáng tạo nội dung văn bản & hình ảnh AI",
              ),
              const SizedBox(height: 20),

              // Bảng so sánh các tính năng
              Text(
                "So sánh các tính năng",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              _buildComparisonTable(),
              const SizedBox(height: 20),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bắt đầu dùng thử miễn phí',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Switch(
                    value: isFreeTrialEnabled,
                    onChanged: (value) {
                      setState(() {
                        isFreeTrialEnabled = value;
                      });
                    },
                    activeColor: Colors.teal,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedPlan == 'monthly') {
                      selectedPlan = null;
                    } else {
                      selectedPlan = 'monthly';
                    }
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: selectedPlan == 'monthly'
                        ? Colors.teal[50]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.teal),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "234.000 đ/tháng",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Khoảng 7800.0/ngày",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedPlan == 'yearly') {
                      selectedPlan = null;
                    } else {
                      selectedPlan = 'yearly';
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: selectedPlan == 'yearly'
                        ? Colors.teal[50]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.teal),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "2.350.000 đ/năm",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "17% GIẢM GIÁ",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "2.880.000 đ/năm",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "3 ngày dùng thử miễn phí, sau đó 2.350.000 đ/năm. Hủy bất cứ lúc nào.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Bắt đầu Miễn phí trong 3 ngày',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget to build the comparison table
Widget _buildComparisonTable() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.s12),
          topRight: Radius.circular(AppSize.s12)),
      border: Border.all(color: Colors.teal),
    ),
    child: Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      children: [
        _buildHeaderRow(),
        _buildDataRow(1, 'Câu truy vấn cơ bản', '40/ngày', '5000/tháng'),
        _buildDataRow(2, 'Câu truy vấn nâng cao', '❌', '200/tháng'),
        _buildDataRow(3, 'Tín dụng nâng cao', '❌', '1500/tháng'),
        _buildDataRow(4, 'Truy cập OpenAI-01', '❌', '✅'),
        _buildDataRow(5, 'ChatPDF', '❌', '✅'),
        _buildDataRow(6, 'Tìm kiếm trên web', '❌', '✅'),
        _buildDataRow(7, 'Tóm tắt YouTube', '❌', '✅'),
      ],
    ),
  );
}

// Widget to create the header row
TableRow _buildHeaderRow() {
  return TableRow(
    decoration: BoxDecoration(
      color: Colors.teal.shade700,
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    children: [
      _buildHeaderCell('Tính Năng'),
      _buildHeaderCell('Basic'),
      _buildHeaderCell('Pro'),
    ],
  );
}

// Widget to create a data row
TableRow _buildDataRow(int index, String feature, String basic, String pro) {
  bool isEvenRow = (index % 2 == 0);
  return TableRow(
    decoration: BoxDecoration(
      color: isEvenRow ? Colors.teal.shade50 : Colors.white,
    ),
    children: [
      _buildDataCell(feature),
      _buildDataCell(basic),
      _buildDataCell(pro),
    ],
  );
}

// Helper method to build header cell
Widget _buildHeaderCell(String text) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

// Helper method to build data cell
Widget _buildDataCell(String text) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    ),
  );
}

class FeatureItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const FeatureItem({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.check_circle, color: Colors.teal),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
