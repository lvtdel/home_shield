import 'package:flutter/material.dart';
import 'package:home_shield/core/utils/format_phone_number.dart';

class OrganizationPopup extends StatefulWidget {
  final String? phoneNumber;
  final String? organizationName;
  final onCall;
  final onClose;

  const OrganizationPopup(
      {this.phoneNumber, this.organizationName, this.onCall, this.onClose});

  @override
  State<OrganizationPopup> createState() => _OrganizationPopupState();
}

class _OrganizationPopupState extends State<OrganizationPopup> {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.phoneNumber != null
              ? Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title Text
                      SizedBox(
                        width: 350,
                        child: Text(
                          widget.organizationName ?? "",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Phone Number Text
                      Text(
                        formatPhoneNumber(widget.phoneNumber!),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
              )
              : Flexible(
                  child: Text(
                    widget.organizationName ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
          const SizedBox(
            width: 10,
          ),
          // Call Icon Button
          if (widget.phoneNumber != null)
            GestureDetector(
              onTap: widget.onCall,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.red.shade300,
                child: const Icon(Icons.call, color: Colors.white),
              ),
            ),
          const SizedBox(width: 8),
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
