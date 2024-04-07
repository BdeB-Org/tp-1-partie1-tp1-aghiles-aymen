-- TP1 fichier réponse -- Modifiez le nom du fichier en suivant les instructions
-- Votre nom:  Benallek Aghiles                 Votre DA: 2253929
--ASSUREZ VOUS DE LA BONNE LISIBILITÉ DE VOS REQUÊTES  /5--

-- 1.   Rédigez la requête qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
DESC OUTILS_OUTIL;
DESCRIBE outils_usager;
DESCRIBE outils_outil;
DESCRIBE outils_emprunt;
-- 2.   Rédigez la requête qui affiche la liste de tous les usagers, sous le format prénom « espace » nom de famille (indice : concaténation). /2
SELECT CONCAT(CONCAT(Prenom, ' '), nom_famille) as "Nom complet"
FROM outils_usager;
-- 3.   Rédigez la requête qui affiche le nom des villes où habitent les usagers, en ordre alphabétique, le nom des villes va apparaître seulement une seule fois. /2
SELECT DISTINCT ville AS "Ville"
FROM outils_usager
ORDER BY ville;
-- 4.   Rédigez la requête qui affiche toutes les informations sur tous les outils en ordre alphabétique sur le nom de l’outil puis sur le code. /2
SELECT code_outil AS "Code des outils", nom AS "Nom", fabricant AS "Fabricant",
caracteristiques AS "Caracteristiques", annee AS "Annee", prix AS "Prix"
FROM outils_outil
ORDER BY nom, code_outil;
-- 5.   Rédigez la requête qui affiche le numéro des emprunts qui n’ont pas été retournés. /2
SELECT num_emprunt As "Numero d'emprunts"
FROM outils_emprunt
WHERE date_retour  IS NULL;
-- 6.   Rédigez la requête qui affiche le numéro des emprunts faits avant 2014./3
SELECT num_emprunt AS "Numero d’emprunt"
FROM OUTILS_EMPRUNT
WHERE date_emprunt < '03-MARS-14';
-- 7.   Rédigez la requête qui affiche le nom et le code des outils dont la couleur début par la lettre « j » (indice : utiliser UPPER() et LIKE) /3
SELECT nom AS "Nom", code_outil AS "Code des outils"
FROM outils_outil
WHERE UPPER(caracteristiques) LIKE '%J%';
-- 8.   Rédigez la requête qui affiche le nom et le code des outils fabriqués par Stanley. /2
SELECT nom AS "Nom" , code_outil AS "Code des outils" 
FROM outils_outil
WHERE Fabricant = 'Stanley';
-- 9.   Rédigez la requête qui affiche le nom et le fabricant des outils fabriqués de 2006 à 2008 (ANNEE). /2
SELECT nom AS "Nom", fabricant AS "Fabricant"
FROM outils_outil
WHERE annee between 2006 AND 2008;
-- 10.  Rédigez la requête qui affiche le code et le nom des outils qui ne sont pas de « 20 volts ». /3
SELECT code_outil AS "Code des outils", nom AS "Nom"
FROM outils_outil
WHERE caracteristiques NOT LIKE '%20 volt%';
-- 11.  Rédigez la requête qui affiche le nombre d’outils qui n’ont pas été fabriqués par Makita. /2
SELECT COUNT(*) AS "Nombre d'outils"
FROM outils_outil
WHERE UPPER(fabricant) NOT LIKE 'MAKITA';
-- 12.  Rédigez la requête qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l’usager, le numéro d’emprunt, la durée de l’emprunt et le prix de l’outil (indice : n’oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5
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
-- 13.  Rédigez la requête qui affiche le nom et le code des outils empruntés qui n’ont pas encore été retournés. /4
SELECT  nom AS "Nom", o.code_outil AS "Code des outils"
FROM outils_outil o
INNER JOIN outils_emprunt e
ON o.code_outil = e.code_outil
WHERE date_retour IS NULL; 
-- 14.  Rédigez la requête qui affiche le nom et le courriel des usagers qui n’ont jamais fait d’emprunts. (indice : IN avec sous-requête) /3
SELECT nom_famille AS "Nom", courriel AS "Courriel"
FROM outils_usager
WHERE outils_usager.num_usager NOT IN(
SELECT outils_emprunt.num_usager
FROM outils_emprunt
INNER JOIN outils_usager
ON outils_emprunt.num_usager = outils_usager.num_usager);
-- 15.  Rédigez la requête qui affiche le code et la valeur des outils qui n’ont pas été empruntés. (indice : utiliser une jointure externe – LEFT OUTER, aucun NULL dans les nombres) /4
SELECT oo.code_outil AS "Code des outils", prix AS "Prix"
FROM outils_outil oo
LEFT JOIN outils_emprunt oe
ON oo.code_outil = oe.code_outil
WHERE NUM_EMPRUNT IS NULL;
-- 16.  Rédigez la requête qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est supérieur à la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4
SELECT nom AS "Nom", prix AS "Prix"
FROM outils_outil
WHERE (UPPER(fabricant) LIKE 'MAKITA' AND prix > (SELECT AVG(prix)
FROM outils_outil) OR ( UPPER(fabricant) LIKE 'MAKITA' AND prix IS NULL));
-- 17.  Rédigez la requête qui affiche le nom, le prénom et l’adresse des usagers et le nom et le code des outils qu’ils ont empruntés après 2014. Triés par nom de famille. /4
SELECT nom_famille AS "Nom", prenom AS "Prenom", adresse AS "Adresse"
FROM outils_usager ou
INNER JOIN outils_emprunt oe
ON ou.num_usager = oe.num_usager
WHERE date_emprunt > '01-JANVIER-14'
ORDER BY nom_famille;
-- 18.  Rédigez la requête qui affiche le nom et le prix des outils qui ont été empruntés plus qu’une fois. /4
SELECT nom AS "Nom", prix AS "Prix"
FROM outils_outil oo
INNER JOIN outils_emprunt oe
ON oo.code_outil = oe.code_outil
GROUP BY nom, prix
HAVING count(oo.code_outil) > 1;
-- 19.  Rédigez la requête qui affiche le nom, l’adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant : /6

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

-- 20.  Rédigez la requête qui affiche la moyenne du prix des outils par marque. /3
SELECT fabricant AS "Fabricant" , ROUND(AVG(COALESCE(prix,0)),2) AS "Moyenne des prix par marque"
FROM outils_outil
GROUP BY fabricant;
-- 21.  Rédigez la requête qui affiche la somme des prix des outils empruntés par ville, en ordre décroissant de valeur. /4
SELECT ville AS "Ville", SUM(prix) AS "Somme des prix des outils" 
FROM outils_outil oo
INNER JOIN outils_emprunt oe
ON oo.code_outil = oe.code_outil
INNER JOIN outils_usager ou
ON oe.num_usager = ou.num_usager
GROUP BY ville
ORDER BY ville DESC;
-- 22.  Rédigez la requête pour insérer un nouvel outil en donnant une valeur pour chacun des attributs. /2
INSERT INTO outils_outil(code_outil,nom,fabricant,caracteristiques,annee,prix) 
VALUES ('HA513','Hache','Tkt','1,5 kg, 58 cm',2009,900);
-- 23.  Rédigez la requête pour insérer un nouvel outil en indiquant seulement son nom, son code et son année. /2
INSERT INTO outils_outil(code_outil,nom,annee) 
VALUES ('CI823','Ciseaux',2008);
-- 24.  Rédigez la requête pour effacer les deux outils que vous venez d’insérer dans la table. /2
DELETE FROM outils_outil
WHERE code_outil IN ('HA513','CI823');
-- 25.  Rédigez la requête pour modifier le nom de famille des usagers afin qu’ils soient tous en majuscules. /2
UPDATE outils_usager
SET nom_famille = UPPER(NOM_FAMILLE);
