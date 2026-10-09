//rocket 类
class Rocket {
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
}
