-- TP1 fichier r�ponse -- Modifiez le nom du fichier en suivant les instructions
-- Votre nom:  Benallek Aghiles                 Votre DA: 2253929
--ASSUREZ VOUS DE LA BONNE LISIBILIT� DE VOS REQU�TES  /5--

-- 1.   R�digez la requ�te qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
DESC OUTILS_OUTIL;
DESCRIBE outils_usager;
DESCRIBE outils_outil;
DESCRIBE outils_emprunt;
-- 2.   R�digez la requ�te qui affiche la liste de tous les usagers, sous le format pr�nom � espace � nom de famille (indice : concat�nation). /2
SELECT CONCAT(CONCAT(Prenom, ' '), nom_famille) as "Nom complet"
FROM outils_usager;
-- 3.   R�digez la requ�te qui affiche le nom des villes o� habitent les usagers, en ordre alphab�tique, le nom des villes va appara�tre seulement une seule fois. /2
SELECT DISTINCT ville AS "Ville"
FROM outils_usager
ORDER BY ville;
-- 4.   R�digez la requ�te qui affiche toutes les informations sur tous les outils en ordre alphab�tique sur le nom de l�outil puis sur le code. /2
SELECT code_outil AS "Code des outils", nom AS "Nom", fabricant AS "Fabricant",
caracteristiques AS "Caracteristiques", annee AS "Annee", prix AS "Prix"
FROM outils_outil
ORDER BY nom, code_outil;
-- 5.   R�digez la requ�te qui affiche le num�ro des emprunts qui n�ont pas �t� retourn�s. /2
SELECT num_emprunt As "Numero d'emprunts"
FROM outils_emprunt
WHERE date_retour  IS NULL;
-- 6.   R�digez la requ�te qui affiche le num�ro des emprunts faits avant 2014./3
SELECT num_emprunt AS "Numero d�emprunt"
FROM OUTILS_EMPRUNT
WHERE date_emprunt < '03-MARS-14';
-- 7.   R�digez la requ�te qui affiche le nom et le code des outils dont la couleur d�but par la lettre � j � (indice : utiliser UPPER() et LIKE) /3
SELECT nom AS "Nom", code_outil AS "Code des outils"
FROM outils_outil
WHERE UPPER(caracteristiques) LIKE '%J%';
-- 8.   R�digez la requ�te qui affiche le nom et le code des outils fabriqu�s par Stanley. /2
SELECT nom AS "Nom" , code_outil AS "Code des outils" 
FROM outils_outil
WHERE Fabricant = 'Stanley';
-- 9.   R�digez la requ�te qui affiche le nom et le fabricant des outils fabriqu�s de 2006 � 2008 (ANNEE). /2
SELECT nom AS "Nom", fabricant AS "Fabricant"
FROM outils_outil
WHERE annee between 2006 AND 2008;
-- 10.  R�digez la requ�te qui affiche le code et le nom des outils qui ne sont pas de � 20 volts �. /3
SELECT code_outil AS "Code des outils", nom AS "Nom"
FROM outils_outil
WHERE caracteristiques NOT LIKE '%20 volt%';
-- 11.  R�digez la requ�te qui affiche le nombre d�outils qui n�ont pas �t� fabriqu�s par Makita. /2
SELECT COUNT(*) AS "Nombre d'outils"
FROM outils_outil
WHERE UPPER(fabricant) NOT LIKE 'MAKITA';
-- 12.  R�digez la requ�te qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l�usager, le num�ro d�emprunt, la dur�e de l�emprunt et le prix de l�outil (indice : n�oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5
SELECT CONCAT(u.nom_famille, ' ', u.prenom) AS nom_complet,
e.num_emprunt, e.date_retour, o.prix
FROM outils_emprunt e
INNER JOIN outils_usager u 
ON e.num_usager = u.num_usager
INNER JOIN outils_outil o 
ON e.code_outil = o.code_outil
WHERE u.ville IN ('Vancouver', 'Regina')
AND e.date_emprunt IS NOT NULL
AND e.date_retour IS NOT NULL
AND o.prix IS NOT NULL;
-- 13.  R�digez la requ�te qui affiche le nom et le code des outils emprunt�s qui n�ont pas encore �t� retourn�s. /4
SELECT  nom AS "Nom", o.code_outil AS "Code des outils"
FROM outils_outil o
INNER JOIN outils_emprunt e
ON o.code_outil = e.code_outil
WHERE date_retour IS NULL; 
-- 14.  R�digez la requ�te qui affiche le nom et le courriel des usagers qui n�ont jamais fait d�emprunts. (indice : IN avec sous-requ�te) /3
SELECT nom_famille AS "Nom", courriel AS "Courriel"
FROM outils_usager
WHERE outils_usager.num_usager NOT IN(
SELECT outils_emprunt.num_usager
FROM outils_emprunt
INNER JOIN outils_usager
ON outils_emprunt.num_usager = outils_usager.num_usager);
-- 15.  R�digez la requ�te qui affiche le code et la valeur des outils qui n�ont pas �t� emprunt�s. (indice : utiliser une jointure externe � LEFT OUTER, aucun NULL dans les nombres) /4
SELECT oo.code_outil AS "Code des outils", prix AS "Prix"
FROM outils_outil oo
LEFT JOIN outils_emprunt oe
ON oo.code_outil = oe.code_outil
WHERE NUM_EMPRUNT IS NULL;
-- 16.  R�digez la requ�te qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est sup�rieur � la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4
SELECT nom AS "Nom", prix AS "Prix"
FROM outils_outil
WHERE (UPPER(fabricant) LIKE 'MAKITA' AND prix > (SELECT AVG(prix)
FROM outils_outil) OR ( UPPER(fabricant) LIKE 'MAKITA' AND prix IS NULL));
-- 17.  R�digez la requ�te qui affiche le nom, le pr�nom et l�adresse des usagers et le nom et le code des outils qu�ils ont emprunt�s apr�s 2014. Tri�s par nom de famille. /4
SELECT nom_famille AS "Nom", prenom AS "Prenom", adresse AS "Adresse"
FROM outils_usager ou
INNER JOIN outils_emprunt oe
ON ou.num_usager = oe.num_usager
WHERE date_emprunt > '01-JANVIER-14'
ORDER BY nom_famille;
-- 18.  R�digez la requ�te qui affiche le nom et le prix des outils qui ont �t� emprunt�s plus qu�une fois. /4
SELECT nom AS "Nom", prix AS "Prix"
FROM outils_outil oo
INNER JOIN outils_emprunt oe
ON oo.code_outil = oe.code_outil
GROUP BY nom, prix
HAVING count(oo.code_outil) > 1;
-- 19.  R�digez la requ�te qui affiche le nom, l�adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant : /6

--  Une jointure

--  IN

--  EXISTS

SELECT DISTINCT nom_famille AS "Nom", adresse AS "Adresse", ville AS "Ville"
FROM outils_usager ou
LEFT JOIN outils_emprunt oe
ON ou.num_usager = oe.num_usager
WHERE ou.num_usager IN(
SELECT oe.num_usager
FROM outils_emprunt
WHERE EXISTS(
SELECT oe.num_usager
FROM outils_emprunt));

-- 20.  R�digez la requ�te qui affiche la moyenne du prix des outils par marque. /3
SELECT fabricant AS "Fabricant" , ROUND(AVG(COALESCE(prix,0)),2) AS "Moyenne des prix par marque"
FROM outils_outil
GROUP BY fabricant;
-- 21.  R�digez la requ�te qui affiche la somme des prix des outils emprunt�s par ville, en ordre d�croissant de valeur. /4
SELECT ville AS "Ville", SUM(prix) AS "Somme des prix des outils" 
FROM outils_outil oo
INNER JOIN outils_emprunt oe
ON oo.code_outil = oe.code_outil
INNER JOIN outils_usager ou
ON oe.num_usager = ou.num_usager
GROUP BY ville
ORDER BY ville DESC;
-- 22.  R�digez la requ�te pour ins�rer un nouvel outil en donnant une valeur pour chacun des attributs. /2
INSERT INTO outils_outil(code_outil,nom,fabricant,caracteristiques,annee,prix) 
VALUES ('HA513','Hache','Tkt','1,5 kg, 58 cm',2009,900);
-- 23.  R�digez la requ�te pour ins�rer un nouvel outil en indiquant seulement son nom, son code et son ann�e. /2
INSERT INTO outils_outil(code_outil,nom,annee) 
VALUES ('CI823','Ciseaux',2008);
-- 24.  R�digez la requ�te pour effacer les deux outils que vous venez d�ins�rer dans la table. /2
DELETE FROM outils_outil
WHERE code_outil IN ('HA513','CI823');
-- 25.  R�digez la requ�te pour modifier le nom de famille des usagers afin qu�ils soient tous en majuscules. /2
UPDATE outils_usager
SET nom_famille = UPPER(NOM_FAMILLE);
