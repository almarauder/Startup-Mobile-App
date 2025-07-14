import 'package:flutter/material.dart';
import 'package:startup_app/utils/date_parser.dart';
import 'package:startup_app/widgets/sort_widget.dart';

class HackatonPage extends StatefulWidget {
  @override
  _HackatonPageState createState() => _HackatonPageState();
}

class _HackatonPageState extends State<HackatonPage> {
  // На какой странице находится 
  int pageIndex = 0 ; 

  int _parseSalary(String salaryString) {
  final cleaned = salaryString.replaceAll(RegExp(r'[^0-9]'), '');
  return int.tryParse(cleaned) ?? 0;
  } 

  // Описание самой вакансии
  final List<Hackaton> hackatons = [
    Hackaton(
      title: 'Smart City Hackaton' ,
      location: 'Астана , Казахстан',
      theme: 'Городская инфраструктура , инклюзия , цифровые сервисы',
      prize: '1 500 000\₸ тенге' ,
      description:'Создай цифровые решения для умного города: сервисы для граждан, удобная навигация, доступная инфраструктура.Поддержка от экспертов, наставников и представителей акимата.' ,
      date: '28 Март 2025',
      organizator: "Astana Hub" , 
    ),
  ];

  // Сортировка 
  String _sortBy = 'Новизне' ; 
  final _sortOptions = ['Новизне' , 'Призу'] ; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.tune , color: Colors.black),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Поиск',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.search, color: Colors.black),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Информация про хакатоны' , 
                  style:
                      const TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.w700 , 
                      ),
                ),
              ),
            ), 

            const SizedBox(width: 8) , 

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SortByWidget(
                currentValue: _sortBy , 
                options: _sortOptions,
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                        _sortBy = val ; 

                        if (_sortBy == 'Новизне') {
                          hackatons.sort((a , b) {
                            final aDate = DateParser.parse(a.date) ?? DateTime(2000) ; 
                            final bDate = DateParser.parse(b.date) ?? DateTime(2000) ; 
                            return bDate.compareTo(aDate);
                          }) ; 
                        } else if (_sortBy == 'Зарплате') {
                          hackatons.sort((a , b) =>
                            _parseSalary(b.prize).compareTo(_parseSalary(a.prize))) ; 
                        }
                    }) ; 
                  }
                } , 
              ),
            ),

            const SizedBox(height: 8),

            // Job list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: hackatons.length,
                itemBuilder: (context, index) {
                  return HackatonCard(hackaton: hackatons[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Модель Хакатона
class Hackaton {
  final String title;
  final String location;
  final String theme;
  final String prize;
  final String description;
  final String date;
  final String organizator; 

  Hackaton({
    required this.title,
    required this.location,
    required this.theme,
    required this.prize,
    required this.description,
    required this.date,
    required this.organizator, 
  });
}

// Виджет карточки вакансии
class HackatonCard extends StatelessWidget {
  final Hackaton hackaton;

  const HackatonCard({Key? key, required this.hackaton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Header: logo, title, salary, bookmark
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hackaton.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Призовой фонд : ${hackaton.prize}' , 
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              hackaton.theme , 
              style: TextStyle(
                color: Color.fromARGB(255, 0, 98, 255) , 
                fontWeight: FontWeight.w500 , 
                fontSize: 13 ,
              )
            ) , 

            const SizedBox(height: 8),

            ClipRRect(
              borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'images/astanahub_logo.png',
                  width: 143.77,
                  height: 37,
                  fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Организатор: ${hackaton.organizator}" , 
              style: TextStyle(
                fontWeight: FontWeight.w600 , 
                fontSize: 14 , 
              )
            ) , 

            const SizedBox(height: 8),

            Text(
              "Город: ${hackaton.location}" , 
              style: TextStyle(
                fontWeight: FontWeight.w600 , 
                fontSize: 14 , 
              )
            ) , 

            const SizedBox(height: 8),

            // Description snippet
            Text(
              hackaton.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: () {

              } ,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEAF1FF) , 
                foregroundColor: Colors.blue , 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12) , 
                )
              ) , 
              child: Text('Участвовать')
            ) , 
            
            // Footer: date and action icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hackaton.date,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
                Row(
                  children: const [
                    Icon(Icons.visibility_off, size: 16),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
