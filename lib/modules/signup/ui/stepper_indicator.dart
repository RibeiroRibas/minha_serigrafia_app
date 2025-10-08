import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    this.totalSteps = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _StepConnector(isActive: currentStep <= totalSteps),
        ...List.generate(totalSteps * 2 - 1, (index) {
          if (index.isEven) {
            final step = index ~/ 2 + 1;
            return _StepCircle(isActive: step <= currentStep);
          }
          return _StepConnector(isActive: currentStep == totalSteps);
        }),
        _StepConnector(isActive: currentStep == totalSteps),
      ],
    );
  }
}

class _StepCircle extends StatelessWidget {
  final bool isActive;

  const _StepCircle({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Theme.of(context).primaryColor : Colors.grey.shade300,
        border: Border.all(color: Colors.transparent, width: 1.5),
      ),
    );
  }
}

class _StepConnector extends StatelessWidget {
  final bool isActive;

  const _StepConnector({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 3,
        color: isActive ? Theme.of(context).primaryColor : Colors.grey.shade300,
      ),
    );
  }
}
