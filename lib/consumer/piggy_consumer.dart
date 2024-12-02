import 'package:agattp/agattp.dart';
import 'package:flutter/foundation.dart';
import 'package:piggywise_simulator/model/piggy_model.dart';

///
///
///
class PiggyConsumer {
  String baseUrl = 'https://piggywise.com.br/api'; //'http://localhost:8080';
  String username = 'manoel';
  String password = 'manoel';

  ///
  ///
  ///
  Future<PiggyModel> deposit(final String piggyCode, final int value) async {
    final AgattpResponseJson<Map<String, dynamic>> response =
        await Agattp.authBasic(username: username, password: password).getJson(
      Uri.parse('${<String>[
        baseUrl,
        'piggies',
        piggyCode,
        'deposit',
      ].join('/')}?value=$value'),
    );

    if (kDebugMode) {
      print('PíggyConsumer.deposit: ${response.json}');
    }

    if (response.statusCode > 299 || response.statusCode < 200) {
      throw Exception('Falha ao depositar. [${response.statusCode}]-'
          '${response.json}');
    }

    return PiggyModel.fromJson(response.json);
  }
}
