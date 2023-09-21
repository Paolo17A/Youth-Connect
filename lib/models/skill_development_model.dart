class SkillDevelopmentModel {
  String skillName;
  String assetPath;
  List<SubSkillModel> subSkills;
  SkillDevelopmentModel(
      {required this.skillName,
      required this.assetPath,
      required this.subSkills});
}

class SubSkillModel {
  String subSkillName;
  TaskType requiredTaskType;
  String taskName;
  String taskDescription;
  SubSkillModel(
      {required this.subSkillName,
      required this.requiredTaskType,
      required this.taskName,
      required this.taskDescription});
}

enum TaskType { QUIZ, ESSAY, VIDEO }

List<SkillDevelopmentModel> allSkillDevelopment = [
  SkillDevelopmentModel(
      skillName: 'Leadership and Communication',
      assetPath: 'lib/assets/images/icons/icons-leadership.png',
      subSkills: [
        SubSkillModel(
            subSkillName: 'Effective Communication',
            requiredTaskType: TaskType.VIDEO,
            taskName: 'Create a Virtual Storytelling Session',
            taskDescription:
                'Imagine you are hosting a virtual storytelling session for a group of young children. Create a short video where you tell an engaging story. Focus on using clear and expressive communication to convey the emotions of the story.'),
        SubSkillModel(
            subSkillName: 'Teamwork and collaboration',
            requiredTaskType: TaskType.ESSAY,
            taskName: 'Describe your teamwork abilities',
            taskDescription:
                'Write a short essay talking about how well you work with others'),
        SubSkillModel(
            subSkillName: 'Public Speaking',
            requiredTaskType: TaskType.ESSAY,
            taskName: 'Campaign for a brighter future',
            taskDescription:
                'Create a campaign video as if you are running for a local government position. Show us your platform and promises.'),
      ]),
  SkillDevelopmentModel(
      skillName: 'Personal Development',
      assetPath: '',
      subSkills: [
        SubSkillModel(
            subSkillName: 'Time Management',
            requiredTaskType: TaskType.ESSAY,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Self-Awareness',
            requiredTaskType: TaskType.ESSAY,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Emotional Awareness',
            requiredTaskType: TaskType.ESSAY,
            taskName: '',
            taskDescription: '')
      ]),
  SkillDevelopmentModel(
      skillName: 'Creativity and Innovation',
      assetPath: 'lib/assets/images/icons/icons-creativity.png',
      subSkills: [
        SubSkillModel(
            subSkillName: 'Critical Thinking',
            requiredTaskType: TaskType.QUIZ,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Design and Thinking',
            requiredTaskType: TaskType.VIDEO,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Artistic Expression',
            requiredTaskType: TaskType.ESSAY,
            taskName: '',
            taskDescription: '')
      ]),
  SkillDevelopmentModel(
      skillName: 'Career Readiness',
      assetPath: 'lib/assets/images/icons/icons-career.png',
      subSkills: [
        SubSkillModel(
            subSkillName: 'Resume Writing',
            requiredTaskType: TaskType.ESSAY,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Interview Skills',
            requiredTaskType: TaskType.ESSAY,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Professional Etiquette',
            requiredTaskType: TaskType.QUIZ,
            taskName: '',
            taskDescription: '')
      ]),
  SkillDevelopmentModel(
      skillName: 'Digital Literacy',
      assetPath: 'lib/assets/images/icons/icons-digital.png',
      subSkills: [
        SubSkillModel(
            subSkillName: 'Basic Computer Skills',
            requiredTaskType: TaskType.QUIZ,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Online Communication',
            requiredTaskType: TaskType.VIDEO,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Using Productivity Tools',
            requiredTaskType: TaskType.QUIZ,
            taskName: '',
            taskDescription: '')
      ]),
  SkillDevelopmentModel(
      skillName: 'Health and Well-being',
      assetPath: 'lib/assets/images/icons/icons-health.png',
      subSkills: [
        SubSkillModel(
            subSkillName: 'Physical Fitness',
            requiredTaskType: TaskType.VIDEO,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Mental Health Awareness',
            requiredTaskType: TaskType.ESSAY,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Stress Management',
            requiredTaskType: TaskType.ESSAY,
            taskName: '',
            taskDescription: '')
      ]),
  SkillDevelopmentModel(
      skillName: 'Environmental Awareness',
      assetPath: 'lib/assets/images/icons/icons-environmental.png',
      subSkills: [
        SubSkillModel(
            subSkillName: 'Sustainability Practices',
            requiredTaskType: TaskType.QUIZ,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Waste Reduction',
            requiredTaskType: TaskType.QUIZ,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Eco-friendly Lifestyle',
            requiredTaskType: TaskType.QUIZ,
            taskName: '',
            taskDescription: '')
      ]),
  SkillDevelopmentModel(
      skillName: 'Civic Engagement',
      assetPath: '',
      subSkills: [
        SubSkillModel(
            subSkillName: 'Community Service',
            requiredTaskType: TaskType.ESSAY,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Advocacy and Activism',
            requiredTaskType: TaskType.VIDEO,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Understanding Local Government',
            requiredTaskType: TaskType.ESSAY,
            taskName: '',
            taskDescription: '')
      ]),
  SkillDevelopmentModel(
      skillName: 'Cultural Appreciation',
      assetPath: '',
      subSkills: [
        SubSkillModel(
            subSkillName: 'History and Heritage',
            requiredTaskType: TaskType.QUIZ,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Cultural Diversity',
            requiredTaskType: TaskType.VIDEO,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Arts and Traditions',
            requiredTaskType: TaskType.QUIZ,
            taskName: '',
            taskDescription: '')
      ]),
  SkillDevelopmentModel(skillName: 'Tech Skills', assetPath: '', subSkills: [
    SubSkillModel(
        subSkillName: 'Coding Basics',
        requiredTaskType: TaskType.QUIZ,
        taskName: '',
        taskDescription: ''),
    SubSkillModel(
        subSkillName: 'Graphic Design',
        requiredTaskType: TaskType.ESSAY,
        taskName: '',
        taskDescription: ''),
    SubSkillModel(
        subSkillName: 'Video Editing',
        requiredTaskType: TaskType.QUIZ,
        taskName: '',
        taskDescription: '')
  ]),
  SkillDevelopmentModel(
      skillName: 'Language Learning',
      assetPath: '',
      subSkills: [
        SubSkillModel(
            subSkillName: 'Learning a New Language',
            requiredTaskType: TaskType.QUIZ,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Conversational Skills',
            requiredTaskType: TaskType.VIDEO,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Reading and Writing in another language',
            requiredTaskType: TaskType.ESSAY,
            taskName: '',
            taskDescription: '')
      ]),
  SkillDevelopmentModel(
      skillName: 'Entrepreneurship',
      assetPath: '',
      subSkills: [
        SubSkillModel(
            subSkillName: 'Business Planning',
            requiredTaskType: TaskType.ESSAY,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Marketing and Sales',
            requiredTaskType: TaskType.QUIZ,
            taskName: '',
            taskDescription: ''),
        SubSkillModel(
            subSkillName: 'Innovation and Ideation',
            requiredTaskType: TaskType.VIDEO,
            taskName: '',
            taskDescription: '')
      ]),
];
