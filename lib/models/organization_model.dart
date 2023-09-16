class OrganizationModel {
  String name;
  String nature;
  String? contactDetails;
  String intro;
  String socMed;

  OrganizationModel(
      {required this.name,
      required this.nature,
      required this.contactDetails,
      required this.intro,
      required this.socMed});
}

List<OrganizationModel> allOrganizations = [
  OrganizationModel(
    name: "4H Club of Laguna",
    nature: "",
    contactDetails: "",
    intro:
        "HEAD to clearer thinking HEART to greater loyalty HANDS to larger service HEALTH to better living",
    socMed: "https://www.facebook.com/profile.php?id=100068184075919",
  ),
  OrganizationModel(
    name: "2030 Youth Foreign in the Philippines Incorporated",
    nature: "Youth and Labor",
    contactDetails: "",
    intro: "",
    socMed:
        "www.2030youthforce.org\n#2030YouthForcePH\nhttps://web.facebook.com/YouthForcePH",
  ),
  OrganizationModel(
    name: "Ambagan PH",
    nature:
        "Ambagan PH is a network of volunteers and initiatives responding to crisis situations through “amb",
    contactDetails: "",
    intro: "",
    socMed: "https://web.facebook.com/ambaganphilippines?_rdc=1&_rdr",
  ),
  OrganizationModel(
    name: "Anahaw Laguna (PYDC)",
    nature: "Social Group",
    contactDetails: "",
    intro:
        "Layunin ng organisasyon na paigtingin ang kaisipang Lagunense ukol sa kahalagahan ng agrikultura sa",
    socMed: "https://www.facebook.com/AnahawLaguna?mibextid=ZbWKwL",
  ),
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
  ),
  OrganizationModel(
    name: "Associated of Youth Development Officers",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
    name: "Creative Anime Inspired Theme Organization Caito",
    nature:
        "Creative Anime Inspired Theme Organization (CAITO) is one of the recognized organizations in City Co",
    contactDetails: "",
    intro: "",
    socMed: "https://www.facebook.com/CAITO2006",
  ),
  OrganizationModel(
    name: "Dangal ni Gat Tayaw",
    nature:
        "Isang pribadong samahan ng mga kabataang Liliweno na nagnanais na pagtibayin ang sektor ng kabataan",
    contactDetails: "",
    intro: "",
    socMed: "https://web.facebook.com/dangalnigattayaw2020",
  ),
  OrganizationModel(
    name: "Gawad Laguna Incorporated",
    nature:
        "Ang Gawad Laguna Inc, dating Gawad Felicisimo T San Luis Inc, ay isang pribadong samahang kumikilala,",
    contactDetails: "",
    intro: "",
    socMed: "https://www.facebook.com/GawadLaguna",
  ),
  OrganizationModel(
    name: "Girls Allied Empowered Advocacies Coalition",
    nature:
        "This is an organization that aims to promote climate and environmental action to young girls t",
    contactDetails: "",
    intro: "",
    socMed: "https://www.facebook.com/geaecoalitionph?mibextid=ZbWKwL",
  ),
  OrganizationModel(
    name: "Good Gov. PH",
    nature:
        "GoodGovPH is a youth-led movement for good governance in the Philippines. It conducts initiatives anc",
    contactDetails: "",
    intro: "",
    socMed: "https://www.facebook.com/GoodGovPH?mibextid=ZbWKwL",
  ),
  OrganizationModel(
    name: "Guhit Pinas - Laguna Chapter (GPL)",
    nature: "Community Based - Music Arts",
    contactDetails: "",
    intro:
        "This is the official page of GUHIT Pinas - Laguna chapter. If you are an artist from Laguna, join ou",
    socMed: "https://www.facebook.com/gplagunaofficial",
  ),
  OrganizationModel(
    name: "International Order of Demolay (Dr. Roman L. Kamatoy Chapter #31)",
    nature: "(Brotherhood - Fraternity) Community Based",
    contactDetails: "",
    intro: "International Order of DeMolay",
    socMed:
        "https://www.facebook.com/DeMolayInternationalOrder?mibextid=ZbWKwL",
  ),
  OrganizationModel(
    name: "KKK - Kabataan sa Kartilya sa Katipunan",
    nature: "Community Based",
    contactDetails: "",
    intro: "Serbisyo at Talino ng Kabataan, Para sa Bayan",
    socMed: "https://www.facebook.com/KabataanSaKartilyaNgKatipunanPH",
  ),
  OrganizationModel(
    name: "Kabataang Likha ni Pedro",
    nature: "",
    contactDetails: "",
    intro:
        "We are Kabataang Likha ni Pedro — A Youth Organization formed by the collaboration of Pedro Guevar",
    socMed: "https://www.facebook.com/KLPLaguna",
  ),
  OrganizationModel(
    name: "Kalikasan Pablo",
    nature:
        "A youth-led organization advocating for environmental consciousness and sustainability in San Pablo",
    contactDetails: "",
    intro: "",
    socMed: "https://www.facebook.com/kalikasanpablo",
  ),
  OrganizationModel(
    name: "Katoto Project Organization",
    nature:
        "Katoto Project is an Accredited Youth Non-Governmental Organization in Paete, Laguna, Philippines",
    contactDetails: "",
    intro: "",
    socMed: "https://web.facebook.com/KatotoProjectOfficialPaete",
  ),
  OrganizationModel(
    name: "Kiwanis Club of Laguna Phoenix",
    nature: "Service Organization -Social Group",
    contactDetails: "",
    intro: "Serving the Children of the World",
    socMed: "https://web.facebook.com/KCLP15",
  ),
  OrganizationModel(
    name: "Kwentuhan Series - Paete",
    nature: "Literacy Advocacy Group - Community Based",
    contactDetails: "",
    intro:
        "Ano ang ating ADHIKAIN? Bawat bata ay nakababasa at may pagmamahal sa mga kwento’t mga aklat.",
    socMed:
        "https://web.facebook.com/KwentuhanSeries?mibextid=ZbWKwL&_rdc=1&_rdr",
  ),
  OrganizationModel(
    name: "Kwentuhan Series - Kalayaan",
    nature: "Community Based",
    contactDetails: "",
    intro:
        "Kwentuhan Series Kalayaan, a local storytelling program that primarily aims to entertain the partici",
    socMed: "https://www.facebook.com/kwentuhanserieskalayaan/",
  ),
  OrganizationModel(
    name: "Laguna University Central Student Council (LU-CSC)",
    nature: "School Based",
    contactDetails: "",
    intro:
        "Laguna University Central Student Council is the highest student governing student body of L.U.",
    socMed: "https://www.facebook.com/LUCSCOfficial",
  ),
  OrganizationModel(
    name: "Pedro Laguna Youth Development Office",
    nature: "",
    contactDetails: "",
    intro: "Recognized San Pedrenses in the national and international arena.",
    socMed: "https://www.facebook.com/cysdcityofsanpedrolaguna",
  ),
  OrganizationModel(
    name: "Red Cross Youth Laguna",
    nature:
        "Bagong lakas, Bagong Pwersa: Sertipikadong Kabataang Krus na Pula ng LAGUNA",
    contactDetails: "",
    intro: "",
    socMed: "https://www.facebook.com/LagunaRCY",
  ),
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
  ),
  OrganizationModel(
    name: "SIKLAB - CANLALAY",
    nature: "Youth Serving Organization",
    contactDetails: "",
    intro:
        "Makakabataang organisasyon na naglalayon na isulong ang kapakanan at karapatan ng mga kabataan sa pa",
    socMed: "https://www.facebook.com/SIKLABCanlalay",
  ),
  OrganizationModel(
    name: "SIKLAB - DELA PAZ",
    nature: "Youth Organization - Youth and Labor",
    contactDetails: "",
    intro: "KABATAAN PARA SA BAYAN",
    socMed: "https://www.facebook.com/SiklabDELAPAZ",
  ),
  OrganizationModel(
    name: "SIKLAB - LINGKAWA",
    nature: "",
    contactDetails: "",
    intro:
        "Makakabataang organisasyon na naglalayon na isulong ang kapakanan at karapatan ng mga kabataan",
    socMed: "https://www.facebook.com/SIKLABLangkiwa",
  ),
  OrganizationModel(
    name: "SIKLAB - LOMA",
    nature:
        "Organization as a Process - (Community Based, School Based, Environmental)",
    contactDetails: "",
    intro:
        "Makakabataang organisasyon na naglalayon na isulong ang kapakanan at karapatan ng mga kabataan sa pa",
    socMed: "https://www.facebook.com/SIKLABLoma",
  ),
  OrganizationModel(
    name: "SIKLAB - SAN FRANCISCO",
    nature: "Social Group",
    contactDetails: "",
    intro:
        "Makakabataang organisasyon na naglalayon na isulong ang kapakanan at karapatan ng mga kabataan",
    socMed: "https://www.facebook.com/SIKLABSanFrancisco",
  ),
  OrganizationModel(
    name: "SIKLAB - SORO SORO",
    nature: "Youth Serving Organization - Community Based",
    contactDetails: "",
    intro:
        "Makakabataang organisasyon na naglalayon na isulong ang kapakanan at karapatan ng mga kabataan sa pa",
    socMed: "https://www.facebook.com/SIKLABSoroSoro",
  ),
  OrganizationModel(
    name: "SIKLAB - MALABAN",
    nature: "Youth Serving Organization - Community Based",
    contactDetails: "\"Lagi't lagi para sa Kabataan ng Malaban.\"",
    intro: "",
    socMed: "https://www.facebook.com/SIKLABMalaban",
  ),
  OrganizationModel(
    name: "SIKLAB - Sto Tomas",
    nature: "Youth Serving Organization",
    contactDetails:
        "Makakabataang organisasyon na naglalayon na isulong ang kapakanan at karapatan ng mga kabataan sa pam",
    intro: "",
    socMed: "https://www.facebook.com/SIKLABStoTomas",
  ),
  OrganizationModel(
    name: "Sulong San Pablo",
    nature: "Youth Serving Organization - Community Based",
    contactDetails: "Bagong henerasyon para sa progresibong San Pablo.",
    intro: "",
    socMed: "https://www.facebook.com/SulongSanPablo",
  ),
  OrganizationModel(
    name: "Supreme Student Government Balian INHS",
    nature: "School Based",
    contactDetails:
        "The official page of Balian Integrated National High School Supreme Secondary Learner Government",
    intro: "",
    socMed: "https://www.facebook.com/ssgbalian",
  ),
  OrganizationModel(
    name: "Supreme Student Government Siniloan INHS",
    nature: "",
    contactDetails:
        "This is the official Siniloan Integrated National High School Supreme Government Organization (SSG).",
    intro: "",
    socMed: "https://www.facebook.com/SiniloanINHS.SSG",
  ),
  OrganizationModel(
    name: "Tau Gamma Phil. Brgy. Aplaya",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
    name: "Tau Gamma Phil. Conception Chapter",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
  OrganizationModel(
    name: "Tau Gamma Phil. San Roque Chapter",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
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
  ),
  OrganizationModel(
    name: "Vernum Mental Health",
    nature: "Community Based",
    contactDetails: "",
    intro:
        "Vernum MH is a community-based youth organization whose main objective is to advocate mental health.",
    socMed: "https://www.facebook.com/vernummentalhealth",
  ),
  OrganizationModel(
    name: "Yakap Kaunlaran sa kaunlaran ng bata incorporated (YKBI)",
    nature: "",
    contactDetails: "",
    intro:
        "Yakap sa Kaunlaran ng Bata Inc. is a regional primary organization of parents, youth, and young professionals.",
    socMed: "https://www.facebook.com/YKBI2004",
  ),
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
  ),
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
  ),
  OrganizationModel(
    name: "Youth Parliamentarians of Laguna (YPL)",
    nature: "Governance",
    contactDetails: "",
    intro:
        "The Youth Parliamentarians of Laguna is a youth-led, non-profit, non-stock, non-sectarian, provincial.",
    socMed: "https://www.facebook.com/OfficialYPL",
  ),
  OrganizationModel(
    name: "Aktibong Lumbeno Angat Bolunterismo Movement (ALAB)",
    nature: "",
    contactDetails: "",
    intro:
        "Established in July 2022, ALAB Movement is a youth-led accredited NGO based in Lumban, Laguna.",
    socMed: "https://www.facebook.com/alabmovement",
  ),
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
  ),
  OrganizationModel(
    name: "Bangon Calauan Youth",
    nature: "",
    contactDetails: "",
    intro: "BANGON CALAUAN YOUTH o BCY",
    socMed: "https://www.facebook.com/bangoncalauanyouth",
  ),
  OrganizationModel(
    name: "BINHI-BUKLOD-ISIP na may hangaring iangat and Sta. Maria, Laguna",
    nature: "Community Based",
    contactDetails: "",
    intro:
        "An independent, non-partisan, and non-governmental organization based in Santa Maria, Laguna.",
    socMed: "https://web.facebook.com/BINHI.SML",
  ),
  OrganizationModel(
    name: "DITA Youth Organization",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "https://www.facebook.com/ditayouth",
  ),
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
  ),
  OrganizationModel(
    name: "Hype Pagsanjan",
    nature: "",
    contactDetails: "",
    intro:
        "To Discover, Develop and Dispense the gifts, talents, and abilities of the youth.",
    socMed: "https://web.facebook.com/Hypepagsanjan",
  ),
  OrganizationModel(
    name: "Junior Philippines Institute of Accountants – LSPU-SCC",
    nature: "",
    contactDetails: "",
    intro: "Junior Philippine Institute of Accountants LSPU-Sta. Cruz Campus",
    socMed: "https://www.facebook.com/JPIALSPUSCC.BSA",
  ),
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
    intro: "Vision: We envision a safe and inclusive space for San Pablo City",
    socMed: "https://www.facebook.com/kaisa.coalition",
  ),
  OrganizationModel(
    name: "Kilos Lagunense",
    nature: "",
    contactDetails: "",
    intro:
        "Kilos Lagunense is a youth-driven organization working to mobilize the youth to actively participate",
    socMed: "https://www.facebook.com/KilosLagunense",
  ),
  OrganizationModel(
    name: "Kwetuhan Series – Kalayaan",
    nature: "Community Based",
    contactDetails: "",
    intro:
        "Ano ang ating ADHIKAIN? Bawat bata ay nakababasa at may pagmamahal sa mga kwento’t mga aklat.",
    socMed: "https://www.facebook.com/kwentuhanserieskalayaan",
  ),
  OrganizationModel(
    name: "Lahi Performing Arts Community",
    nature: "",
    contactDetails: "",
    intro: "Was created to have a positive community!",
    socMed: "https://web.facebook.com/LAHIPAC?_rdc=1&_rdr",
  ),
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
  ),
  OrganizationModel(
    name: "Pagsanjan Unified Leaders for Service",
    nature: "",
    contactDetails: "",
    intro:
        "The Pagsanjan Unified Leaders for Service Organization (PULSO) is a non-partisan, socio-civic youth.",
    socMed: "https://www.facebook.com/pulsopagsanjan",
  ),
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
  ),
  OrganizationModel(
    name: "PUP SRC Student Council Organization",
    nature: "",
    contactDetails: "",
    intro:
        "Uplifting Virtue and Excellence Student Council Organization A.Y. 2022-2023",
    socMed: "https://web.facebook.com/thepupsrcstudentcouncil",
  ),
  OrganizationModel(
    name: "Samahang Manlalarong Kabataan",
    nature: "",
    contactDetails: "",
    intro:
        "An organization dedicated to bringing out the best in Santa Rosa's youth athletes through sports-related.",
    socMed: "https://web.facebook.com/SaMaKaSantaRosa",
  ),
  OrganizationModel(
    name: "Sibol Alaminos",
    nature: "",
    contactDetails: "",
    intro:
        "A non-profit youth organization aimed to empower the youth in the Municipality of Alaminos through leadership.",
    socMed: "https://web.facebook.com/SibolAlaminos",
  ),
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
  ),
  OrganizationModel(
    name: "Speak Youth for Jesus Movement",
    nature: "",
    contactDetails: "",
    intro: "We are God's catalyst in transforming our communities.",
    socMed: "https://web.facebook.com/speaksyjm",
  ),
  OrganizationModel(
    name: "SSG Gov. Felicisimo San Luis Integrated Senior High School",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "https://web.facebook.com/profile.php?id=100090756657722",
  ),
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
  ),
  OrganizationModel(
    name: "VCFM Kingdom Youth Generation",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "https://web.facebook.com/profile.php?id=100077205274029",
  ),
  OrganizationModel(
    name: "YIFI Bagumbayan",
    nature: "",
    contactDetails: "",
    intro: "Youth of Iglesia Filipina Independiente",
    socMed: "https://www.facebook.com/YIFIBagumbayan",
  ),
  OrganizationModel(
    name: "YIFI Gatid",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "https://www.facebook.com/YIFIGatidinsider",
  ),
  OrganizationModel(
    name: "SIKLAB – Santa Cruz",
    nature: "",
    contactDetails: "",
    intro: "https://web.facebook.com/siklabkabataan2022",
    socMed: "",
  ),
  OrganizationModel(
    name:
        "MAPEH Felicisians Club of Governor Felicisimo San Luis Integrated Senior High School",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "https://www.facebook.com/profile.php?id=100094171440741",
  ),
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
  ),
  OrganizationModel(
    name: "Sinag kabataan Santa Cruz",
    nature: "",
    contactDetails: "",
    intro:
        "Sentrong Isusulong ang Nagkakaisa at Aktibong Grupo ng Kabataan is a socio-civic organization.",
    socMed: "https://facebook.com/sinagkabataan.stacruz",
  ),
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
  ),
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
  ),
  OrganizationModel(
    name: "Laguna University College Red Cross Youth Council",
    nature: "",
    contactDetails: "",
    intro:
        "This is the official page of Laguna University College Red Cross Youth Council.",
    socMed: "https://www.facebook.com/profile.php?id=100084030759600",
  ),
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
  ),
  OrganizationModel(
    name: "KAYA NATIN! Los Banos",
    nature: "",
    contactDetails: "",
    intro:
        "Kaya Natin! Youth Los Baños (KNY-LB) is a voluntary, non-profit, and non-government organization.",
    socMed: "https://www.facebook.com/KNYLosBanos",
  ),
  OrganizationModel(
    name: "JAMBOREE Site Youth Organization",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "https://www.facebook.com/profile.php?id=100081110987385",
  ),
  OrganizationModel(
    name: "Sta. Cruz/Pagsanjan Community Based Scouting",
    nature: "",
    contactDetails: "",
    intro:
        "We are a group of dedicated volunteers Through our scouting programs, we aim to instill important values.",
    socMed: "https://www.facebook.com/scpcbs2022",
  ),
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
  ),
  OrganizationModel(
    name: "ROTARACT Club of San Pablo Youth",
    nature: "",
    contactDetails: "",
    intro:
        "Official Facebook page of Rotaract Club of Pamantasan ng Lungsod ng San Pablo.",
    socMed: "https://www.facebook.com/rac.plsp",
  ),
  OrganizationModel(
    name: "Psychology Society – LSPU-SCC",
    nature: "",
    contactDetails: "",
    intro:
        "This is the Official Facebook page of the LSPU-SCC Psychology Society.",
    socMed: "https://www.facebook.com/LSPUSCCPsychologySociety",
  ),
  OrganizationModel(
    name:
        "The Division Federation of Supreme Secondary Learner Government San Pablo",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "",
  ),
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
  ),
  OrganizationModel(
    name: "Whackers Youth Organization",
    nature: "",
    contactDetails: "",
    intro: "",
    socMed: "https://www.facebook.com/whackers2k8",
  ),
  OrganizationModel(
    name: "Boy Scout Philippines San Pablo Council",
    nature: "",
    contactDetails: "",
    intro: "The San Pablo City Council-BSP (City of 7 Lakes)",
    socMed: "https://www.facebook.com/BSPSPCC",
  ),
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
  ),
  OrganizationModel(
    name: "Rotaract Club of Santa Cruz",
    nature: "",
    contactDetails: "",
    intro:
        "Rotaract aims to supply opportunity for a person to enhance knowledge and skills, strengthen leadership.",
    socMed: "https://web.facebook.com/rotaractsantacruzpioneer",
  ),
];

List<String> getOrganizationNames() {
  return allOrganizations.map((org) => org.name).toList();
}

OrganizationModel getOrganizationByName(String name) {
  return allOrganizations.where((element) => element.name == name).first;
}
