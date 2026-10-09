mixin Logger {
    void log(String message) {
        final time = DateTime.now();
        final hh = time.hour.toString().padLeft(2, '0');
        final mm = time.minute.toString().padLeft(2, '0');
        final ss = time.second.toString().padLeft(2, '0');
        print('[$hh:$mm:$ss] LOG: $message');
    }

    void logSection(String title) {
        print('========== $title ==========');
        log('开始执行：$title');
    }
}

