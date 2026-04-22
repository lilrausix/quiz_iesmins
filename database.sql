CREATE DATABASE testu_sistema;
USE testu_sistema;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user'
);

CREATE TABLE topics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    topic_id INT,
    question_text TEXT,
    correct_answer VARCHAR(255),
    wrong_1 VARCHAR(255),
    wrong_2 VARCHAR(255),
    wrong_3 VARCHAR(255),
    FOREIGN KEY (topic_id) REFERENCES topics(id)
);

INSERT INTO topics (id, title) VALUES 
(1, 'Vēsture'), 
(2, 'Ģeogrāfija'), 
(3, 'Sports'), 
(4, 'Tehnoloģijas'), 
(5, 'Māksla');

-- 1. VĒSTURE (topic_id: 1)
INSERT INTO questions (topic_id, question_text, correct_answer, wrong_1, wrong_2, wrong_3) VALUES
(1, 'Kurā gadā sākās Pirmais pasaules karš?', '1914', '1939', '1918', '1905'),
(1, 'Kurš bija pirmais ASV prezidents?', 'Džordžs Vašingtons', 'Tomass Džefersons', 'Abrahams Linkolns', 'Džons Adams'),
(1, 'Kādā valodā runāja Senajā Romā?', 'Latīņu', 'Grieķu', 'Itāļu', 'Franču'),
(1, 'Kurā gadā Latvija pasludināja neatkarību?', '1918', '1920', '1940', '1991'),
(1, 'Kurš atklāja Ameriku 1492. gadā?', 'Kristofors Kolumbs', 'Vasko da Gama', 'Magelāns', 'Marko Polo'),
(1, 'Kā sauca pirmo Latvijas prezidentu?', 'Jānis Čakste', 'Gustavs Zemgals', 'Kārlis Ulmanis', 'Alberts Kviesis'),
(1, 'Kas uzcēla Lielo Ķīnas mūri?', 'Ķīniešu dinastijas', 'Mongoļi', 'Japāņi', 'Huni'),
(1, 'Kurā pilsētā atradās Gaisa dārzi?', 'Babilonā', 'Atēnās', 'Romā', 'Aleksandrijā'),
(1, 'Kas bija Ēģiptes valdnieki?', 'Faraoni', 'Cari', 'Karaļi', 'Imperatori'),
(1, 'Kurā gadā krita Berlīnes mūris?', '1989', '1991', '1985', '1979'),
(1, 'Kurš izgudroja iespiedmašīnu?', 'Johans Gūtenbergs', 'Leonardo da Vinči', 'Īzaks Ņūtons', 'Galilejs'),
(1, 'Kā sauca seno ēģiptiešu rakstību?', 'Hieroglifi', 'Ķīļraksts', 'Kirilica', 'Latīņu alfabēts'),
(1, 'Kurā valstī notika Franču revolūcija?', 'Francijā', 'Anglijā', 'Vācijā', 'Krievijā'),
(1, 'Kā sauca kuģi, kas nogrima 1912. gadā?', 'Titāniks', 'Britaniks', 'Olimpiks', 'Luzitānija'),
(1, 'Kas bija Rīgas dibinātājs?', 'Bīskaps Alberts', 'Viesturs', 'Kaupo', 'Indriķis');

