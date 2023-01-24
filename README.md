## TodoThing
A simple CLI task manager that will take input and save it locally in the root of your git directory or your Home directory.

This program is fully usable, unlike Tasker, but is much simpler in execution.

Local Storage only checked for linux and macOS, might not work as expected for windows.

### Instructions:
- add tasks by simpling adding text and pressing `enter` key.
- complete tasks by adding `c{n}` where `{n}` is the index of the tasks displayed on the left-hand side.
- delete tasks by adding `d{n}` where `{n}` is the index of the tasks displayed on the left-hand side.
- delete all tasks using `dd`
- exit by entring `q`.

### Usage:
1. Compile using dart compiler: `dart compile exe {workspace}/bin/temp.dart`
2. Move `{workspace}/bin/temp.exe` to a folder, for example `.scripts` and rename `temp.exe` to `todoThing`.
3. Add the folder to the `PATH` env variable in your `.profile`, `.bashrc` or `.zshrc` file. For example, add `export PATH="$PATH":"{path}/{to}/.scripts"` to your `rc` or `profile` file.
4. Now `source .{your_profile_or_rc_file}`. Alternatively you can restart your terminal.
5. if done properly, `todoThing` should be available to use anywhere.

Note: `todoThing` will create a `.thing` file either at the root of git repo (if available) or your `HOME` directory. Tampering with the contents will not cause much issues unless there are errors while parsing the file. If there are errors the program will recommend either manually editing the file yourself, or will delete the file for you.

### Functionality:
- [x] add tasks
- [x] complete tasks
- [x] delete tasks
- [x] store tasks as json locally (saved in a file called `.thing`)
- [x] store tasks at the root of git repo
- [x] file error handling