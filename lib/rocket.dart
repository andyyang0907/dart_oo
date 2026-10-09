//导入航天器能力 mixin
import 'spacecraft.dart';

//rocket 类 —— 用 with Spacecraft 混入通用能力，替代"继承 Spacecraft 父类"
class Rocket with Spacecraft {
  //火箭名字
  final String name;
  //运载能力(吨)，必须大于 0
  double _payload;

  //普通构造函数
  Rocket(this.name, this._payload) {
    if (_payload <= 0) throw ArgumentError("运载能力必须大于 0");
  }

  //fromJson 构造函数
  Rocket.fromJson(Map<String, dynamic> json)
      : name = json['name'],      
        _payload = (json['payload'] as num).toDouble() {
    if (_payload <= 0) throw ArgumentError("运载能力必须大于 0");
  }

  double get payload => _payload;

  set payload(double value) {
    if (value <= 0) throw ArgumentError("运载能力必须大于 0");
    _payload = value;
  }

  //========== 满足 mixin Spacecraft 要求的抽象 getter ==========
  //重载判断：payload >= 20 吨算重载
  @override
  bool get isHeavyPayload => _payload >= 20;

  //========== 直接复用 mixin 里的 describePayload / payloadCategory ==========
  //因为 with Spacecraft 已经把这两个方法带进来了，Rocket 实例直接
  // rocket.describePayload(rocket.payload) 就能用，不需要重写

  //简介（组合 mixin 能力）
  String get summary => '$name: ${describePayload(_payload)}';
}
