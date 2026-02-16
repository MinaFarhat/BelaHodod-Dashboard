import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../presentation/controllers/switch_button_controller.dart';

class SwitchButton extends StatefulWidget {
  final bool initStatus;
  final Function(bool value) onChange;
  final double? labelSize;
  final double? width;
  final double? height;
  final double? toggleSize;

  const SwitchButton(
      {super.key,
      required this.initStatus,
      required this.onChange,
      this.labelSize,
      this.width,
      this.height,
      this.toggleSize});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  final SwitchButtonController controller = Get.put(SwitchButtonController());
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 3.5.w,
      child: FlutterSwitch(
        width: widget.width ?? 90.0,
        height: widget.height ?? 2.5.w,
        valueFontSize: widget.labelSize ?? 12.0,
        toggleSize: widget.toggleSize ?? 22.0,
        value: widget.initStatus,
        borderRadius: 30.0,
        padding: 10.0,
        inactiveText: "غير فعال",
        activeText: "فعال",
        showOnOff: true,
        onToggle: (val) {
          widget.onChange(val);
        },
      ),
    );
  }
}
