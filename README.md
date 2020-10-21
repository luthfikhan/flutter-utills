# Utility For Flutter

## 1. api.dart ( RequestHelper, ErrorHandling, ExampleModel )
- Menhandle request api

#### Contoh Penggunaan
```dart
ApiResponse<Model> webResponse = ApiResponse.none();
getSomeResponse() async {
    webResponse = ApiResponse.loading();
    final endPoint = '';
    try {
      final response = await _requestHelper.get(apiBaseUrl + endPoint);

      final result = modelFromJson(response.body);
      webResponse = ApiResponse.success(result);
    } on NetworkException catch (e) {
      webResponse = ApiResponse.error(e.message);
    }
  }
```

## 2. color_helper.dart (Color From Hex)
- Mengubah format warna string hex (`'#FFFFFF'`) menjadi warna yang support dengan flutter

#### Contoh Penggunaan
```dart
Container(
    color: ColorHelper.colorFromHex('#ffffff')
);
```
## 3. formater.dart ( Baru ada format currency :v )
- Memformat `double` menjadi format mata uang Indonesia 

#### Contoh Penggunaan
```dart
Formater.currency(10000)
// Rp 10.000
```
## 4. size_config.dart ( Belum final )
- Ukuran pixel berdasarkan ukuran layar

#### Contoh Penggunaan
```dart
// ScreenConfig.init(context); inisialisai di build(context)
Container(
    width: SizeConfig.getPixel(100)
)
```
## 5. time_ago.dart
- 1 menit yang lalu

#### Contoh Penggunaan
```dart
DateTime b = DateTime.now().subtract(Duration(seconds: 2));
DateTime c = DateTime.now().subtract(Duration(minutes: 2));
Text(TimeAgo.getTimeAgo(b)) // Sekarang
Text(TimeAgo.getTimeAgo(c)) // 2 Menit yang lalu
```

## 6. validator.dart ( Email dan nomor )
- Validasi thd string

#### Contoh Penggunaan
```dart
String mail = 'mail@example.com'
if(Validator.isValidEmail(mail){ } // true
```
