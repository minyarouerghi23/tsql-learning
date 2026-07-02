## Concepts clés
-SQL est utilisé pour communiquer avec une base de données relationnelle.
-SGBDR : Microsoft SQL Server, MySQL, PostgreSQL, MariaDB et Oracle.
-Norme ANSI SQL : Chaque fournisseur ajoute ses propres variantes et extensions.

-Les systèmes de base de données Microsoft tels que *SQL Server, Azure SQL Database, Microsoft Fabric* ... utilisent un dialecte de SQL appelé Transact-SQL (T-SQL)

->Ajoute des fonctionnalités comme les procédures stockées, fonctions et gestion des comptes utilisateurs.

**Bases relationnelles** =Données organisées en **tables (relations)** : chaque table = type d’entité (client, produit, commande).

 **Traitement basé sur les ensembles**

- Les tables et résultats de requêtes sont des **ensembles**.
    
- Penser en termes d’opérations sur l’ensemble entier, pas ligne par ligne.
    
- **Pas d’ordre implicite** : pour trier, utiliser `ORDER BY`.

-**Schémas** = espaces de noms logiques** dans une base de données 
    ~Permettent de **regrouper et organiser les tables** pour éviter les conflits de noms.
+ **Avantages**:

- Organisation claire des objets.
    
- Gestion facilitée des droits et de la sécurité par schéma.
    
- Réduction des conflits de noms entre tables.

**DML (Data Manipulation Language)**
    
    - Interrogation et modification des données.
        
    - Instructions : `SELECT`, `INSERT`, `UPDATE`, `DELETE`.
        
    - Utilisé pour les opérations **CRUD** (Create, Read, Update, Delete).
        
- **DDL (Data Definition Language)**
    
    - Gestion de la définition et du cycle de vie des objets de base de données.
        
    - Instructions : `CREATE`, `ALTER`, `DROP`.
        
    - Concerne les tables, vues, procédures, etc.
        
- **DCL (Data Control Language)**
    
    - Gestion des autorisations et de la sécurité.
        
    - Instructions : `GRANT`, `REVOKE`, `DENY`.
        
- **TCL (Transaction Control Language)** _(parfois mentionné)_
    
    - Contrôle des transactions.
        
    - Exemple : `COMMIT`, `ROLLBACK`, `SAVEPOINT`.
        
- **DQL (Data Query Language)** _(parfois utilisé dans certaines classifications)_
    
    - Spécifiquement pour les requêtes de données.
        
    - Instruction principale : `SELECT`.

**TYPES**:

**Numériques exacts** : `tinyint`, `smallint`, `int`, `bigint`, `decimal/numeric`, `money`, `smallmoney`, `bit`.
    
 **Numériques approchés** : `float`, `real`.
    
-**Caractères** : `char`, `varchar`, `text`, `nchar`, `nvarchar`, `ntext`.
    
**Date/Heure** : `date`, `time`, `datetime`, `datetime2`, `smalldatetime`, `datetimeoffset`, `timestamp`.
    
 **Binaires** : `binary`, `varbinary`, `image`.
    
 **Autres** : `cursor`, `hierarchyid`, `sql_variant`, `table`, `uniqueidentifier`, `xml`, `geography`, `geometry`.


**Fonctions de conversion**(explicites)

- **CAST / TRY_CAST**
    
    - `CAST` : conversion stricte, erreur si incompatible.
        
    - `TRY_CAST` : retourne `NULL` si la conversion échoue.
        
- **CONVERT / TRY_CONVERT**
    
    - Similaire à `CAST`, mais avec option de **style de formatage** (dates, nombres).
        
    - Exemple : `CONVERT(varchar(10), SellStartDate, 101)` → format `MM/DD/YYYY`.
        
- **PARSE / TRY_PARSE**
    
    - Conversion de chaînes formatées en valeurs numériques ou dates.
        
    - Exemple : `PARSE('01/01/2021' AS date)`.
        
    - `TRY_PARSE` retourne `NULL` si incompatible.
        
