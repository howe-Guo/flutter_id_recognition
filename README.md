# flutter_id_recognition

Android integrates Huawei SDK ID card recognition, and IOS integrates ID recognition.

## Usage

1. Android project root directory add:

   - `maven { url 'https://developer.huawei.com/repo/' }`

2. app directory add:

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

     



