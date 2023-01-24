import 'dart:convert';
import 'dart:io';

import 'package:temp/temp_model.dart';

void get clrscr => stdout.write(Process.runSync("clear", []).stdout);

AllThings ts = AllThings(things: [
  Thing(done: false, stuff: "stuff1"),
]);

class FileThing {
  factory FileThing() => _instance;
  static final FileThing _instance = FileThing._();
  FileThing._() {
    home = getGitRoot() ?? Platform.environment["HOME"] ?? ".";
    file = File('$home/.thing');
  }

  late String home;
  late File file;

  saveToFile(String data) async {
    if (!file.existsSync()) file.createSync();
    file.writeAsStringSync(data);
  }

  String readFile() {
    return file.readAsStringSync();
  }

  readThing() {
    Map<String, dynamic> json = jsonDecode(file.readAsStringSync());
    ts = AllThings.fromJson(json);
  }
}

FileThing get fio => FileThing();

void inputLoop() {
  clrscr;
  print("TASKS FOR => ${title ?? "HOME"}\n");

  try {
    if (fio.file.existsSync()) {
      Map<String, dynamic> json = jsonDecode(fio.readFile());
      ts = AllThings.fromJson(json);
    }
  } catch (e, st) {
    print("ERROR: $e");
    print("STACKTRACE: $st");
    handleParsingError();
  }

  for (var e in ts.things) {
    int i = ts.things.indexOf(e);
    print("$i. [${e.done ? "x" : " "}] ${e.stuff}");
  }

  inputOperation();

  fio.saveToFile(jsonEncode(ts.toJson()));

  inputLoop();
}

inputOperation() {
  stdout.write("\n> ");
  String s = stdin.readLineSync() ?? "";
  if (s == "") return;
  if (s == "q") exit(0);
  if (s == "dd") {
    ts = AllThings(things: []);
    return;
  }
  if (s.contains(RegExp(r'^.[0-9]*$'))) {
    print("matches regexp");
    int? i = int.tryParse(s.substring(1));
    if (i != null && i <= ts.things.length - 1) {
      if (s.startsWith("d")) {
        ts.removeAtIndex(i);
        print("delete $i");
        return;
      }
      if (s.startsWith("c")) {
        ts.toggleDoneAtIndex(i);
        print("completed/not completed");
        return;
      }
    } else {
      print("ERROR: index invalid");
    }
    return;
  }
  ts.addThing(s);
}

extension A on AllThings {
  addThing(String s) {
    things.add(Thing(done: false, stuff: s));
  }

  removeAtIndex(int i) {
    things.removeAt(i);
  }

  toggleDoneAtIndex(int i) {
    things[i] = Thing(done: !things[i].done, stuff: things[i].stuff);
  }
}

handleParsingError() {
  print("There was an error parsing the file");
  print(
      "The file might have been tampered with manually or might have no data");
  print("Overwrite the file and try again?(y/n)");
  print(
      "WARNING: All the data will be lost. Maybe create a backup of \"~/.thing\" before continuing");
  String s = stdin.readLineSync()?.toLowerCase() ?? "";
  if (s == "y") {
    print("Deleting File");
    fio.file.deleteSync();
    inputLoop();
  } else if (s == "n") {
    print("Exiting App");
    exit(1);
  } else {
    handleParsingError();
  }
}

String? getGitRoot({bool absolute = true}) {
  dynamic git = Process.runSync("git", ["rev-parse", "--show-toplevel"])
      .stdout
      .toString()
      .trim();
  dynamic branch = Process.runSync("git", ["rev-parse", "--abbrev-ref", "HEAD"])
      .stdout
      .toString()
      .trim();
  if (git == "") return null;
  if (absolute) return git;
  return "${git.toString().split('/').last}[${branch}]";
}

String? title = getGitRoot(absolute: false);
