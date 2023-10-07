class SelfIdentificationModel {
  final String category;
  final List<String> questions;
  const SelfIdentificationModel(
      {required this.category, required this.questions});
}

List<SelfIdentificationModel> allSelfIdentification = [
  SelfIdentificationModel(category: 'Prerequisites', questions: [
    'Name a hobby or interest that you\'re passionate about.',
    'Name a long-term goal you have',
    'Describe a challenge you\'ve overcome.'
  ]),
  SelfIdentificationModel(category: 'Personal Values', questions: [
    'Identify your top three personal values.',
    'Reflect on how these values influence your decisions.',
    'Consider whether your values align with your actions',
    'Explore any values that have changed over time',
    'Think about how your values reflect your relationships.'
  ]),
  SelfIdentificationModel(category: 'Strengths and Weaknesses', questions: [
    'List your top three strengths and describe how they benefit you.',
    'Reflect on how your strengths contribute to your personal and professional life.',
    'Recognize your top three weaknesses and how they impact you.',
    'Explore strategies to mitigate the impact of your weaknesses.',
    'Create a plan for personal development based on your strengths and weaknesses.'
  ]),
  SelfIdentificationModel(category: 'Passions and Interests', questions: [
    'List your three most significant passions or interests',
    'Identify ways to share your passions with others',
    'Set goals to deepen your knowledge or skills in your areas of interest.',
    'Share stories or experiences that ignited your interests.',
    'Consider how your passions align with your long-term goals.'
  ]),
  SelfIdentificationModel(category: 'Roles and Identities', questions: [
    'List the roles or identities you currently identify with.',
    'Identify roles that are influenced by societal expectations.',
    'Reflect on the balance between your different roles.',
    'Share personal stories related to your roles and identities.',
    'Set intentions for how you want to embrace and grow within your roles.'
  ]),
  SelfIdentificationModel(category: 'Goals and Aspirations', questions: [
    'Define your short-term goals for the next three months.',
    'List your long-term aspirations and dreams.',
    'Break down your long-term goals into smaller, actionable steps.',
    'Reflect on the significance of each goal in your life.',
    'Celebrate your achievements and milestones along the way.'
  ]),
  SelfIdentificationModel(category: 'Challenges and Resillience', questions: [
    'List the most significant challenges you\'ve faced in life.',
    'Reflect on how you responded to these challenges.',
    'Identify the lessons or growth you gained from each challenge.',
    'Explore your resilience strategies and coping mechanisms.',
    'Reflect on the role of mindset in overcoming adversity.'
  ]),
  SelfIdentificationModel(category: 'Moral and Ethical Beliefs', questions: [
    'Identify your core moral and ethical principles.',
    'Reflect on the sources that have influenced your beliefs.',
    'Consider how your moral and ethical beliefs guide your decision-making.',
    'Explore any ethical dilemmas you\'ve encountered in life.',
    'Reflect on situations where your beliefs were tested.'
  ]),
  SelfIdentificationModel(category: 'Role Models and Inspirations', questions: [
    'List the individuals who inspire you the most.',
    'Reflect on the qualities or actions that make them inspirational.',
    'Consider how these role models have influenced your life choices.',
    'Identify role models who share your values and aspirations.',
    'Reach out to or learn more about your role models if possible.'
  ]),
  SelfIdentificationModel(category: 'Self-Care and Well-Being', questions: [
    'List your self-care practices that promote physical health.',
    'Identify self-care routines that support your mental well-being.',
    'Reflect on how self-care enhances your overall quality of life.',
    'Set boundaries to protect your well-being.',
    'Explore new self-care activities or hobbies.'
  ]),
];
