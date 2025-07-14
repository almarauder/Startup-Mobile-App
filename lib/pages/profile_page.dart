import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final List<Profile> profiles = [
    Profile(
      name: 'Макпыр Маруа',
      profession: 'Инженер Программист | UX/UI Дизайнер' ,
      email: 'makpyrmarua@gmail.com' ,
      birthday: '01.01.2001' ,
      type: 'Полный День' ,
      phone_number: '8 777 666 55 44' ,
      description:'Участвует в разработке пользовательских интерфейсов мобильных и веб-приложений. Помогает в создании wireframe’ов, прототипов, UI-компонентов и тестировании дизайнов. Работает с наставником из дизайн-команды.',
      hardSkills: ['UX/UI Design' , 'Английский С1' , 'ООП' , 'Java' , 'Python' , 'Программирование'] , 
      softSkills: ['Ответственность' , 'Коммуникабельность' , 'Тайм-менеджмент' , 'Адаптивность'] , 
    ),
  ];

  void openProjects() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                'UX/UI дизайн',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              TextButton.icon(
                onPressed: () {},
                  icon: const Icon(Icons.description, color: Colors.blue),
                  label: const Text(
                    'Мой Behance  ',
                    style: TextStyle(color: Colors.blue),
                  ),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
              ) , 

              const SizedBox(height: 16),

              ProjectCard(
                title: 'Мобильное приложение Echo',
                location: 'Алматы, Казахстан',
                company: 'IITU - NIC',
                schedule: 'Полный день\n9:00 - 17:00',
                description:
                    'Разработано мобильное приложение для коммуникации Echo. Отвечала за полный дизайн приложения с самого начала. Создала основной стиль. Прототипирование и создание полностью дизайна моб.приложения.',
                tags: ['Дизайн', 'User Experience'],
                startDate: '28 Март 2024',
                endDate: '05 Май 2024',
                image: 'images/company2.png',
              ),

              const SizedBox(height: 16),

              ProjectCard(
                title: 'Мобильное приложение Smart Konaev',
                location: 'Алматы, Казахстан',
                company: 'Alatau Hub',
                schedule: 'Стажировка',
                description: 'Дизайн мобильного приложения для города Конаев, в рамках проекта Smart Konaev. Прототипирование, дизайн с самого начала.',
                tags: ['Дизайн', 'User Experience'],
                startDate: '06 Июнь 2025',
                endDate: '26 Июнь 2025',
                image: 'images/company2.png',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.description, color: Colors.blue),
                    label: const Text(
                      'Мое резюме',
                      style: TextStyle(color: Colors.blue),
                    ),
                    
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  TextButton.icon(
                    onPressed: openProjects,
                    icon: const Icon(Icons.folder_open, color: Colors.blue),
                    label: const Text(
                      'Мои проекты',
                      style: TextStyle(color: Colors.blue),
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              ProfileCard(profile: profiles[0]),
              
              const SizedBox(height: 16),

              Row(
                children: [
                  Icon(
                    Icons.book , 
                    color: Colors.blue , 
                    size: 25 , 
                  ) , 

                  const SizedBox(width: 12) , 

                  Text(
                    'Навыки' , 
                    style: TextStyle(
                      fontWeight: FontWeight.bold , 
                      fontSize: 22 , 
                    )
                  )
                ],
              ) , 
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12) , 
                ) , 
                child: Padding(
                  padding: EdgeInsets.all(12) , 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [
                      Text(
                        'Hard Skills (подтверждено)' , 
                        style: TextStyle(
                          fontWeight: FontWeight.w600 , 
                        )
                      ) , 

                      const SizedBox(width: 12) , 

                      Wrap(
                        spacing: 8 , 
                        runSpacing: 8 , 
                        children: profiles[0].hardSkills 
                            .map((tag) => Chip(label: Text(tag))) 
                            .toList() , 
                      )
                    ],
                  )
                )
              ) , 

              const SizedBox(height: 12) , 
              
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12) , 
                ) , 
                child: Padding(
                  padding: EdgeInsets.all(12) , 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [
                      Text(
                        'Soft Skills' , 
                        style: TextStyle(
                          fontWeight: FontWeight.w600 , 
                        )
                      ) , 

                      const SizedBox(width: 12) , 

                      Wrap(
                        spacing: 8 , 
                        runSpacing: 8 , 
                        children: profiles[0].softSkills 
                            .map((tag) => Chip(label: Text(tag))) 
                            .toList() , 
                      )
                    ],
                  )
                )
              ) 
            ],
          ),
        ),
      ),
    );
  }
}

class Profile {
  final String name;
  final String profession;
  final String email;
  final String birthday;
  final String phone_number;
  final String description;
  final String type;
  final List<String> hardSkills; 
  final List<String> softSkills; 

  Profile({
    required this.name,
    required this.profession,
    required this.email,
    required this.birthday,
    required this.phone_number,
    required this.description,
    required this.type,
    required this.hardSkills,
    required this.softSkills,
  });
}

class ProfileCard extends StatelessWidget {
  final Profile profile;

  const ProfileCard({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'images/marua_profile.png',
                height: 180,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              profile.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Text(
              profile.profession,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                const Icon(Icons.email, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(child: Text(profile.email)),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(child: Text('Дата рождения: ${profile.birthday}')),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.phone, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(child: Text(profile.phone_number)),
              ],
            ),

            const SizedBox(height: 24),

            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit, color: Colors.blue),
                label: const Text(
                  'Редактировать',
                   style: TextStyle(color: Colors.blue),
                ),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String location;
  final String company;
  final String schedule;
  final String description;
  final List<String> tags;
  final String startDate;
  final String endDate;
  final String image;

  const ProjectCard({
    Key? key,
    required this.title,
    required this.location,
    required this.company,
    required this.schedule,
    required this.description,
    required this.tags,
    required this.startDate,
    required this.endDate,
    required this.image,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    image,
                    width: 80,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(location),
                      const Text(
                        'Перейти в Behance профиль',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Место работы:\n$company' , 
                  style: TextStyle(
                    fontWeight: FontWeight.bold , 
                  )
                ),

                Text(
                  'Рабочий график:\n$schedule', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold , 
                  )
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(description),

            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              children: tags.map((t) => Chip(label: Text(t))).toList(),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(startDate),
                Text(endDate),
              ],
            )
          ],
        ),
      ),
    );
  }
}
