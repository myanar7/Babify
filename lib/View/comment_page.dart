import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_socket_channel/io.dart';

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
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextField(
                      cursorColor: Colors.pink,
                      controller: _textController,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () => setState(() {
                                final channel = IOWebSocketChannel.connect(
                                    'wss://demo.piesocket.com/v3/channel_1?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self');
                                channel.sink.add(_textController.text);
                                channel.sink.close();
                                //DIKKAT ET BUNU KULLANIRKEN COMMENTPROVIDERDA SENDERI BU KİŞİ OLDUĞUNDA YİELD ETMEMESİ LAZIM ONU DA DÜZENLE YOKSA İKİ KERE BASAR
                                //IKINCI BIR SORUN ISE WS DEN GELEN BIR DEGISIKLIKTE SAYFA RELOAD YAPTIGI ICIN NULL OLUYOR ONA BI COZUM LAZIM
                              }),
                          icon: const Icon(Icons.send)))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _commentListLocal.length,
              itemBuilder: ((context, index) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 15.0),
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 240, 195, 192),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Text(
                      //   message.time,
                      //   style: TextStyle(
                      //     color: Colors.blueGrey,
                      //     fontSize: 16.0,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      const SizedBox(height: 8.0),
                      Text(
                        _commentListLocal[index],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
