import 'dart:convert';
import 'dart:io';

T fixture<T>(String name) => jsonDecode(File('assets/json/$name').readAsStringSync()) as T;
