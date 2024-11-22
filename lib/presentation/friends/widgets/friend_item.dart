import 'package:flutter/material.dart';

class FriendItem extends StatefulWidget {
  @override
  State<FriendItem> createState() => _FriendItemState();
}

class _FriendItemState extends State<FriendItem> {
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
        Text("0981 147 346", style: Theme.of(context).textTheme.titleSmall,)
      ],
    );
  }
}
