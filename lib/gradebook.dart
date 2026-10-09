//导入学生类，从 student 里面提取出来成绩构成 gradebook
import 'student.dart';

//gradebook类，成绩单
class Gradebook {
    //不可更改的一个只能装 student 类的 list
    final List<Student> students;

    List<double> gradebook = [];

    //构造函数：提取所有学生的分数,放到接收列表gradebook里
    Gradebook(this.students) {
        extractScores();
    }

    //提取分数函数，将所有学生的分数存入 gradebook 列表
    void extractScores() {
        gradebook = students.map((student) => student.score).toList();
    }

    //平均分
    double get average {
        if (gradebook.isEmpty) return 0;
        return gradebook.reduce((a, b) => a + b) / gradebook.length;
    }

    //最高分学生
    Student? maxBy() {
        if (students.isEmpty) return null;
        return students.reduce((a, b) => a.score > b.score ? a : b);
    }

    //及格人数
    int countPassed() {
        return students.where((student) => student.passed).length;
    }

    //按优、良、不及格三档分档返回Map
    Map<String, List<Student>> groupByGrade() {
        return {
            '优': students.where((s) => s.score >= 90 && s.score <= 100).toList(),
            '良': students.where((s) => s.score >= 70 && s.score < 90).toList(),
            '不及格': students.where((s) => s.score < 70).toList(),
        };
    }
}
