# 8. gyakorlat

## Előkészületek

### Neo4j
+ Regisztráljunk a Neo4j Sandbox oldalán (https://neo4j.com/sandbox/)
+ Telepítsük Telepítsük fel a Neo4J Desktop programot (szükség lehet rendszergazdai jogosultságra)


A megoldásokat - ahol kódot kell írni - másoljuk be a ```js és a ``` közötti részbe


## Feladatok


1\.	A böngészőben indítsa el a Neo4J Sandbox-ot!

a. A megjelenő abakban lejjebb, a Select a Project részben kattintson a Movies lehetőségre, majd lent a Create gombra!  
b. Az Open gombon lévő nyíl segítségével válassza az Open with Browser lehetőséget  kész


2\.	A Neo4J Sandbox Movie adatbázisából kérdezze le azon személyek nevét és születési évét, akik 1964-ben vagy 1965-ben születtek!

a. A lekérdezés kódját adja meg válaszként! 

```js
//2
MATCH (p:Person)
WHERE p.born = 1964 OR p.born= 1965
RETURN p.name, p.born

ZH-n lesz:
match
mongo db
```


3\. A Neo4J Sandbox Movie adatbázisából kérdezze le azon filmek címét és megjelenési évét, amelyek címe A-betűvel kezdődik! (WHERE, STARTS WITH).

a. A listát rendezzük a megjelenési év szerint csökkenő sorrendbe (ORDER BY)!  
b. Az utasítás kódját adjuk meg válaszként!  

```js
//3
MATCH (m:Movie)
WHERE m.title STARTS WITH 'A'
RETURN m.title, m.released
ORDER BY m.released DESC
```

4\.  A Neo4J Sandbox Movie adatbázisából kérdezze le, hogy milyen filmeket készített (:PROCUCED) Joel Silver!

a. Csak a filmek címe jelenjen meg  
b. A lekérdezés kódját adja meg válaszként  

   
```js
//4
MATCH (p:Person)-[:PRODUCED]->(m:Movie)
WHERE p.name = 'Joel Silver'
RETURN m.title
```

5\. A Neo4J Sandbox Movie adatbázisából kérdezze le, hogy melyik rendező hány filmet rendezett! (:DIRECTED).

a. Csak azokat a rendezőket jelenítsük meg, akik 1-nél több filmet rendeztek! (WHERE)  
b. A lekérdezés kódját adja meg válaszként!  

```js
//5
MATCH (p:Person)-[:DIRECTED]->(m:Movie)
WITH p.name AS `nev`, Count(m.title) AS `db`
WHERE db > 1
RETURN nev, db
```


6\. A Neo4J Sandbox Movie adatbázisából jelenítsük meg azokat a személyeket, akik egyszerre voltak szereplők és rendezők is valamely filmben!

a. A lekérdezés kódját adjuk meg válaszként!   

```js
//6
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
MATCH (p)-[:DIRECTED]->(m)

//vagy   MATCH (p:Person)-[:ACTED_IN]->(m:Movie)<-[:DIRECTED]-(p)
//egy sorban is lehet a match

RETURN p.name


//6/2
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
WHERE EXISTS ((p)-[:DIRECTED]->(m))
RETURN p.name
```

7\. A Neo4J Sandbox Movie adatbázisából kérdezze le, hogy mely filmek hány szereplője van!

a. A lista legyen sorba rendezve a szereplők száma szerint csökkenően, azon belül a film címe szerint növekvően  
b. A listából csak az első 10 jelenjen meg!  
c. A lekérdezés kódját adja meg válaszként  

```js
//7
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
WITH m.title AS cim, Count(p.name) AS per
RETURN cim, per
ORDER BY per DESC, cim ASC
LIMIT 10

//adatmanipuláció NEM lesz a ZH-ban
```

8\. A Neo4J Sandbox Movie adatbázisánál készítsen új indexet i_person_born néven!

a. Az indexelés a Person csúcsokra történjen név és születési idő szerint!  
b. Az indexet létrehozó utasítást adja meg válaszként!   

```js
//8

// DROP INDEX i_person_born

CREATE INDEX i_person_born
FOR (p:Person)
ON (p.name, p.born)

//SHOW INDEXES
```

9\.  A Neo4J Sandbox Movie adatbázisánál jelenítse meg a személyek nevét és születési évét!

a. A listát szűrje az 1980 és 2000 között született személyekre!  
b. Az utasítás végrehajtásával együtt jelenjen meg a végrehajtási terv is!  
c. Az utasítást adja meg válaszként!  

```js
//9
PROFILE
MATCH (p:Person)
WHERE p.born >= 1980 and p.born <= 2000
RETURN p.name, p.born
```

10\.  Indítsa el a Neo4J Desktop programot, majd a New gombnál válassza az Import Sample Project lehetőséget!

a. Az importálásnál válassza a Northwind adatbázis korábbi verzióját, majd adjon meg egy jelszót  
b. A telepítés után kattintson a Northwind adatbázisra, majd nyomja le a Start gombot!  

11\. A Neo4J Desktop-ból indítsa el a Neo4J Browsert!

a. Szükség esetén futtassa le a northwind.cypher script tartalmát!  
b. Jelenítse meg a Category csomópontokat vizuálisan  

12\. A Neo4J Desktop-ban hozzon létre új projektet, majd egy új adatbázist tanulo néven!

a. Nyissa meg a Neo4J Browsert, majd tegye aktívvá az új adatbázist!  
b. Hozzon létre :Tanulo és :Tanar csomópontokat az alábbiak alapján:  
Tanulo(Nev, Eletkor, Atlag) Kiss Béla, 22, 3.5 Nagy Ilona, 23, 4.4  
Tanar(Nev, Szak) Tóth Ottó, matematika Nagy Ivett, informatika  
c. A csomópontok létrehozása után kérdezze le a tanulo adatbázis összes csomópontját!  
d. A lekérdező utasítást  adja meg válaszként.   

Megjegyzés: a feladat a Neo4J Sandbox-ban is megoldható

```js

```


13\. Az előző feladatban létrehozott tanulo adatbázisban hozzon létre két új kapcsolatot :Tanit néven az alábbiak szerint:

a. Tóth Ottó tanítja Kiss Bélát  
b. Nagy Ivett tanítja Nagy Ilonát  
c. A szükséges utasításokat adja meg válaszként!   

Megjegyzés: a feladat a Neo4J Sandbox-ban is megoldható  

```js

```

14\. A 12. feladatban létrehozott tanulo adatbázisban végezze el a következő módosításokat:

a. Nagy Ilona átlaga legyen 5.0  
b. Tóth Ottó szakja legyen Fizika  
c. A szükséges utasításokat adja meg válaszként!   

Megjegyzés: a feladat a Neo4J Sandbox-ban is megoldható

```js

```

15\. A Neo4J Desktop-ban tegye aktívvá a tanulo projektet, majd nyisson új terminált az adatbázis melletti Open gombnál mellett lévő három pont (...) kiválasztásával! Utána lépjen be a bin mappába, majd adja ki a cypher-shell parancsot!

a. Szükség esetén adja meg a felhasználónevet és a jelszót  
b. Csatlakozzon a tanulo adatbázishoz (:use tanulo;)  
c. Kérdezze le az első két csúcsot!  
d. Az utasítást adja meg válaszként  


```js

```

