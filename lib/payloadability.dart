//导入火箭类
import 'rocket.dart';

//payloadability 类
class PayloadAbility {
  //存放所有火箭的列表
  final List<Rocket> rockets;

  //只放运载能力的列表
  List<double> payloads = [];

  //构造函数：接收火箭列表，同时提取所有运载能力到 payloads
  PayloadAbility(this.rockets) {
    extractPayloads();
  }

  //提取所有火箭的运载能力存入 payloads 列表
  void extractPayloads() {
    payloads = rockets.map((r) => r.payload).toList();
  }

  //筛选出运载能力最大的火箭
  Rocket? maxRocket() {
    if (rockets.isEmpty) return null;
    return rockets.reduce((a, b) => a.payload > b.payload ? a : b);
  }

  //从大到小排序
  List<Rocket> sortDescending() {
    final sorted = List<Rocket>.from(rockets);
    sorted.sort((a, b) => b.payload.compareTo(a.payload));
    return sorted;
  }

  //筛选出运载能力 >= 某个阈值的火箭
  List<Rocket> wherePayloadAtLeast(double threshold) {
    return rockets.where((r) => r.payload >= threshold).toList();
  }

  //打印摘要
  void printSummary() {
    print('===== 运载能力摘要 =====');
    print('火箭总数: ${rockets.length}');
    print('所有运载能力(吨): $payloads');
    final max = maxRocket();
    if (max != null) print('最大火箭: ${max.name} - ${max.payload} 吨');
    print('========================');
  }
}
