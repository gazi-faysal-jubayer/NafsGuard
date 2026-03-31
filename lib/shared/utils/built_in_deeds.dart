import '../../core/models/deed.dart';
import '../../core/models/deed_category.dart';

final List<Deed> builtInDeeds = [
  // Tongue (7)
  const Deed(
    id: 'tongue_1',
    title: 'Recite Ayatul Kursi once',
    category: DeedCategory.tongue,
    durationSeconds: 60,
  ),
  const Deed(
    id: 'tongue_2',
    title: 'Say Astaghfirullah 10 times',
    category: DeedCategory.tongue,
    durationSeconds: 30,
  ),
  const Deed(
    id: 'tongue_3',
    title: 'Send Salawat upon the Prophet \uFDFA 10 times',
    category: DeedCategory.tongue,
    durationSeconds: 40,
  ),
  const Deed(
    id: 'tongue_4',
    title: 'Say SubhanAllah 33 times',
    category: DeedCategory.tongue,
    durationSeconds: 60,
  ),
  const Deed(
    id: 'tongue_5',
    title: 'Say Alhamdulillah 33 times',
    category: DeedCategory.tongue,
    durationSeconds: 60,
  ),
  const Deed(
    id: 'tongue_6',
    title: 'Say Allahu Akbar 34 times',
    category: DeedCategory.tongue,
    durationSeconds: 70,
  ),
  const Deed(
    id: 'tongue_7',
    title: 'Recite Surah Al-Ikhlas 3 times',
    category: DeedCategory.tongue,
    durationSeconds: 90,
  ),

  // Action (5)
  const Deed(
    id: 'action_1',
    title: "Send a 'JazakAllah Khair' message to someone you appreciate",
    category: DeedCategory.action,
  ),
  const Deed(
    id: 'action_2',
    title: 'Delete 5 unnecessary photos or files from your phone',
    category: DeedCategory.action,
  ),
  const Deed(
    id: 'action_3',
    title: 'Make a 1-minute silent Dua for the Ummah',
    category: DeedCategory.action,
    durationSeconds: 60,
  ),
  const Deed(
    id: 'action_4',
    title: 'Smile and send a kind voice note to a family member',
    category: DeedCategory.action,
  ),
  const Deed(
    id: 'action_5',
    title: 'Give a small amount in digital Sadaqah (charity app)',
    category: DeedCategory.action,
  ),

  // Knowledge (4)
  const Deed(
    id: 'knowledge_1',
    title: 'Read one translated verse of the Quran and reflect',
    category: DeedCategory.knowledge,
    durationSeconds: 120,
  ),
  const Deed(
    id: 'knowledge_2',
    title: 'Learn one Name of Allah and its meaning — write it down',
    category: DeedCategory.knowledge,
    durationSeconds: 120,
  ),
  const Deed(
    id: 'knowledge_3',
    title: 'Read one Hadith from a Hadith app or bookmark',
    category: DeedCategory.knowledge,
    durationSeconds: 90,
  ),
  const Deed(
    id: 'knowledge_4',
    title: 'Watch a 2-minute Islamic reminder clip',
    category: DeedCategory.knowledge,
    durationSeconds: 120,
  ),

  // Physical (5)
  const Deed(
    id: 'physical_1',
    title: 'Drink a full glass of water — seated, calmly',
    category: DeedCategory.physical,
    durationSeconds: 30,
  ),
  const Deed(
    id: 'physical_2',
    title: 'Correct your posture and take 5 deep breaths',
    category: DeedCategory.physical,
    durationSeconds: 30,
  ),
  const Deed(
    id: 'physical_3',
    title: 'Perform Wudu (ablution) if not already in state of purity',
    category: DeedCategory.physical,
  ),
  const Deed(
    id: 'physical_4',
    title: 'Stand up, stretch both arms, touch your toes',
    category: DeedCategory.physical,
    durationSeconds: 45,
  ),
  const Deed(
    id: 'physical_5',
    title: 'Do 10 slow neck rolls and relax your shoulders',
    category: DeedCategory.physical,
    durationSeconds: 45,
  ),
];