-- 2. ĢEOGRĀFIJA (topic_id: 2)
INSERT INTO questions (topic_id, question_text, correct_answer, wrong_1, wrong_2, wrong_3) VALUES
(2, 'Kura ir pasaulē lielākā valsts pēc platības?', 'Krievija', 'Kanāda', 'Ķīna', 'ASV'),
(2, 'Kura ir garākā upe pasaulē?', 'Nīla', 'Amazone', 'Misisipi', 'Daugava'),
(2, 'Kura ir Igaunijas galvaspilsēta?', 'Tallina', 'Viļņa', 'Rīga', 'Helsinki'),
(2, 'Kurā kontinentā atrodas Sahāras tuksnesis?', 'Āfrikā', 'Āzijā', 'Austrālijā', 'Dienvidamerikā'),
(2, 'Kāds ir Latvijas augstākais kalns?', 'Gaiziņkalns', 'Munameģis', 'Everests', 'Elbruss'),
(2, 'Kura okeāna ūdeņi apskalo Latviju?', 'Atlantijas okeāna', 'Klusā okeāna', 'Indijas okeāna', 'Ziemeļu Ledus okeāna'),
(2, 'Kura pilsēta ir Itālijas galvaspilsēta?', 'Roma', 'Milāna', 'Venēcija', 'Neapole'),
(2, 'Kurš ir pasaules augstākais kalns?', 'Everests', 'K2', 'Monblāns', 'Kilimanžaro'),
(2, 'Kura valsts atrodas uz salas?', 'Japāna', 'Vācija', 'Brazīlija', 'Ēģipte'),
(2, 'Kurā valstī atrodas Eifeļa tornis?', 'Francijā', 'Spānijā', 'Itālijā', 'Beļģijā'),
(2, 'Kura ir lielākā pilsēta Latvijā?', 'Rīga', 'Daugavpils', 'Liepāja', 'Jelgava'),
(2, 'Kā sauc lielāko okeānu?', 'Klusais okeāns', 'Atlantijas okeāns', 'Indijas okeāns', 'Dienvidu okeāns'),
(2, 'Kura valsts ir pazīstama kā "uzlecošās saules zeme"?', 'Japāna', 'Ķīna', 'Koreja', 'Taizeme'),
(2, 'Kurā kontinentā atrodas Brazīlija?', 'Dienvidamerikā', 'Ziemeļamerikā', 'Āfrikā', 'Eiropā'),
(2, 'Kura upe tek cauri Rīgai?', 'Daugava', 'Lielupe', 'Gauja', 'Venta');

-- 3. SPORTS (topic_id: 3)
INSERT INTO questions (topic_id, question_text, correct_answer, wrong_1, wrong_2, wrong_3) VALUES
(3, 'Cik spēlētāju ir futbola komandā uz laukuma?', '11', '10', '12', '9'),
(3, 'Kurš sporta veids ir populārākais Latvijā ziemā?', 'Hokejs', 'Basketbols', 'Futbols', 'Teniss'),
(3, 'Cik minūtes ilgst viens futbola puslaiks?', '45', '30', '60', '20'),
(3, 'Kurā pilsētā notika 2024. gada Olimpiskās spēles?', 'Parīzē', 'Londonā', 'Tokijā', 'Berlīnē'),
(3, 'Kādā krāsā ir tenisa bumbiņa parasti?', 'Dzeltena', 'Sarkana', 'Zila', 'Balta'),
(3, 'Kas ir Kristaps Porziņģis?', 'Basketbolists', 'Hokejists', 'Futbolists', 'Tenisists'),
(3, 'Cik gredzenu ir Olimpisko spēļu simbolā?', '5', '3', '6', '4'),
(3, 'Kā sauc hokeja inventāru, ko met vārtos?', 'Ripa', 'Bumba', 'Grozs', 'Bulta'),
(3, 'Kurš ir visu laiku ātrākais cilvēks (skrējējs)?', 'Useins Bolts', 'Karls Luiss', 'Maikls Felpss', 'Taisons Gejs'),
(3, 'Kādā sporta veidā startē Mairis Briedis?', 'Boksā', 'Cīņā', 'Svarcelšanā', 'Karatē'),
(3, 'Cik spēlētāju ir basketbola komandā uz laukuma?', '5', '6', '11', '4'),
(3, 'Kā sauc vietu, kur notiek boksa mači?', 'Rings', 'Laukums', 'Tase', 'Korts'),
(3, 'Kurā valstī radās Olimpiskās spēles?', 'Grieķijā', 'Itālijā', 'Ķīnā', 'Ēģiptē'),
(3, 'Kādā sportā izmanto raketi?', 'Tenisā', 'Futbolā', 'Hokejā', 'Basketbolā'),
(3, 'Cik bieži notiek Vasaras Olimpiskās spēles?', 'Reizi 4 gados', 'Reizi 2 gados', 'Katru gadu', 'Reizi 5 gados');

