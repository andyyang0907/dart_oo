// 航天器通用能力 mixin
// ============================================================
// 为什么用 mixin 而不是「继承一个 Spacecraft 父类」？
//
// 1. Dart 是单继承语言：如果 Rocket 去 extends Spacecraft，
//    以后想再接另一组能力（如 Loggable、Comparable）就无法再继承。
//    用 mixin 可以 with 多个，灵活组合不占「唯一父类」名额。
//
// 2. 这是一组**横向可复用的能力**，不代表"Rocket 是 Spacecraft 的一种"这种
//    IS-A 强关系；以后 Satellite、Shuttle、Probe 等任何"有载重/可分类"的
//    对象都可以 with Spacecraft，不需要改变它们的继承树。
//
// 3. 避免继承带来的"基类膨胀"：如果把所有航天器通用方法都塞进父类，父类会
//    越来越臃肿；mixin 按能力维度拆分（Spacecraft / Loggable / ...），
//    需要哪个混入哪个，代码更符合开闭原则。
// ============================================================
mixin Spacecraft {
  // 载重阈值判断（可重载：载重 >= 20 吨算重载）
  bool get isHeavyPayload;

  // 格式化载重描述
  String describePayload(double payload) {
    if (payload >= 100) return '超重型(${payload.toStringAsFixed(1)} 吨)';
    if (payload >= 20) return '重型(${payload.toStringAsFixed(1)} 吨)';
    if (payload >= 5) return '中型(${payload.toStringAsFixed(1)} 吨)';
    return '轻型(${payload.toStringAsFixed(1)} 吨)';
  }

  // 返回载重分类：heavy / medium / light
  String payloadCategory(double payload) {
    if (payload >= 20) return 'heavy';
    if (payload >= 5) return 'medium';
    return 'light';
  }
}
