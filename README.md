# flutter_id_recognition

Android integrates Huawei SDK ID card recognition, and IOS integrates ID recognition.

## Usage

1. Use this package as a library

   ### Depend on it

   Run this command:

   With Flutter:

   ```shell
    $ flutter pub add flutter_id_recognition
   ```

   This will add a line like this to your package's pubspec.yaml (and run an implicit `flutter pub get`):

   ```yaml
   dependencies:
     flutter_id_recognition: ^0.1.0
   ```

   Alternatively, your editor might support `flutter pub get`. Check the docs for your editor to learn more.

   ### Import it

   Now in your Dart code, you can use:

   ```dart
   import 'package:flutter_id_recognition/flutter_id_recognition.dart';
   ```

2. Android project root directory add:

   - ```
     maven { url 'https://developer.huawei.com/repo/' }
     ```

3. app directory add:

   - ```
         dependencies {
             // 中国第二代身份证
             // 引入身份证plugin与识别能力集合包。
             implementation 'com.huawei.hms:ml-computer-card-icr-cn:3.7.0.303'
     
             //越南身份证
     //    implementation 'com.huawei.hms:ml-computer-card-icr-vn:3.7.0.303'
     
             implementation 'com.huawei.hms:scanplus:2.8.0.300'
         }
     ```

     