-- 4. TEHNOLOĢIJAS (topic_id: 4)
INSERT INTO questions (topic_id, question_text, correct_answer, wrong_1, wrong_2, wrong_3) VALUES
(4, 'Kas ir "Apple" dibinātājs?', 'Stīvs Džobss', 'Bils Geitss', 'Marks Cukerbergs', 'Īlons Masks'),
(4, 'Kāda ir populārākā meklētājprogramma?', 'Google', 'Bing', 'Yahoo', 'DuckDuckGo'),
(4, 'Ko nozīmē saīsinājums WWW?', 'World Wide Web', 'World West Web', 'Wide World Web', 'Web World Wide'),
(4, 'Kura operētājsistēma ir visizplatītākā datoros?', 'Windows', 'macOS', 'Linux', 'Android'),
(4, 'Kas radīja sociālo tīklu Facebook?', 'Marks Cukerbergs', 'Džefs Bezoss', 'Pāvels Durovs', 'Džeks Dorsijs'),
(4, 'Kādu failu paplašinājumu parasti izmanto attēliem?', '.jpg', '.txt', '.mp3', '.exe'),
(4, 'Kas ir procesora galvenais uzdevums?', 'Datu apstrāde', 'Datu glabāšana', 'Enerģijas ražošana', 'Dzesēšana'),
(4, 'Kura kompānija ražo iPhone?', 'Apple', 'Samsung', 'Huawei', 'Nokia'),
(4, 'Kas ir Wi-Fi?', 'Bezvadu internets', 'Datora vads', 'Programmatūra', 'Ekrāna veids'),
(4, 'Kā sauc mazo ekrāna simbolu, uz kura klikšķina?', 'Ikona', 'Poga', 'Logs', 'Bilde'),
(4, 'Kādu valodu izmanto mājaslapu struktūrai?', 'HTML', 'Python', 'Java', 'C++'),
(4, 'Kas ir "mākonis" (cloud) IT jomā?', 'Datu glabāšana internetā', 'Laika ziņu lietotne', 'Datora procesors', 'Vīruss'),
(4, 'Kā sauc portatīvo datoru?', 'Laptopu', 'Serveri', 'Planšeti', 'Monitoru'),
(4, 'Ko nozīmē USB?', 'Universal Serial Bus', 'User Smart Board', 'Ultra Speed Box', 'United Signal Base'),
(4, 'Kas ir robots?', 'Automatizēta mašīna', 'Datorspēle', 'Cilvēks kostīmā', 'Tikai putekļusūcējs');

-- 5. MĀKSLA (topic_id: 5)
INSERT INTO questions (topic_id, question_text, correct_answer, wrong_1, wrong_2, wrong_3) VALUES
(5, 'Kas uzgleznoja "Monu Lizu"?', 'Leonardo da Vinči', 'Pablo Pikaso', 'Vincents van Gogs', 'Mikelandželo'),
(5, 'Kuras valsts mākslinieks bija Vincents van Gogs?', 'Nīderlandes', 'Francijas', 'Vācijas', 'Itālijas'),
(5, 'Kas ir tēlniecība?', 'Trīsdimensiju māksla', 'Gleznošana uz audekla', 'Mūzikas rakstīšana', 'Dzejas lasīšana'),
(5, 'Kādu mūzikas instrumentu spēlēja Mocarts?', 'Klavieres', 'Ģitāru', 'Bungas', 'Saksofonu'),
(5, 'Kas ir "Grafiti"?', 'Māksla uz sienām', 'Grāmatu ilustrācijas', 'Dejas veids', 'Filmu žanrs'),
(5, 'Kura ir slavenākā operas ēka Latvijā?', 'Latvijas Nacionālā opera', 'Dailes teātris', 'Lielā Ģilde', 'Arēna Rīga'),
(5, 'Kas ir arhitektūra?', 'Ēku projektēšana', 'Apģērbu dizains', 'Ēdienu gatavošana', 'Dziedāšana'),
(5, 'Kāda krāsa rodas, sajaucot zilu ar dzeltenu?', 'Zaļa', 'Oranža', 'Violeta', 'Brūna'),
(5, 'Kas bija Ludvigs van Bēthovens?', 'Komponists', 'Gleznotājs', 'Dzejnieks', 'Aktieris'),
(5, 'Kā sauc rīku, ar ko gleznotājs uzklāj krāsu?', 'Ota', 'Zīmulis', 'Lineāls', 'Šķēres'),
(5, 'Kas ir balets?', 'Dejas māksla', 'Cīņas sports', 'Glezniecības stils', 'Instrumentālais žanrs'),
(5, 'Kura pilsēta ir slavena ar Luvras muzeju?', 'Parīze', 'Londona', 'Ņujorka', 'Berlīne'),
(5, 'Kas ir portrets?', 'Cilvēka attēlojums', 'Dabas skats', 'Klusā daba', 'Abstrakcija'),
(5, 'Kādu krāsu iegūst, sajaucot sarkanu ar baltu?', 'Rozā', 'Pelēku', 'Brūnu', 'Zilu'),
(5, 'Kas ir dzeja?', 'Literatūras veids rīmēs', 'Kino žanrs', 'Mūzikas ritms', 'Zīmēšanas tehnika');