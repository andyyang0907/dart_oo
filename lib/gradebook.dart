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
}
