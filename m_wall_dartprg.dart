import 'dart:io';

Future delayedPrint(int seconds, String msg) {
  final duration = Duration(seconds: 3);
  return Future.delayed(duration).then((value) => msg);
}

void main() async {
  print('Started');
  await delayedPrint(2, "Now I'm done!").then((status) {
    print(status);
  });
  print('I am waiting here');
}
