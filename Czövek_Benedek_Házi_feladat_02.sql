/* Czövek Benedek Adatbázisok házi feladat 2. */



/* Itt létrehozom az Ugyfel tábla másolatát, a 4 különböző maszkolási funkcióval*/
CREATE TABLE ugyfelMaszk 
(
    [LOGIN] NVARCHAR(100) MASKED WITH (FUNCTION = 'default()'),
    EMAIL NVARCHAR(100) MASKED WITH (FUNCTION = 'email()'),
    NEV NVARCHAR(100) MASKED WITH (FUNCTION = 'partial(1,"xxx",1)'),
    SZULEV INT MASKED WITH (FUNCTION = 'random(1900, 2025)'),
    NEM CHAR(1) MASKED WITH (FUNCTION = 'default()'),
    CIM NVARCHAR(100) MASKED WITH (FUNCTION = 'default()')
)


/* Az igazi Ugyfel táblából bemásolom az adatokat az ugyfelMaszk táblába */
INSERT INTO ugyfelMaszk ([LOGIN], EMAIL, NEV, SZULEV, NEM, CIM)
SELECT [LOGIN], EMAIL, NEV, SZULEV, NEM, CIM
FROM ugyfel



/* Létrehozok egy felhasználót, aki le tudja kérdezni a maszkolt táblát */
CREATE USER MaszkUser WITHOUT Login;
GRANT SELECT ON ugyfelMaszk TO MaszkUser


/* Ezt a lekérdezést lefuttatva a maszkolt adatokat látom csak */
EXECUTE AS User= 'MaszkUser';
SELECT * FROM ugyfelMaszk
REVERT


/* Megadhatom hogy a felhasználó maszk nélkül is láthassa a táblát */
GRANT UNMASK TO MaszkUser