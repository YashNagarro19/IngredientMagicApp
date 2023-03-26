import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'Response.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  bool result = false;
  ResponseData? responseData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page')),
      body: Center(
        child: !result && responseData == null
            ? Column(mainAxisSize: MainAxisSize.min, children: [
                Image.file(File(widget.picture.path),
                    fit: BoxFit.cover, width: 250),
                const SizedBox(height: 24),
                const Text('Upload the photo to scan'),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () {
                   // print(updateImage(widget.picture));
                    Upload(widget.picture);
                   // uploadThePhotoAndGetTheResponse();
                  },
                  child: const Text('Upload'),
                ),
              ])
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'As the product components we found that',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      ' \n\n ${fromResultToText(responseData?.rating ?? 0, responseData?.avoid ?? '')}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Rating : ${responseData?.rating ?? 0}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: fromResultToColor(responseData?.rating ?? 0),
                      fontSize: 20),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  uploadThePhotoAndGetTheResponse() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  width: 20,
                ),
                Text("Loading"),
              ],
            ),
          ),
        );
      },
    );

    var client = http.Client();
    try {
      var response = await client
          .post(Uri.https('apim-ai-o.azure-api.net', 'aiotest'), headers: {
        'Ocp-Apim-Subscription-Key': '59a541745fab4d29b0197d98cb733def'
      });
      ResponseData decodedResponse =
          ResponseData.fromJson(jsonDecode(response.body));
      Navigator.pop(context);
      setState(() {
        responseData = decodedResponse;
        result = true;
      });
    } finally {
      client.close();
    }
  }

  String fromResultToText(result, avoid) {
    double rate = double.tryParse(result) ?? 0;
    return rate < 3
        ? 'The product bad for your health So you can avoid $avoid'
        : rate < 4
            ? 'The product is not bad for your health but you can avoid $avoid'
            : 'The product is good for your health';
  }

  Color fromResultToColor(result) {
    double rate = double.tryParse(result) ?? 0;
    return rate < 3
        ? Colors.yellow
        : rate < 4
            ? Colors.orange
            : Colors.green;
  }


  Future<bool> updateImage(XFile imageFile) async{
    const String url =
        'https://apim-ai-o.azure-api.net/v1/aiodata';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Ocp-Apim-Subscription-Key'] = '59a541745fab4d29b0197d98cb733def';

    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    print('responseBody: ${res}' );
    if(res.statusCode==200){
      return true;
    } else {
      print(respStr);
      print('Failed');
      return false;
    }
  }



  Upload(XFile imageFile) async {

    var uri = Uri.https('ingredientsmagicjava.azurewebsites.net', '/api/fileSystemUpload');//Uri.https('apim-ai-o.azure-api.net', '/v1/aiodata');
    var request = http.MultipartRequest('POST', uri)
    ..headers['Ocp-Apim-Subscription-Key'] = '59a541745fab4d29b0197d98cb733def'
      ..files.add(await http.MultipartFile.fromPath(
        imageFile.name, imageFile.path,
          // contentType: MediaType('png', 'x-tar'),
      ));
    var response = await request.send();

    if (response.statusCode == 200) print('Uploaded!');
  }
}
