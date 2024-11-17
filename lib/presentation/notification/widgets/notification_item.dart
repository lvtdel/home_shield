import 'package:flutter/material.dart';

class NotificationItem extends StatefulWidget {
  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildNotificationCard(),
        // _buildNotificationCard(),
      ],
    );
  }

  Widget _buildNotificationCard() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: ListTile(
              minTileHeight: 100,
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/conan.png'), // Thay thế bằng đường dẫn hình ảnh Conan
              ),
              title: Text(
                'Thám tử lừng danh Conan có vụ án mới',
                maxLines: 3, // Giới hạn số dòng hiển thị
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                // Xử lý khi nhấn nút Accept
                print('Accept');
              },
              child: Text('Accept'),
            ),
            TextButton(
              onPressed: () {
                // Xử lý khi nhấn nút Delete
                print('Delete');
              },
              child: Text('Delete'),
            ),
          ],
        )
      ],
    );
  }
}
