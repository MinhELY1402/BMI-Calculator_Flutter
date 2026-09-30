import 'dart:math';

class CalculatorBrain {
  CalculatorBrain({required this.height, required this.weight});

  final int height;
  final int weight;

  double _bmi = 0.0;

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return 'You have a higher than normal body weight. Try to exercise more.\n(Bạn có cân nặng cao hơn mức bình thường. Hãy tăng cường vận động và tập thể dục đều đặn.)';
    } else if (_bmi >= 18.5) {
      return 'You have a normal body weight. Good job!\n(Bạn có chỉ số cơ thể rất cân đối và khỏe mạnh. Hãy tiếp tục duy trì lối sống lành mạnh!)';
    } else {
      return 'You have a lower than normal body weight. You can eat a bit more.\n(Bạn có cân nặng thấp hơn bình thường. Hãy bổ sung thêm dinh dưỡng để đạt thể trạng tốt nhất.)';
    }
  }
}
