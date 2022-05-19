import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommentPage extends ConsumerStatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends ConsumerState<CommentPage> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<String>> _comments = ref.watch(commentProvider);
    List<String> _commentListLocal =
        _comments.value != null ? _comments.value! : [];
    TextEditingController _textController = TextEditingController();
    //it has to be local variable of comment page but it make itself null when the state refreshed

    // _comments.when(
    //   loading: () => const CircularProgressIndicator(),
    //   error: (err, stack) => Text('Error: $err'),
    //   data: (message) {
    //     print(message);
    //   },
    // );
    return SafeArea(
      child: Column(
        verticalDirection: VerticalDirection.up,
        children: [
          SizedBox(
            height: 100,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: _textController,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () => setState(() {
                              _commentListLocal.add(_textController.text);
                              //DIKKAT ET BUNU KULLANIRKEN COMMENTPROVIDERDA SENDERI BU KİŞİ OLDUĞUNDA YİELD ETMEMESİ LAZIM ONU DA DÜZENLE YOKSA İKİ KERE BASAR
                              //IKINCI BIR SORUN ISE WS DEN GELEN BIR DEGISIKLIKTE SAYFA RELOAD YAPTIGI ICIN NULL OLUYOR ONA BI COZUM LAZIM
                            }),
                        icon: const Icon(Icons.send)))
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _commentListLocal.length,
            itemBuilder: ((context, index) {
              return Text(_commentListLocal[index]);
            }),
          ),
        ],
      ),
    );
  }
}
