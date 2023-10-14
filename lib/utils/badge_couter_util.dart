int countAllBadges(Map<dynamic, dynamic> developedSkills) {
  int badgeCount = 0;
  for (String skillKey in developedSkills.keys) {
    Map<dynamic, dynamic> skills = developedSkills[skillKey];
    for (String subSkillKey in skills.keys) {
      Map<dynamic, dynamic> subskills = skills[subSkillKey];
      badgeCount += subskills['grade'] as int;
    }
  }
  return badgeCount;
}

int countSkillBadges(Map<dynamic, dynamic> developedSubskills) {
  int badgeCount = 0;
  for (String subSkillKey in developedSubskills.keys) {
    Map<dynamic, dynamic> subskills = developedSubskills[subSkillKey];
    badgeCount += subskills['grade'] as int;
  }
  return badgeCount;
}
