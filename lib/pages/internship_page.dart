import 'package:flutter/material.dart';
import 'package:startup_app/utils/date_parser.dart';
import 'package:startup_app/widgets/sort_widget.dart';

class InternshipPage extends StatefulWidget {
  @override
  _InternshipPageState createState() => _InternshipPageState();
}

class _InternshipPageState extends State<InternshipPage> {

  // Парсинг для сортировки 
  int _parseSalary(String salaryString) {
  final cleaned = salaryString.replaceAll(RegExp(r'[^0-9]'), '');
  return int.tryParse(cleaned) ?? 0;
  } 

  // Описание самой вакансии
  final List<Internship> internships = [
    Internship(
      title: 'Стажёр UX/UI - Дизайнер' ,
      location: 'Алматы, Казахстан',
      level: 'Начальный уровень' ,
      type: 'Частичная занятость',
      salary: '1800\$ в год' ,
      description:'Участвует в разработке пользовательских интерфейсов мобильных и веб-приложений. Помогает в создании wireframe’ов, прототипов, UI-компонентов и тестировании дизайнов. Работает с наставником из дизайн-команды..' ,
      tags: ['Оплачиваемая'] ,
      date: '28 Март 2025',
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
                  '${internships.length.toString().replaceAllMapped(RegExp(r"\\B(?=(\\d{3})+(?!\\d))"), (match) => ",")} Найдено стажировок',
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
                          internships.sort((a , b) {
                            final aDate = DateParser.parse(a.date) ?? DateTime(2000) ; 
                            final bDate = DateParser.parse(b.date) ?? DateTime(2000) ; 
                            return bDate.compareTo(aDate);
                          }) ; 
                        } else if (_sortBy == 'Зарплате') {
                          internships.sort((a , b) =>
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
                itemCount: internships.length,
                itemBuilder: (context, index) {
                  return InternshipCard(internship: internships[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Модель стажировки 
class Internship {
  final String title;
  final String location;
  final String level;
  final String type;
  final String salary;
  final String description;
  final List<String> tags;
  final String date;

  Internship({
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
class InternshipCard extends StatelessWidget {
  final Internship internship;

  const InternshipCard({Key? key, required this.internship}) : super(key: key);

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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'images/up_logo.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        internship.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        internship.location , 
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
              '${internship.level} | ${internship.type}' , 
              style: TextStyle(
                fontWeight: FontWeight.w700 , 
                fontSize: 14 ,
              )
            ) , 

            const SizedBox(height: 8),

            Text(
              internship.salary , 
              style: TextStyle(
                fontWeight: FontWeight.w700 , 
                fontSize: 14 ,
              )
            ) , 

            const SizedBox(height: 8),

            // Description snippet
            Text(
              internship.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
            const SizedBox(height: 8),
            // Tags
            Wrap(
              spacing: 8,
              children: internship.tags
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
                  internship.date,
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
