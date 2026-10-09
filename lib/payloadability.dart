//导入火箭类
import 'rocket.dart';

//payloadability 类（对应 Gradebook 学生成绩管理，复杂度与 Gradebook 对齐）
class PayloadAbility {
  //存放所有火箭的列表（类比 Gradebook.students）
  final List<Rocket> rockets;

  //只放运载能力的列表（类比 Gradebook.gradebook 纯分数列表）
  List<double> payloads = [];

  //构造函数：接收火箭列表，自动提取运载能力到 payloads
  PayloadAbility(this.rockets) {
    extractPayloads();
  }

  //提取所有火箭的运载能力存入 payloads 列表
  void extractPayloads() {
    payloads = rockets.map((r) => r.payload).toList();
  }

  //筛选运载能力最大的火箭（类比 Gradebook.maxBy）
  Rocket? maxRocket() {
    if (rockets.isEmpty) return null;
    return rockets.reduce((a, b) => a.payload > b.payload ? a : b);
  }

  //从小到大排序（返回新列表，不修改原 rockets）
  List<Rocket> sortAscending() {
    final sorted = List<Rocket>.from(rockets);
    sorted.sort((a, b) => a.payload.compareTo(b.payload));
    return sorted;
  }

  //从大到小排序
  List<Rocket> sortDescending() {
    final sorted = List<Rocket>.from(rockets);
    sorted.sort((a, b) => b.payload.compareTo(a.payload));
    return sorted;
  }

  //筛选运载能力 >= 某个阈值的火箭（类比 Gradebook.countPassed 的 where 过滤）
  List<Rocket> wherePayloadAtLeast(double threshold) {
    return rockets.where((r) => r.payload >= threshold).toList();
  }

  //============================================================
  //集合统计链：一条链串起 >= 5 个集合链式方法完成一组统计
  //where → map → toList → sort → fold → where 共 6 个链式操作
  //============================================================
  Map<String, dynamic> heavyRocketReport() {
    final rows = rockets
        .where((r) => r.payload >= 5)                                // ① where：筛选中重型(>=5吨)
        .map((r) => {
              'name': r.name,
              'payload': r.payload,
              'category': r.payloadCategory(r.payload),
            })
        .toList()                                                    // ② map + ③ toList：转结构化列表
      ..sort((a, b) => (b['payload'] as double)                      // ④ sort：按载重降序
          .compareTo(a['payload'] as double));

    final totalTonnage = rows.fold<double>(0, (sum, row) =>           // ⑤ fold：累计总载重
        sum + (row['payload'] as double));

    final heavyOnlyNames = rows
        .where((row) => row['category'] == 'heavy')                   // ⑥ where：二次过滤重型
        .map((row) => row['name'] as String)
        .toList();

    return {
      'count': rows.length,
      'totalTonnage': totalTonnage,
      'heavyOnlyNames': heavyOnlyNames,
      'rows': rows,
    };
  }

  //打印摘要（对齐 Gradebook.printSummary，不要平均和最小）
  void printSummary() {
    print('===== 运载能力摘要 =====');
    print('火箭总数: ${rockets.length}');
    print('所有运载能力(吨): $payloads');
    final max = maxRocket();
    if (max != null) print('最大火箭: ${max.name} - ${max.payload} 吨');
    print('========================');
  }
}
