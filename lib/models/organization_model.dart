class OrganizationModel {
  String name;
  String nature;
  String contactDetails;
  String intro;
  String socMed;
  String logoURL;

  OrganizationModel(
      {required this.name,
      required this.nature,
      required this.contactDetails,
      required this.intro,
      required this.socMed,
      this.logoURL = ''});
}

List<OrganizationModel> allOrganizations = [
  OrganizationModel(
      name: "4H Club of Laguna",
      nature: "",
      contactDetails: "",
      intro:
          "HEAD to clearer thinking HEART to greater loyalty HANDS to larger service HEALTH to better living",
      socMed: "https://www.facebook.com/profile.php?id=100068184075919",
      logoURL: 'lib/assets/images/Organizations/4H CLUB OF LAGUNA.jpg'),
  OrganizationModel(
      name: "2030 Youth Foreign in the Philippines Incorporated",
      nature: "Youth and Labor",
      contactDetails: "",
      intro: "",
      socMed:
          "https://www.2030youthforce.org#2030YouthForcePHhttps://web.facebook.com/YouthForcePH",
      logoURL:
          'lib/assets/images/Organizations/2030 YOUTH FORCE IN THE PHILIPPINES INC.png'),
  OrganizationModel(
      name: "Ambagan PH",
      nature: "",
      contactDetails: "",
      intro:
          "Ambagan PH is a network of volunteers and initiatives responding to crisis situations through “amb",
      socMed: "https://web.facebook.com/ambaganphilippines?_rdc=1&_rdr",
      logoURL: 'lib/assets/images/Organizations/AMBAGAN PH.jpg'),
  OrganizationModel(
      name: "Anahaw Laguna (PYDC)",
      nature: "Social Group",
      contactDetails: "",
      intro:
          "Layunin ng organisasyon na paigtingin ang kaisipang Lagunense ukol sa kahalagahan ng agrikultura sa",
      socMed: "https://www.facebook.com/AnahawLaguna?mibextid=ZbWKwL",
      logoURL: 'lib/assets/images/Organizations/ANAHAW LAGUNA.jpg'),
  OrganizationModel(
    name: "Angat Kalikasan",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "Asean Youth Organization",
      nature: "",
      contactDetails: "",
      intro:
          "Through the regional programs such as, ASEAN Youth Conference, ASEAN Training, and ASEAN Youth Exchan",
      socMed: "https://www.facebook.com/ASEANPHL/",
      logoURL: 'lib/assets/images/Organizations/ASEAN YOUTH ORGANIZATION.jpg'),
  OrganizationModel(
    name: "Associated of Youth Development Officers",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "Creative Anime Inspired Theme Organization Caito",
      nature: "",
      contactDetails: "",
      intro:
          "Creative Anime Inspired Theme Organization (CAITO) is one of the recognized organizations in City Co",
      socMed: "https://www.facebook.com/CAITO2006",
      logoURL:
          'lib/assets/images/Organizations/52. CREATIVE ANIME INSPIRED THEME ORGANIZATION CAITO.jpg'),
  OrganizationModel(
      name: "Dangal ni Gat Tayaw",
      nature: "",
      contactDetails: "",
      intro:
          "Isang pribadong samahan ng mga kabataang Liliweno na nagnanais na pagtibayin ang sektor ng kabataan",
      socMed: "https://web.facebook.com/dangalnigattayaw2020",
      logoURL: 'lib/assets/images/Organizations/DANGAL NI GAT TAYAW.png'),
  OrganizationModel(
      name: "Gawad Laguna Incorporated",
      nature: "",
      contactDetails: "",
      intro:
          "Ang Gawad Laguna Inc, dating Gawad Felicisimo T San Luis Inc, ay isang pribadong samahang kumikilala",
      socMed: "https://www.facebook.com/GawadLaguna",
      logoURL:
          'lib/assets/images/Organizations/54.  GAWAD LAGUNA INCORPORATED.png'),
  OrganizationModel(
    name: "Girls Allied Empowered Advocacies Coalition",
    nature:
        "This is an organization that aims to promote climate and environmental action to young girls",
    contactDetails: "",
    intro: "",
    socMed: "https://www.facebook.com/geaecoalitionph?mibextid=ZbWKwL",
  ),
  OrganizationModel(
      name: "Good Gov. PH",
      nature: "",
      contactDetails: "",
      intro:
          "GoodGovPH is a youth-led movement for good governance in the Philippines.",
      socMed: "https://www.facebook.com/GoodGovPH?mibextid=ZbWKwL",
      logoURL: 'lib/assets/images/Organizations/GOOD GOV PH.png'),
  OrganizationModel(
      name: "Guhit Pinas - Laguna Chapter (GPL)",
      nature: "Community Based - Music Arts",
      contactDetails: "",
      intro: "This is the official page of GUHIT Pinas - Laguna chapter.",
      socMed: "https://www.facebook.com/gplagunaofficial",
      logoURL: 'lib/assets/images/Organizations/57. GUHIT PINAS LAGUNA.jpg'),
  OrganizationModel(
      name: "International Order of Demolay (Dr. Roman L. Kamatoy Chapter #31)",
      nature: "(Brotherhood - Fraternity) Community Based",
      contactDetails: "",
      intro: "International Order of DeMolay",
      socMed:
          "https://www.facebook.com/DeMolayInternationalOrder?mibextid=ZbWKwL",
      logoURL:
          'lib/assets/images/Organizations/INTERNATIONAL ORDER OF DEMOLAY.jpg'),
  OrganizationModel(
      name: "KKK - Kabataan sa Kartilya sa Katipunan",
      nature: "Community Based",
      contactDetails: "",
      intro: "Serbisyo at Talino ng Kabataan, Para sa Bayan",
      socMed: "https://www.facebook.com/KabataanSaKartilyaNgKatipunanPH",
      logoURL:
          'lib/assets/images/Organizations/KKK - Kabataan sa Kartilya ng Katipunan.jpg'),
  OrganizationModel(
      name: "Kabataang Likha ni Pedro",
      nature: "",
      contactDetails: "",
      intro:
          "We are Kabataang Likha ni Pedro — A Youth Organization formed by the collaboration of Pedro Guevar",
      socMed: "https://www.facebook.com/KLPLaguna",
      logoURL:
          'lib/assets/images/Organizations/60. KABATAANG LIKHA NI PEDRO.jpg'),
  OrganizationModel(
      name: "Kalikasan Pablo",
      nature: "",
      contactDetails: "",
      intro:
          "A youth-led organization advocating for environmental consciousness and sustainability in San Pablo",
      socMed: "https://www.facebook.com/kalikasanpablo",
      logoURL: 'lib/assets/images/Organizations/61. KALIKASAN PABLO.png'),
  OrganizationModel(
      name: "Katoto Project Organization",
      nature: "",
      contactDetails: "",
      intro:
          "Katoto Project is an Accredited Youth Non-Governmental Organization in Paete, Laguna, Philippines",
      socMed: "https://web.facebook.com/KatotoProjectOfficialPaete",
      logoURL:
          'lib/assets/images/Organizations/62. KATOTO PROJECT ORGANIZATION.jpg'),
  OrganizationModel(
      name: "Kiwanis Club of Laguna Phoenix",
      nature: "Service Organization -Social Group",
      contactDetails: "",
      intro: "Serving the Children of the World",
      socMed: "https://web.facebook.com/KCLP15",
      logoURL:
          'lib/assets/images/Organizations/KIWANIS CLUB OF LAGUNA PHOENIX.png'),
  OrganizationModel(
      name: "Kwentuhan Series - Paete",
      nature: "Literacy Advocacy Group - Community Based",
      contactDetails: "",
      intro:
          "Ano ang ating ADHIKAIN? Bawat bata ay nakababasa at may pagmamahal sa mga kwento’t mga aklat.",
      socMed:
          "https://web.facebook.com/KwentuhanSeries?mibextid=ZbWKwL&_rdc=1&_rdr",
      logoURL: 'lib/assets/images/Organizations/KWENTUHAN SERIES - PAETE.jpg'),
  OrganizationModel(
      name: "Kwentuhan Series - Kalayaan",
      nature: "Community Based",
      contactDetails: "",
      intro:
          "Kwentuhan Series Kalayaan, a local storytelling program that primarily aims to entertain the partici",
      socMed: "https://www.facebook.com/kwentuhanserieskalayaan/",
      logoURL:
          'lib/assets/images/Organizations/KWENTUHAN SERIES - KALAYAAN.jpg'),
  OrganizationModel(
      name: "Laguna University Central Student Council (LU-CSC)",
      nature: "School Based",
      contactDetails: "",
      intro:
          "Laguna University Central Student Council is the highest student governing student body of L.U.",
      socMed: "https://www.facebook.com/LUCSCOfficial",
      logoURL:
          'lib/assets/images/Organizations/65.  LAGUNA UNIVERSITY STUDENT COUNCIL.jpg'),
  OrganizationModel(
      name: "Pedro Laguna Youth Development Office",
      nature: "",
      contactDetails: "",
      intro:
          "Recognized San Pedrenses in the national and international arena.",
      socMed: "https://www.facebook.com/cysdcityofsanpedrolaguna",
      logoURL:
          'lib/assets/images/Organizations/PEDRO LAGUNA YOUTH DEVELOPMENT OFFICE.png'),
  OrganizationModel(
      name: "Red Cross Youth Laguna",
      nature: "",
      contactDetails: "",
      intro:
          "Bagong lakas, Bagong Pwersa: Sertipikadong Kabataang Krus na Pula ng LAGUNA",
      socMed: "https://www.facebook.com/LagunaRCY",
      logoURL:
          'lib/assets/images/Organizations/67. RED CROSS YOUTH LAGUNA.png'),
  OrganizationModel(
    name: "Salesians Cooperators of Malaya",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "SIKLAB - BINAN CITY",
      nature: "Youth Serving Organization - Community Based",
      contactDetails: "",
      intro:
          "Makakabataang organisasyon na naglalayon na isulong ang kapakanan at karapatan ng mga kabataan sa pa",
      socMed: "https://www.facebook.com/SIKLABBinanCity",
      logoURL: 'lib/assets/images/Organizations/69. SIKLAB - BINAN CITY.png'),
  OrganizationModel(
      name: "SIKLAB - CANLALAY",
      nature: "Youth Serving Organization",
      contactDetails: "",
      intro:
          "Makakabataang organisasyon na naglalayon na isulong ang kapakanan at karapatan ng mga kabataan sa pa",
      socMed: "https://www.facebook.com/SIKLABCanlalay",
      logoURL: 'lib/assets/images/Organizations/70. SIKLAB - CANLALAY.png'),
  OrganizationModel(
      name: "SIKLAB - DELA PAZ",
      nature: "Youth Organization - Youth and Labor",
      contactDetails: "",
      intro: "KABATAAN PARA SA BAYAN",
      socMed: "https://www.facebook.com/SiklabDELAPAZ",
      logoURL: 'lib/assets/images/Organizations/71. YSIKLAB - DELA PAZ.png'),
  OrganizationModel(
      name: "SIKLAB - LANGKIWA",
      nature: "",
      contactDetails: "",
      intro:
          "Makakabataang organisasyon na naglalayon na isulong ang kapakanan at karapatan ng mga kabataan",
      socMed: "https://www.facebook.com/SIKLABLangkiwa",
      logoURL: 'lib/assets/images/Organizations/72. SIKLAB - LANGKIWA.png'),
  OrganizationModel(
      name: "SIKLAB - LOMA",
      nature:
          "Organization as a Process - (Community Based, School Based, Environmental)",
      contactDetails: "",
      intro:
          "Makakabataang organisasyon na naglalayon na isulong ang kapakanan at karapatan ng mga kabataan sa pa",
      socMed: "https://www.facebook.com/SIKLABLoma",
      logoURL: 'lib/assets/images/Organizations/SIKLAB - LOMA.jpg'),
  OrganizationModel(
      name: "SIKLAB - SAN FRANCISCO",
      nature: "Social Group",
      contactDetails: "",
      intro:
          "Makakabataang organisasyon na naglalayon na isulong ang kapakanan at karapatan ng mga kabataan",
      socMed: "https://www.facebook.com/SIKLABSanFrancisco",
      logoURL: 'lib/assets/images/Organizations/SIKLAB - SAN FRANCISCO.jpg'),
  OrganizationModel(
      name: "SIKLAB - SORO SORO",
      nature: "Youth Serving Organization - Community Based",
      contactDetails: "",
      intro:
          "Makakabataang organisasyon na naglalayon na isulong ang kapakanan at karapatan ng mga kabataan sa pa",
      socMed: "https://www.facebook.com/SIKLABSoroSoro",
      logoURL: 'lib/assets/images/Organizations/SIKLAB - SORO SORO.jpg'),
  OrganizationModel(
      name: "SIKLAB - MALABAN",
      nature: "Youth Serving Organization - Community Based",
      contactDetails: "",
      intro: "Lagi't lagi para sa Kabataan ng Malaban.",
      socMed: "https://www.facebook.com/SIKLABMalaban",
      logoURL: 'lib/assets/images/Organizations/SIKLAB - MALABAN.jpg'),
  OrganizationModel(
      name: "SIKLAB - Sto Tomas",
      nature: "Youth Serving Organization",
      contactDetails: "",
      intro:
          "Makakabataang organisasyon na naglalayon na isulong ang kapakanan at karapatan ng mga kabataan sa pam",
      socMed: "https://www.facebook.com/SIKLABStoTomas",
      logoURL: 'lib/assets/images/Organizations/SIKLAB STO TOMAS.png'),
  OrganizationModel(
      name: "Sulong San Pablo",
      nature: "Youth Serving Organization - Community Based",
      contactDetails: "",
      intro: "Bagong henerasyon para sa progresibong San Pablo.",
      socMed: "https://www.facebook.com/SulongSanPablo",
      logoURL: 'lib/assets/images/Organizations/SULONG SAN PABLO.png'),
  OrganizationModel(
      name: "Supreme Student Government Balian INHS",
      nature: "School Based",
      contactDetails: "",
      intro:
          "The official page of Balian Integrated National High School Supreme Secondary Learner Government",
      socMed: "https://www.facebook.com/ssgbalian",
      logoURL:
          'lib/assets/images/Organizations/79. SUPREME STUDENT GOVERNMENT BALIAN INHS.jpg'),
  OrganizationModel(
      name: "Supreme Student Government Siniloan INHS",
      nature: "",
      contactDetails: ".",
      intro:
          "This is the official Siniloan Integrated National High School Supreme Government Organization (SSG)",
      socMed: "https://www.facebook.com/SiniloanINHS.SSG",
      logoURL:
          'lib/assets/images/Organizations/80. SUPREME STUDENT GOVERNMENT SINILOAN INHS.jpg'),
  OrganizationModel(
      name: "Tau Gamma Phil. Brgy. Aplaya",
      nature: "",
      contactDetails: "",
      intro: "",
      socMed: "",
      logoURL: 'lib/assets/images/Organizations/TAU GAMMA PHI.jpg'),
  OrganizationModel(
      name: "Tau Gamma Phil. Conception Chapter",
      nature: "",
      contactDetails: "",
      intro: "",
      socMed: "",
      logoURL: 'lib/assets/images/Organizations/TAU GAMMA PHI.jpg'),
  OrganizationModel(
      name: "Tau Gamma Phil. San Roque Chapter",
      nature: "",
      contactDetails: "",
      intro: "",
      socMed: "",
      logoURL: 'lib/assets/images/Organizations/TAU GAMMA PHI.jpg'),
  OrganizationModel(
    name: "Teatro Handuraw Laguna Capter (Youth Organization)",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "Triskelion Tau Gamma Laguna Chapter",
      nature: "",
      contactDetails: "",
      intro: "",
      socMed: "",
      logoURL: 'lib/assets/images/Organizations/TAU GAMMA PHI.jpg'),
  OrganizationModel(
      name: "Vernum Mental Health",
      nature: "Community Based",
      contactDetails: "",
      intro:
          "Vernum MH is a community-based youth organization whose main objective is to advocate mental health.",
      socMed: "https://www.facebook.com/vernummentalhealth",
      logoURL: 'lib/assets/images/Organizations/86. VERNUM MENTAL HEALTH.jpg'),
  OrganizationModel(
      name: "Yakap Kaunlaran sa kaunlaran ng bata incorporated (YKBI)",
      nature: "",
      contactDetails: "",
      intro:
          "Yakap sa Kaunlaran ng Bata Inc. is a regional primary organization of parents, youth, and young professionals.",
      socMed: "https://www.facebook.com/YKBI2004",
      logoURL:
          'lib/assets/images/Organizations/YAKAP KAUNLARAN SA KAUNLARAN NG BATA INCORPORATED YKBI.jpg'),
  OrganizationModel(
    name: "Youth Environmental in School Organization",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "Youth Life Club",
      nature: "",
      contactDetails: "",
      intro: "Youth Sector of Life in Christ Christian Ministries Inc.",
      socMed: "https://web.facebook.com/youthlifespcf",
      logoURL: 'lib/assets/images/Organizations/YOUTH LIFE CLUB.jpg'),
  OrganizationModel(
    name: "Youth Life Movement",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "Youth-Link for Leadership and Development Association",
      nature: "Youth Serving Organization – Community Based",
      contactDetails: "",
      intro:
          "YLLDA is a youth service organization established and is designed to be federated in CALABARZON.",
      socMed: "https://www.facebook.com/info.yllda",
      logoURL:
          'lib/assets/images/Organizations/YOUTH - LINK FOR LEADERSHIP AND DEVELOPMENT ASSOCIATION.jpg'),
  OrganizationModel(
      name: "Youth Parliamentarians of Laguna (YPL)",
      nature: "Governance",
      contactDetails: "",
      intro:
          "The Youth Parliamentarians of Laguna is a youth-led, non-profit, non-stock, non-sectarian, provincial.",
      socMed: "https://www.facebook.com/OfficialYPL",
      logoURL:
          'lib/assets/images/Organizations/YOUTH PARLIAMENTARIANS OF LAGUNA YPL.jpg'),
  OrganizationModel(
      name: "Aktibong Lumbeno Angat Bolunterismo Movement (ALAB)",
      nature: "",
      contactDetails: "",
      intro:
          "Established in July 2022, ALAB Movement is a youth-led accredited NGO based in Lumban, Laguna.",
      socMed: "https://www.facebook.com/alabmovement",
      logoURL:
          'lib/assets/images/Organizations/1. AKTIBONG LUMBENO ANGAT BOLUNTERISMO MOVEMENT ALAB.jpg'),
  OrganizationModel(
    name: "Alliance of Laguna Farmers and Advocates",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "Alliance of Santa Rosa Youth Organization",
      nature: "Community Based",
      contactDetails: "",
      intro:
          "Dita Youth Organization, Malusak Youth Society, PUP SRC Student Council, Santo Domingo Youth.",
      socMed: "https://www.facebook.com/theofficialASRYO",
      logoURL:
          'lib/assets/images/Organizations/3. ALLIANCE OF SANTA ROSA YOUTH ORGANIZATION.jpg'),
  OrganizationModel(
      name: "Bangon Calauan Youth",
      nature: "",
      contactDetails: "",
      intro: "BANGON CALAUAN YOUTH o BCY",
      socMed: "https://www.facebook.com/bangoncalauanyouth",
      logoURL: 'lib/assets/images/Organizations/4. BANGON CALAUAN YOUTH.jpg'),
  OrganizationModel(
      name: "BINHI-BUKLOD-ISIP na may hangaring iangat and Sta. Maria, Laguna",
      nature: "Community Based",
      contactDetails: "",
      intro:
          "An independent, non-partisan, and non-governmental organization based in Santa Maria, Laguna.",
      socMed: "https://web.facebook.com/BINHI.SML",
      logoURL:
          'lib/assets/images/Organizations/BINHI - SANTA MARIA, LAGUNA.jpg'),
  OrganizationModel(
      name: "DITA Youth Organization",
      nature: "",
      contactDetails: "",
      intro: "",
      socMed: "https://www.facebook.com/ditayouth",
      logoURL:
          'lib/assets/images/Organizations/6. DITA YOUTH ORGANIZATION.jpg'),
  OrganizationModel(
    name: "Fresh Youth Organization",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "GV3 Volleyball",
      nature: "",
      contactDetails: "",
      intro: "Official Page of GV3 Balibol and St John Volleyball Club",
      socMed: "https://www.facebook.com/profile.php?id=100090219199803",
      logoURL: 'lib/assets/images/Organizations/8. GV3 VOLLEYBALL.jpg'),
  OrganizationModel(
      name: "Hype Pagsanjan",
      nature: "",
      contactDetails: "",
      intro:
          "To Discover, Develop and Dispense the gifts, talents, and abilities of the youth.",
      socMed: "https://web.facebook.com/Hypepagsanjan",
      logoURL: 'lib/assets/images/Organizations/9. HYPE PAGSANJAN.jpg'),
  OrganizationModel(
      name: "Junior Philippines Institute of Accountants – LSPU-SCC",
      nature: "",
      contactDetails: "",
      intro: "Junior Philippine Institute of Accountants LSPU-Sta. Cruz Campus",
      socMed: "https://www.facebook.com/JPIALSPUSCC.BSA",
      logoURL:
          'lib/assets/images/Organizations/10. JUNIOR PHILIPPINES INSTITUTE OF ACCOUNTANTS - LSPU SCC.jpg'),
  OrganizationModel(
    name: "Kabataang Pangarap ni Rizal (Karapiz)",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "KAISA",
      nature: "",
      contactDetails: "",
      intro:
          "Vision: We envision a safe and inclusive space for San Pablo City",
      socMed: "https://www.facebook.com/kaisa.coalition",
      logoURL: 'lib/assets/images/Organizations/KAISA.jpg'),
  OrganizationModel(
      name: "Kilos Lagunense",
      nature: "",
      contactDetails: "",
      intro:
          "Kilos Lagunense is a youth-driven organization working to mobilize the youth to actively participate",
      socMed: "https://www.facebook.com/KilosLagunense",
      logoURL: 'lib/assets/images/Organizations/13. KILOS LAGUNENSE.png'),
  OrganizationModel(
      name: "Kwetuhan Series – Kalayaan",
      nature: "Community Based",
      contactDetails: "",
      intro:
          "Ano ang ating ADHIKAIN? Bawat bata ay nakababasa at may pagmamahal sa mga kwento’t mga aklat.",
      socMed: "https://www.facebook.com/kwentuhanserieskalayaan",
      logoURL:
          'lib/assets/images/Organizations/14. KUWENTUHAN SERIES - KALAYAAN.jpg'),
  OrganizationModel(
      name: "Lahi Performing Arts Community",
      nature: "",
      contactDetails: "",
      intro: "Was created to have a positive community!",
      socMed: "https://web.facebook.com/LAHIPAC?_rdc=1&_rdr",
      logoURL:
          'lib/assets/images/Organizations/LAHI PERFORMING ARTS ORGANIZATION.jpg'),
  OrganizationModel(
    name: "Malusak Youth Organization",
    nature: "Community Based",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "Marilag Youth",
      nature: "",
      contactDetails: "",
      intro: "",
      socMed: "https://web.facebook.com/profile.php?id=100066629630474",
      logoURL: 'lib/assets/images/Organizations/17. MARILAG YOUTH.jpg'),
  OrganizationModel(
      name: "Pagsanjan Unified Leaders for Service",
      nature: "",
      contactDetails: "",
      intro:
          "The Pagsanjan Unified Leaders for Service Organization (PULSO) is a non-partisan, socio-civic youth.",
      socMed: "https://www.facebook.com/pulsopagsanjan",
      logoURL:
          'lib/assets/images/Organizations/18. PAGSANJAN UNIFIED LEADERS FOR SERVICE.jpg'),
  OrganizationModel(
    name: "Sta. Joachim and Anne Parish Youth Ministry",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "Pedro Guevara Memorial National High School – SSG",
      nature: "",
      contactDetails: "",
      intro:
          "Supreme Student Government is the highest student governing body in all public secondary schools.",
      socMed:
          "https://web.facebook.com/SupremeStudentGovernmentOfPedroGuevaraMNHS",
      logoURL:
          'lib/assets/images/Organizations/20. PEDRO GUEVARA MEMORIAL NATIONAL HIGH SCHOOL - SSG.jpg'),
  OrganizationModel(
      name: "PUP SRC Student Council Organization",
      nature: "",
      contactDetails: "",
      intro:
          "Uplifting Virtue and Excellence Student Council Organization A.Y. 2022-2023",
      socMed: "https://web.facebook.com/thepupsrcstudentcouncil",
      logoURL:
          'lib/assets/images/Organizations/21. PUP SRC STUDENT COUNCIL ORGANIZATION.jpg'),
  OrganizationModel(
      name: "Samahang Manlalarong Kabataan",
      nature: "",
      contactDetails: "",
      intro:
          "An organization dedicated to bringing out the best in Santa Rosa's youth athletes through sports-related.",
      socMed: "https://web.facebook.com/SaMaKaSantaRosa",
      logoURL:
          'lib/assets/images/Organizations/23. SAMAHANG MANLALARONG KABATAAN.jpg'),
  OrganizationModel(
      name: "Sibol Alaminos",
      nature: "",
      contactDetails: "",
      intro:
          "A non-profit youth organization aimed to empower the youth in the Municipality of Alaminos through leadership.",
      socMed: "https://web.facebook.com/SibolAlaminos",
      logoURL: 'lib/assets/images/Organizations/24. SIBOL ALAMINOS.jpg'),
  OrganizationModel(
    name: "Sitio Magalolon Youth Council",
    nature: "",
    contactDetails: "",
    intro:
        "SMYC is a youth community-based organization that focuses on addressing the common problematic scenarios.",
    socMed: "https://www.facebook.com/profile.php?id=100069693169625",
  ),
  OrganizationModel(
      name: "Sitio Youth Organization",
      nature: "",
      contactDetails: "",
      intro: "",
      socMed: "",
      logoURL:
          'lib/assets/images/Organizations/25. SITIO MAGALOLON YOUTH COUNCIL.jpg'),
  OrganizationModel(
      name: "Speak Youth for Jesus Movement",
      nature: "",
      contactDetails: "",
      intro: "We are God's catalyst in transforming our communities.",
      socMed: "https://web.facebook.com/speaksyjm",
      logoURL:
          'lib/assets/images/Organizations/27. SPEAK YOUTH FOR JESUS MOVEMENT.png'),
  OrganizationModel(
      name: "SSG Gov. Felicisimo San Luis Integrated Senior High School",
      nature: "",
      contactDetails: "",
      intro: "",
      socMed: "https://web.facebook.com/profile.php?id=100090756657722",
      logoURL:
          'lib/assets/images/Organizations/28. SSG GOV. FELICISIMO SAN LUIS INTEGRATED SENIOR HIGH SCHOOL.jpg'),
  OrganizationModel(
    name: "St. Ignatius SSG",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
    name: "Sto. Domingo Youth Coalition",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
    name: "SITAPORT",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "UPLB Argi Business Society (UPABS)",
      nature: "",
      contactDetails: "",
      intro:
          "This is the official page of the UP Agribusiness Society, a premiere and exclusive organization.",
      socMed: "https://web.facebook.com/upagribusinesssociety",
      logoURL:
          'lib/assets/images/Organizations/32. UPLB AGRI BUSINESS SOCIETY UPABS.jpg'),
  OrganizationModel(
      name: "VCFM Kingdom Youth Generation",
      nature: "",
      contactDetails: "",
      intro: "",
      socMed: "https://web.facebook.com/profile.php?id=100077205274029",
      logoURL:
          'lib/assets/images/Organizations/33. VCFM KINGDOM YOUTH GENERATION.jpg'),
  OrganizationModel(
      name: "YIFI Bagumbayan",
      nature: "",
      contactDetails: "",
      intro: "Youth of Iglesia Filipina Independiente",
      socMed: "https://www.facebook.com/YIFIBagumbayan",
      logoURL: 'lib/assets/images/Organizations/34. YIFI BAGUMBAYAN.jpg'),
  OrganizationModel(
      name: "YIFI Gatid",
      nature: "",
      contactDetails: "",
      intro: "",
      socMed: "https://www.facebook.com/YIFIGatidinsider",
      logoURL: 'lib/assets/images/Organizations/YIFI GATID.jpg'),
  OrganizationModel(
      name: "SIKLAB – Santa Cruz",
      nature: "",
      contactDetails: "",
      intro: "https://web.facebook.com/siklabkabataan2022",
      socMed: "",
      logoURL: 'lib/assets/images/Organizations/SIKLAB SANTA CRUZ.jpg'),
  OrganizationModel(
      name:
          "MAPEH Felicisians Club of Governor Felicisimo San Luis Integrated Senior High School",
      nature: "",
      contactDetails: "",
      intro: "",
      socMed: "https://www.facebook.com/profile.php?id=100094171440741",
      logoURL:
          'lib/assets/images/Organizations/37. MAPEH FELICISIANS CLUB OF GOVERNOR FELICISIMO T SAN LUIS INTEGRATED SENIOR HIGH SCHOOL.jpg'),
  OrganizationModel(
    name:
        "Grupong Kayumanggi of Governor Felicisimo T. San Luis Integrated Senior High School",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
    name:
        "Algeometrical Math Club (AMC) of Governor Felicisimo T. San Luis Integrated Senior High School",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
    name:
        "English Club of Governor Felicisimo San Luis T. Integrated Senior High School",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
    name:
        "Youth Environment in School Organization (YES-O) OG Governor Felicisimo T. San Luis Integrated Senior High School",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "Felicians History Club",
      nature: "",
      contactDetails: "",
      intro: "Batang Makabansa, Bansang Makabata",
      socMed: "https://www.facebook.com/GFTSLISHSFHC",
      logoURL:
          'lib/assets/images/Organizations/42. FELICISIANS HISTORY CLUB.jpg'),
  OrganizationModel(
      name: "Sinag kabataan Santa Cruz",
      nature: "",
      contactDetails: "",
      intro:
          "Sentrong Isusulong ang Nagkakaisa at Aktibong Grupo ng Kabataan is a socio-civic organization.",
      socMed: "https://facebook.com/sinagkabataan.stacruz",
      logoURL:
          'lib/assets/images/Organizations/43. SINAG KABATAAN SANTA CRUZ.png'),
  OrganizationModel(
    name: "Changing Lives in Every Shot",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "Liceo De Luisiana Disaster Risk Reduction Management Organization",
      nature: "",
      contactDetails: "",
      intro: "",
      socMed: "",
      logoURL:
          'lib/assets/images/Organizations/LICEO DE LUISIANA OFFICIAL.jpg'),
  OrganizationModel(
    name: "Computer Science Organization",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "Youth for Sustainable Change",
      nature: "",
      contactDetails: "",
      intro: "Together we can build a sustainable community",
      socMed: "https://www.facebook.com/y4scnagcarlan",
      logoURL:
          'lib/assets/images/Organizations/YOUTH FOR SUSTAINABLE CHANGE - NAGCARLAN.jpg'),
  OrganizationModel(
      name: "Laguna University College Red Cross Youth Council",
      nature: "",
      contactDetails: "",
      intro:
          "This is the official page of Laguna University College Red Cross Youth Council.",
      socMed: "https://www.facebook.com/profile.php?id=100084030759600",
      logoURL:
          'lib/assets/images/Organizations/LAGUNA UNIVERSITY COLLEGE RED CROSS YOUTH COUNCIL.jpg'),
  OrganizationModel(
    name: "Angat Kabataang Negosyante ng Kabuya",
    nature: "",
    contactDetails: "",
    intro:
        "Learn Entrepreneurship with Capital Buildup Program Powered by Co-Learning Communities",
    socMed: "https://www.facebook.com/angatkabuyaw",
  ),
  OrganizationModel(
      name: "Laguna University – Junior Philippine Institute of Accountant",
      nature: "",
      contactDetails: "",
      intro:
          "This is the official page of Laguna University - Junior Philippine Institute of Accountants (HILAYUG)",
      socMed: "https://www.facebook.com/lujpiahilayugfed",
      logoURL:
          'lib/assets/images/Organizations/LAGUNA UNIVERSITY - JUNIOR PHILIPPINE INSTITUTE OF ACCOUNTANT.jpg'),
  OrganizationModel(
      name: "KAYA NATIN! Los Banos",
      nature: "",
      contactDetails: "",
      intro:
          "Kaya Natin! Youth Los Baños (KNY-LB) is a voluntary, non-profit, and non-government organization.",
      socMed: "https://www.facebook.com/KNYLosBanos",
      logoURL:
          'lib/assets/images/Organizations/KAYA NATIN YOUTH - LOS BAñOS.jpg'),
  OrganizationModel(
      name: "JAMBOREE Site Youth Organization",
      nature: "",
      contactDetails: "",
      intro: "",
      socMed: "https://www.facebook.com/profile.php?id=100081110987385",
      logoURL:
          'lib/assets/images/Organizations/JAMBOREE SITE YOUTH ORGANIZATION.jpg'),
  OrganizationModel(
      name: "Sta. Cruz/Pagsanjan Community Based Scouting",
      nature: "",
      contactDetails: "",
      intro:
          "We are a group of dedicated volunteers Through our scouting programs, we aim to instill important values.",
      socMed: "https://www.facebook.com/scpcbs2022",
      logoURL:
          'lib/assets/images/Organizations/STA.CRUZ - PAGSANJAN COMMUNITY - BASED SCOUTING.jpg'),
  OrganizationModel(
    name: "Kaakibat sa inklusibong San Pablo",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
    name: "Association of Civil Engineering Society",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "Kabataang Boluntaryo ng San Pablo",
      nature: "",
      contactDetails: "",
      intro: "A youth organization in the City of San Pablo",
      socMed: "https://www.facebook.com/KBLSP2021",
      logoURL:
          'lib/assets/images/Organizations/KABATAANG BOLUNTARYO NG LUNGSOD NG SAN PABLO.jpg'),
  OrganizationModel(
      name: "ROTARACT Club of San Pablo Youth",
      nature: "",
      contactDetails: "",
      intro:
          "Official Facebook page of Rotaract Club of Pamantasan ng Lungsod ng San Pablo.",
      socMed: "https://www.facebook.com/rac.plsp",
      logoURL:
          'lib/assets/images/Organizations/ROTARACT CLUB OF PAMANTASAN NG LUNGSOD NG SAN PABLO.jpg'),
  OrganizationModel(
      name: "Psychology Society – LSPU-SCC",
      nature: "",
      contactDetails: "",
      intro:
          "This is the Official Facebook page of the LSPU-SCC Psychology Society.",
      socMed: "https://www.facebook.com/LSPUSCCPsychologySociety",
      logoURL:
          'lib/assets/images/Organizations/PSYCHOLOGY SOCIETY - LSPU SANTA CRUZ MAIN CAMPUS.jpg'),
  OrganizationModel(
      name:
          "The Division Federation of Supreme Secondary Learner Government San Pablo",
      nature: "",
      contactDetails: "",
      intro: "",
      socMed: "",
      logoURL:
          'lib/assets/images/Organizations/DIVISION FEDERATION SUPREME STUDENT GOVERNMENT - SAN PABLO CITY.jpg'),
  OrganizationModel(
    name: "Peer Advocacy Group",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "Teatro Marilag",
      nature: "",
      contactDetails: "",
      intro:
          "Empowering youth through YDA-accredited transformative theater experiences and creative engagement.",
      socMed: "https://www.facebook.com/teatromarilag",
      logoURL: 'lib/assets/images/Organizations/TEATRO MARILAG.jpg'),
  OrganizationModel(
      name: "Whackers Youth Organization",
      nature: "",
      contactDetails: "",
      intro: "",
      socMed: "https://www.facebook.com/whackers2k8",
      logoURL:
          'lib/assets/images/Organizations/WHACKERS YOUTH ORGANIZATION.jpg'),
  OrganizationModel(
      name: "Boy Scout Philippines San Pablo Council",
      nature: "",
      contactDetails: "",
      intro: "The San Pablo City Council-BSP (City of 7 Lakes)",
      socMed: "https://www.facebook.com/BSPSPCC",
      logoURL:
          'lib/assets/images/Organizations/BOY SCOUTS OF THE PHILIPPINES SAN PABLO CITY COUNCIL.jpg'),
  OrganizationModel(
    name: "Go Viral",
    nature: "Community Based",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
    name: "KA-bataan S-ubok ANG GA-ling Movement (KASANGGA)",
    nature: "Community Based",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
      name: "Macabling Youth Organization (MYO)",
      nature: "Community Based",
      contactDetails: "",
      intro:
          "The Macabling Youth Organization was founded to help the youth become closer to the community.",
      socMed: "https://web.facebook.com/macabyouthorg",
      logoURL:
          'lib/assets/images/Organizations/MACABLING YOUTH ORGANIZATION.jpg'),
  OrganizationModel(
      name: "Rotaract Club of Santa Cruz",
      nature: "",
      contactDetails: "",
      intro:
          "Rotaract aims to supply opportunity for a person to enhance knowledge and skills, strengthen leadership.",
      socMed: "https://web.facebook.com/rotaractsantacruzpioneer",
      logoURL:
          'lib/assets/images/Organizations/22. ROTARACT CLUB OF SANTA CRUZ.jpg'),
];

List<String> getOrganizationNames() {
  return allOrganizations.map((org) => org.name).toList();
}

OrganizationModel getOrganizationByName(String name) {
  return allOrganizations.where((element) => element.name == name).first;
}
