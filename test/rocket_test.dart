import 'package:dart_oo/dart_oo.dart';
import 'package:test/test.dart';

void main() {
    //=========== 用例组1：正常数据统计正确（复杂度对齐 gradebook_test）===========
    group('正常数据统计正确', () {
        late PayloadAbility fleet;
        late List<Rocket> rockets;

        setUp(() {
            rockets = [
                Rocket('猎鹰9号', 22.8),
                Rocket('土星5号', 140.0),
                Rocket('长征5号', 25.0),
                Rocket('电子号', 0.3),
                Rocket('长征七号', 14.0),
            ];
            fleet = PayloadAbility(rockets);
        });

        test('payloads 运载能力列表正确提取', () {
            expect(fleet.payloads, equals([22.8, 140.0, 25.0, 0.3, 14.0]));
        });

        test('maxRocket 最大火箭正确（土星5号 140.0）', () {
            final top = fleet.maxRocket();
            expect(top, isNotNull);
            expect(top!.name, equals('土星5号'));
            expect(top.payload, equals(140.0));
        });

        test('sortAscending 升序正确（最小在最前：电子号 0.3）', () {
            final asc = fleet.sortAscending();
            expect(asc.first.name, equals('电子号'));
            expect(asc.last.name, equals('土星5号'));
        });

        test('sortDescending 降序正确（最大在最前：土星5号）', () {
            final desc = fleet.sortDescending();
            expect(desc.first.name, equals('土星5号'));
            expect(desc.last.name, equals('电子号'));
        });

        test('wherePayloadAtLeast(20) 筛选载重>=20吨的有 3 枚', () {
            final filtered = fleet.wherePayloadAtLeast(20);
            expect(filtered.length, equals(3)); // 猎鹰9号、土星5号、长征5号
        });

        test('集合统计链 heavyRocketReport：>=5个链式方法组合', () {
            final report = fleet.heavyRocketReport();
            // 5 枚里排除 <5 吨的电子号(0.3) → 剩 4 枚
            expect(report['count'], equals(4));
            // 4 枚总载重：22.8 + 140 + 25 + 14 = 201.8
            expect(report['totalTonnage'], closeTo(201.8, 0.01));
            // heavyOnlyNames（category==heavy，即>=20吨）：猎鹰9号/土星5号/长征5号 → 3
            final heavies = report['heavyOnlyNames'] as List<String>;
            expect(heavies.length, equals(3));
        });

        test('mixin Spacecraft 能力可用：isHeavyPayload / summary', () {
            final saturn = rockets[1];       // 土星5号 140 吨
            final electron = rockets[3];     // 电子号 0.3 吨
            expect(saturn.isHeavyPayload, isTrue);
            expect(electron.isHeavyPayload, isFalse);
            expect(saturn.summary, contains('超重型'));
            expect(electron.summary, contains('轻型'));
        });

        test('空列表边界：maxRocket 返回 null', () {
            final empty = PayloadAbility([]);
            expect(empty.maxRocket(), isNull);
            expect(empty.heavyRocketReport()['count'], equals(0));
        });
    });

    //=========== 用例组2：越界异常路径 ===========
    group('越界分数抛异常', () {
        test('构造函数 payload <= 0 抛 ArgumentError', () {
            expect(() => Rocket('超', 0), throwsArgumentError);
            expect(() => Rocket('负', -5), throwsArgumentError);
        });

        test('fromJson 越界抛 ArgumentError', () {
            expect(() => Rocket.fromJson({'name': '零', 'payload': 0}), throwsArgumentError);
            expect(() => Rocket.fromJson({'name': '负', 'payload': -1}), throwsArgumentError);
        });

        test('setter 赋值 <= 0 抛 ArgumentError，合法值正常', () {
            final r = Rocket('测试', 10);
            expect(() => r.payload = 0, throwsArgumentError);
            expect(() => r.payload = -1, throwsArgumentError);
            expect(() => r.payload = 88, returnsNormally);
        });
    });
}
