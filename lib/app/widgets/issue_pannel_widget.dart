import 'package:flutter/material.dart';

class IssuePanelWidget extends StatelessWidget {
  const IssuePanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),

      child: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.warning, color: Colors.orange),
            title: Text("Frame 3"),
            subtitle: Text("Motion: Stutter detected"),
          ),

          ListTile(
            leading: Icon(Icons.warning, color: Colors.orange),
            title: Text("Frame 5"),
            subtitle: Text("Timing: Slight delay"),
          ),
        ],
      ),
    );
  }
}
