import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piggywise_simulator/consumer/piggy_consumer.dart';
import 'package:piggywise_simulator/model/piggy_model.dart';

///
///
///
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

///
///
///
class _HomeState extends State<Home> {
  final List<int> coinValues = <int>[1, 5, 10, 25, 50, 100];
  final TextEditingController piggyCodeController = TextEditingController();

  ///
  ///
  ///
  @override
  void initState() {
    piggyCodeController.text = 'PIGGY1';
    super.initState();
  }

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Piggywise Simulator'),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            space,

            /// Piggy Image
            Center(
              child: SvgPicture.asset(
                'assets/piggy.svg',
                height: 150,
                colorFilter: const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
            ),
            space,

            /// Coin Buttons
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: coinValues.map((final int element) {
                  return Padding(
                    padding: const EdgeInsets.all(13),
                    child: GestureDetector(
                      onTap: () => _deposit(context, element),
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.yellow.shade600,
                        radius: 54,
                        child: CircleAvatar(
                          backgroundColor: Colors.yellow.shade800,
                          foregroundColor: Colors.yellow,
                          radius: 50,
                          child: Text(
                            '$element',
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            space,

            /// Config
            CupertinoListSection.insetGrouped(
              children: <Widget>[
                CupertinoFormRow(
                  prefix: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(CupertinoIcons.qrcode),
                      SizedBox(width: 8),
                      Text(
                        'Code',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  child: CupertinoTextFormFieldRow(
                    controller: piggyCodeController,
                    placeholder: 'Piggy Code',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  ///
  ///
  ///
  Future<PiggyModel?> _deposit(
    final BuildContext context,
    final int value,
  ) async {
    final PiggyConsumer piggyConsumer = PiggyConsumer();

    try {
      final PiggyModel piggy =
          await piggyConsumer.deposit(piggyCodeController.text, value);

      if (context.mounted) {
        await showCupertinoDialog(
          context: context,
          builder: (final BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text('Depósito Realizado'),
              content: Text('$value depositado com sucesso em ${piggy.name} \n'
                  'Saldo atual: ${piggy.balance}'),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }

      return piggy;
    } on Exception catch (e) {
      if (kDebugMode) {
        if (context.mounted) {
          await showCupertinoDialog(
            context: context,
            builder: (final BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text('Erro'),
                content: Text('Erro ao depositar $value: $e'),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }

        print(e);
      }

      return null;
    }
  }
}

///
///
///
SizedBox get space => const SizedBox(height: 16, width: 16);
