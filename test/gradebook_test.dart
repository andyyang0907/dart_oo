import 'package:dart_oo/dart_oo.dart';
import 'package:test/test.dart';

void main() {
    group('正常数据统计正确', () {
        late Gradebook gb;
        late List<Student> students;

        setUp(() {
            students = [
                Student('小明', '001', 95),
                Student('小红', '002', 88),
                Student('小刚', '003', 75),
                Student('小丽', '004', 55),
                Student('小强', '005', 60),
            ];
            gb = Gradebook(students);
        });

        test('平均分计算正确', () {
            expect(gb.average, closeTo(74.6, 0.001));
        });

        test('最高分学生正确', () {
            final top = gb.maxBy();
            expect(top, isNotNull);
            expect(top!.name, equals('小明'));
            expect(top.score, equals(95));
        });

        test('及格人数正确（>=60 的有 4 个）', () {
            expect(gb.countPassed(), equals(4));
        });

        test('分档人数正确（优1 / 良2 / 不及格2）', () {
            final groups = gb.groupByGrade();
            expect(groups['优']!.length, equals(1));
            expect(groups['良']!.length, equals(2));
            expect(groups['不及格']!.length, equals(2));
        });

        test('分数列表 gradebook 已正确提取', () {
            expect(gb.gradebook, equals([95, 88, 75, 55, 60]));
        });

        test('空列表时 maxBy 返回 null、average 为 0', () {
            final empty = Gradebook([]);
            expect(empty.maxBy(), isNull);
            expect(empty.average, equals(0));
            expect(empty.countPassed(), equals(0));
        });
    });

    group('越界分数抛异常', () {
        test('构造函数 >100 抛 ArgumentError', () {
            expect(() => Student('超分', '999', 101), throwsArgumentError);
        });

        test('构造函数 <0 抛 ArgumentError', () {
            expect(() => Student('负分', '998', -5), throwsArgumentError);
        });

        test('fromJson 越界抛 ArgumentError', () {
            expect(() => Student.fromJson({'name': '超', 'id': '1', 'score': 200}), throwsArgumentError);
            expect(() => Student.fromJson({'name': '负', 'id': '2', 'score': -1}), throwsArgumentError);
        });

        test('setter 赋值越界抛 ArgumentError', () {
            final s = Student('普通', '001', 80);
            expect(() => s.score = -10, throwsArgumentError);
            expect(() => s.score = 150, throwsArgumentError);
        });

        test('setter 赋值在合法范围不抛异常', () {
            final s = Student('普通', '001', 80);
            expect(() => s.score = 0, returnsNormally);
            expect(() => s.score = 100, returnsNormally);
            expect(() => s.score = 66, returnsNormally);
        });
    });
}
