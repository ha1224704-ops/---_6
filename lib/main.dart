import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const QuranApp());
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1117),
      ),
      home: const HomeScreen(),
    );
  }
}

final reciters = [
  {"name": "المنشاوي", "id": "minshawi"},
  {"name": "عبد الباسط", "id": "abdulbasit"},
  {"name": "المعيقلي", "id": "maher"},
  {"name": "العفاسي", "id": "afasy"},
  {"name": "الدوسري", "id": "yasser"},
  {"name": "السديس", "id": "sudais"},
];

final surahNames = ["الفاتحة","البقرة","آل عمران","النساء","المائدة","الأنعام","الأعراف","الأنفال","التوبة","يونس","هود","يوسف","الرعد","إبراهيم","الحجر","النحل","الإسراء","الكهف","مريم","طه","الأنبياء","الحج","المؤمنون","النور","الفرقان","الشعراء","النمل","القصص","العنكبوت","الروم","لقمان","السجدة","الأحزاب","سبأ","فاطر","يس","الصافات","ص","الزمر","غافر","فصلت","الشورى","الزخرف","الدخان","الجاثية","الأحقاف","محمد","الفتح","الحجرات","ق","الذاريات","الطور","النجم","القمر","الرحمن","الواقعة","الحديد","المجادلة","الحشر","الممتحنة","الصف","الجمعة","المنافقون","التغابن","الطلاق","التحريم","الملك","القلم","الحاقة","المعارج","نوح","الجن","المزمل","المدثر","القيامة","الإنسان","المرسلات","النبأ","النازعات","عبس","التكوير","الانفطار","المطففين","الانشقاق","البروج","الطارق","الأعلى","الغاشية","الفجر","البلد","الشمس","الليل","الضحى","الشرح","التين","العلق","القدر","البينة","الزلزلة","العاديات","القارعة","التكاثر","العصر","الهمزة","الفيل","قريش","الماعون","الكوثر","الكافرون","النصر","المسد","الإخلاص","الفلق","الناس"];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String sel = "minshawi";
  final player = AudioPlayer();
  int? cur; bool playing = false;

  Future<void> play(int n) async {
    try {
      await player.setUrl("https://server8.mp3quran.net/$sel/${n.toString().padLeft(3,'0')}.mp3");
      await player.play();
      setState((){cur=n; playing=true;});
    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("البرنامج يفتح بدون نت، بس الصوت يحتاج نت")));
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("القرآن الكريم")),
      body: Column(children:[
        DropdownButton(value: sel, isExpanded: true, items: reciters.map((r)=>DropdownMenuItem(value: r["id"], child: Text(r["name"]!))).toList(), onChanged: (v)=>setState(()=>sel=v!)),
        Expanded(child: ListView.builder(itemCount: 114, itemBuilder: (c,i)=>ListTile(leading: Text("${i+1}"), title: Text(surahNames[i]), trailing: IconButton(icon: const Icon(Icons.play_arrow), onPressed: ()=>play(i+1)))))
      ]),
    );
  }
}