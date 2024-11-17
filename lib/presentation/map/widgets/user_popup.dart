import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_shield/core/styles/app_colors.dart';
import 'package:home_shield/data/map/models/location_info_model.dart';

class UserInfoCard extends StatefulWidget {
  final LocationInfoModel locationInfoModel;
  final onCall;
  final onMess;
  final onClose;

  const UserInfoCard(
      {required this.locationInfoModel,
      required this.onCall,
      required this.onMess,
      required this.onClose});

  @override
  State<UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<UserInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Profile Picture
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(widget
                .locationInfoModel.image!), // Replace with your image path
          ),
          SizedBox(width: 16),
          // Name and Icons
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.locationInfoModel.userName!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // Message Icon
                  GestureDetector(
                    onTap: widget.onMess,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primary,
                      child: const Icon(Icons.message, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),
                  // Call Icon
                  GestureDetector(
                    onTap: widget.onCall,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primary,
                      child: const Icon(Icons.call, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          // Close Icon
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: widget.onClose,
          ),
        ],
      ),
    );
  }
}
