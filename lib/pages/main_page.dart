import 'package:flutter/material.dart';
import 'package:startup_app/widgets/sort_widget.dart';
import 'package:startup_app/utils/date_parser.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  // Парсинг для сортировки 
  int _parseSalary(String salaryString) {
  final cleaned = salaryString.replaceAll(RegExp(r'[^0-9]'), '');
  return int.tryParse(cleaned) ?? 0;
  } 

  // Описание самой вакансии
  final List<Job> jobs = [
    Job(
      logo: 'images/up_logo.png' ,
      isAssetImage: true,
      title: 'Менеджер по прямым продажам на передовой линии' ,
      location: 'Алматы, Казахстан ',
      level: 'Средне-старший уровень' ,
      type: 'Полная занятость',
      salary: '10,520\$ в год' ,
      description:'Осуществляет прямые продажи продуктов или услуг клиентам, проводит встречи, презентации и консультирует покупателей.' ,
      tags: ['Продажи', 'Менеджер', 'Старший уровень'] ,
      date: '28 Март 2025',
    ),

    Job(
      logo: 'images/company1.jpg' ,
      isAssetImage: true,
      title: 'Програмист на С++' ,
      location: 'Прага , Чехия',
      level: 'Средне-старший уровень' ,
      type: 'Полная занятость',
      salary: '90,000\$ в год' ,
      description:'Разрабатывает Программно Обеспечение для Чешских Граждан' ,
      tags: ['C++', 'Разработка ПО'] ,
      date: '25 Март 2025',
    ),

    Job(
      logo: 'images/company2.png' ,
      isAssetImage: true,
      title: 'Кибербезопасник' ,
      location: 'Астана, Казахстан',
      level: 'старший уровень' ,
      type: 'Полная занятость',
      salary: '10,520\$ в год' ,
      description:'Осуществляет защиту Программного Обеспечения от всяких угроз по типу Хакеров' ,
      tags: ['Продажи', 'Менеджер', 'Старший уровень'] ,
      date: '23 Март 2025',
    ),
  ];

  // Сортировка 
  String _sortBy = 'Новизне' ; 
  final _sortOptions = ['Новизне' , 'Зарплате'] ; 

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
                  Icon(Icons.tune, color: Colors.black),
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

            // Found count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${jobs.length.toString().replaceAllMapped(RegExp(r"\\B(?=(\\d{3})+(?!\\d))"), (match) => ",")} Найдено вакансий',
                  style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ), 

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
                          jobs.sort((a , b) {
                            final aDate = DateParser.parse(a.date) ?? DateTime(2000) ; 
                            final bDate = DateParser.parse(b.date) ?? DateTime(2000) ; 
                            return bDate.compareTo(aDate);
                          }) ; 
                        } else if (_sortBy == 'Зарплате') {
                          jobs.sort((a , b) =>
                            _parseSalary(b.salary).compareTo(_parseSalary(a.salary))) ; 
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
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  return JobCard(job: jobs[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Модель вакансии
class Job {
  final String logo;
  final bool isAssetImage; 
  final String title;
  final String location;
  final String level;
  final String type;
  final String salary;
  final String description;
  final List<String> tags;
  final String date;

  Job({
    required this.logo,
    required this.isAssetImage,
    required this.title,
    required this.location,
    required this.level,
    required this.type,
    required this.salary,
    required this.description,
    required this.tags,
    required this.date,
  });
}

// Виджет карточки вакансии
class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget logoWidget = job.isAssetImage
      ? Image.asset(job.logo , width:60 , height:60 , fit:BoxFit.cover) 
      : Image.network(job.logo , width:60 , height:60 , fit:BoxFit.cover) ; 

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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: logoWidget , 
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        job.location , 
                        style: TextStyle(
                            fontSize: 14, color: const Color.fromARGB(255, 0, 98, 255)),
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
              '${job.level} | ${job.type}' , 
              style: TextStyle(
                fontWeight: FontWeight.w700 , 
                fontSize: 14 ,
              )
            ) , 

            Text(
              job.salary , 
              style: TextStyle(
                fontWeight: FontWeight.w700 , 
                fontSize: 14 ,
              )
            ) , 

            // Description snippet
            Text(
              job.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
            const SizedBox(height: 8),
            // Tags
            Wrap(
              spacing: 8,
              children: job.tags
                  .map((tag) => Chip(
                        label: Text(tag),
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                      ))
                  .toList(),
            ),

            const SizedBox(height: 8),
            
            // Footer: date and action icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  job.date,
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
