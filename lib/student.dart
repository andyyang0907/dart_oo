//student 类

class Student {
    final String name;
    final String id;
    double _score;

    Student(this.name, this.id, this._score) {
        if (_score < 0 || _score > 100) throw ArgumentError("分数越界");
    }

    Student.fromJson(Map<String, dynamic> json)
        : name = json['name'],
          id = json['id'],
          _score = (json['score'] as num).toDouble() {
        if (_score < 0 || _score > 100) throw ArgumentError("分数越界");
    }

    double get score => _score;

    set score(double value) {
        if (value < 0 || value > 100) throw ArgumentError("分数越界");
        _score = value;
    }

    bool get passed => _score >= 60;
}
