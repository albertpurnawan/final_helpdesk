import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardTiles extends StatefulWidget {
  final int ticket;
  final String desc;
  final IconData icon;
  final Color color, iconColor, iconBgColor, bgColor;

  const DashboardTiles({
    super.key,
    required this.ticket,
    required this.desc,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.iconBgColor,
    required this.bgColor,
  });

  @override
  State<DashboardTiles> createState() => _DashboardTilesState();
}

class _DashboardTilesState extends State<DashboardTiles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                widget.icon,
                color: widget.iconColor,
                size: 30,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.ticket.toString(),
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: widget.color,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.desc,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: widget.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