- **STR**
    
    - Convertit une valeur numérique en `varchar`.
        
    - Exemple : `STR(ListPrice)` → texte `"1432.00"`.
    

**FONCTIONS RELATIVES A NULL:

- **ISNULL(expression, valeur)**
    
    - Retourne la valeur de remplacement si l’expression est `NULL`.
        
    - Exemple : `ISNULL(MiddleName, 'None')`.
        
    - ⚠️ La valeur de remplacement doit être du même type que l’expression.
        
- **COALESCE(expr1, expr2, …, exprN)**
    
    - Retourne la **première valeur non NULL** parmi les arguments.
        
    - Plus flexible qu’ISNULL (peut gérer plusieurs colonnes).
        
    - Exemple : calculer le salaire d’un employé selon la colonne non NULL (`HourlyRate`, `WeeklySalary`, `Commission`).
        
- **NULLIF(expr1, expr2)**
    
    - Retourne `NULL` si les deux expressions sont égales.
        
    - Sinon retourne `expr1`.
        
    - Exemple : `NULLIF(UnitPriceDiscount, 0)` → transforme une remise de 0 en `NULL`.
**DONC:**
- `ISNULL` → "si c'est NULL, mets ça"
- `NULLIF` → "si c'est ça, mets NULL"
- `COALESCE` → "donne-moi le premier non-vide"
![[Pasted image 20260625231219.png|645]]
![[Pasted image 20260702081941.png]]
![[Pasted image 20260702082108.png]]
![[Pasted image 20260702082310.png]]
![[Pasted image 20260702082325.png]]

## Syntaxe
```sql
-- exemple ici
```

## Piège / à retenir

-Les langages de programmation peuvent être classés comme étant
-==procéduraux== :- **Procédural** : séquence d’instructions à exécuter.
-==*déclaratifs*== : on décrit le résultat souhaité, le moteur choisit le plan d’exécution optimal.

->SQL prend en charge certaines syntaxes procédurales, mais l’interrogation des données avec SQL suit habituellement la sémantique déclarative.

-==Une base de données relationnelle== est une base de données dans laquelle les données ont été organisées en plusieurs tables (techniquement appelées _relations_), chacune représentant un type particulier d'entité (comme un client, un produit ou une commande client).

- **Ordre logique d’exécution** 

1. `FROM` → fournit les lignes sources.
    
2. `WHERE` → filtre les lignes.
    
3. `GROUP BY` → organise en groupes.
    
4. `HAVING` → filtre les groupes.
    
5. `SELECT` → détermine les colonnes affichées.
    
6. `ORDER BY` → trie les résultats.
## Questions que j'ai eues
**-Diff entre convert/cast** :
- Utilise **CAST** si tu veux rester conforme à la norme SQL (portable entre systèmes).
    
- Utilise **CONVERT** si tu es sur SQL Server et que tu veux profiter des **styles de formatage** (dates, heures, nombres).
    
- Les variantes **TRY_CAST** et **TRY_CONVERT** permettent d’éviter les erreurs en renvoyant `NULL` si la conversion échoue.
**syntaxe**:
`CAST(expression AS type)`:convertir 1 val ->type de données cible
`CONVERT(type, expression, style):mm que cast sauf que elle prend un param supplem pour formater dates+nb (par exp: 101 = `MM/DD/YYYY`, 102 = `YYYY.MM.DD`, 126 = ISO 8601)

-diff entre ma version et celle de microsoft learn
-> moi: v complète != ml: v lite ;  donc j'ai plutôt:  
- `Sales.Customer (relation client)`
- `Sales.SalesOrderHeader`
- `Person.Person` (noms)
- `Person.PersonPhone (tels)`
- `Production.Product`
- BusinessEntityID (clé magique)

**quand + ou ,**
- `+` plante si une valeur est `NULL` → résultat = `NULL`
- `CONCAT` ignore les `NULL` → continue quand même

**JOINS:**
![[Pasted image 20260625235054.png]]