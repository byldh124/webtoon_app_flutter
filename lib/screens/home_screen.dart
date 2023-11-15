import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:webtoon_app/models/webtoon.dart';
import 'package:webtoon_app/services/api_service.dart';
import 'package:webtoon_app/widget/webtoon_widget.dart';

class HomeScreen2 extends StatelessWidget {
  HomeScreen2({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //backgroundColor -> Appbar 배경색이 바뀜
        backgroundColor: Colors.white,
        //foregroundColor -> 타이틀의 색이 바뀜
        foregroundColor: Colors.green,
        elevation: 1,
        title: const Text(
          '오늘의 웹툰',
          style: TextStyle(
            fontSize: 26,
            //fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Similar Android ListView
            /*return ListView(
              children: [
                for (var webtoon in snapshot.data!)
                  Text(webtoon.title)
              ],
            );*/
            // Similar Android RecyclerView
            /*return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                //print(index);
                var webtoon = data[index];
                return Text(webtoon.title);
              },
            );*/

            //return makeList(snapshot);
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(snapshot),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    final data = snapshot.data!;
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        itemBuilder: (context, index) {
          //print(index);
          var webtoon = data[index];
          return Webtoon(
            title: webtoon.title,
            thumb: webtoon.thumb,
            id: webtoon.id,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 40,
          );
        });
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  void waitForWebToons() async {
    webtoons = await ApiService.getTodaysToons();
    isLoading = false;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitForWebToons();
  }*/

  @override
  Widget build(BuildContext context) {
    //print(webtoons);
    //print(isLoading);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //backgroundColor -> Appbar 배경색이 바뀜
        backgroundColor: Colors.white,
        //foregroundColor -> 타이틀의 색이 바뀜
        foregroundColor: Colors.green,
        elevation: 1,
        title: const Text(
          '오늘의 웹툰',
          style: TextStyle(
            fontSize: 26,
            //fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
