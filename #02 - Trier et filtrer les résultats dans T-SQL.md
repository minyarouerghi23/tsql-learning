## Concepts clés
### Points clés sur `ORDER BY`

- **Position logique** : exécutée après `SELECT`, `FROM`, `WHERE`, `GROUP BY`, et `HAVING`.
    
- **But** : impose un ordre de tri des résultats envoyés au client.
    
- **Sans ORDER BY** : l’ordre est imprévisible, dépendant du moteur, des index ou du plan d’exécution.
    
- **Conformité** : respecte la théorie relationnelle (les tables n’ont pas d’ordre intrinsèque).

### Options possibles dans `ORDER BY`

- **Nom de colonne** : `ORDER BY ProductName`
    
- **Alias de colonne** : `ORDER BY Category`
    
- **Position ordinale** (ex. `ORDER BY 2`) → ⚠️ peu lisible, à éviter sauf cas particuliers.
    
- **Colonnes hors SELECT** : possible si elles proviennent du `FROM`. 👉 Attention : avec `DISTINCT`, toutes les colonnes de `ORDER BY` doivent être dans `SELECT`.

📌 **Colonnes utilisables** :

- Nom de colonne (`ORDER BY ProductName`)
    
- Alias de colonne (`ORDER BY Category`)
    
- Position ordinale (`ORDER BY 2`) → ⚠️ peu lisible, à éviter ( c le num e la colonne genre 2 heya ville ou 3 heya age)
    
- Colonnes hors `SELECT` (sauf avec `DISTINCT`, où elles doivent être incluses dans `SELECT`) =>utilité:Tu peux **trier sur une colonne technique** (ex. ID, Date de création) sans l’afficher.


## Limiter les résultats triés (TOP)
- 📌 **Nature** : extension propriétaire de Microsoft T-SQL.
    
- 📌 **But** : limiter le nombre de lignes retournées par une requête.
    
- 📌 **Formes possibles** :
    
    - `TOP (N)` → retourne N lignes.
        
    - `TOP (N) PERCENT` → retourne N % des lignes (arrondi à l’entier supérieur).
        
    - `TOP (N) WITH TIES` → inclut aussi les lignes ex æquo avec la dernière valeur retenue.
    
- 📌 **WITH TIES** :(`TOP (N) WITH TIES` retourne **au moins N lignes**, mais peut en inclure davantage si des lignes supplémentaires ont la **même valeur de tri** que la dernière retenue.)
    
    - Ajoute toutes les lignes ayant la même valeur que la dernière retenue.
        
    - Utile pour ne pas couper des valeurs identiques.
        
- 📌 **PERCENT** :
    
    - Retourne un pourcentage du total.
        
    - Exemple : `TOP 10 PERCENT` → 10 % des lignes, arrondi à l’entier supérieur.
        
- 📌 **Limite** :
    
    - `TOP` ne permet pas d’ignorer des lignes (pas d’équivalent direct à `OFFSET`).
        
    - Pour paginer, on utilise `ORDER BY` avec `OFFSET … FETCH`.

## OFFSET-FETCH:
- 📌 **Nature** : extension de la clause `ORDER BY` (propriétaire T-SQL).
    
- 📌 **But** : permet de retourner une **plage de lignes** (utile pour la pagination).
- - 📌 **OFFSET** : nombre de lignes à ignorer (peut être 0).
    
- 📌 **FETCH NEXT** : nombre de lignes à retourner après le décalage.

## SUPPRIMER LES DOUBLONS:
`DISTINCT` supprime les doublons et retourne uniquement les combinaisons uniques des colonnes listées dans `SELECT`.

## Prédicats (WHERE):
**WHERE** : filtre les lignes selon des conditions → seules celles évaluées à **TRUE** sont retournées.
- 📌 ==**Prédicats** = conditions logiques appliquées aux colonnes.==
    
    - Opérateurs de comparaison : `=`, `<>`, `>`, `>=`, `<`, `<=`.
        
    - Gestion des valeurs nulles : `IS NULL`, `IS NOT NULL`.
        
- 📌 **Combinaison de conditions** :
    
    - `AND` → toutes les conditions doivent être vraies.
        
    - `OR` → au moins une condition doit être vraie.
        
    - Parenthèses → clarifient la priorité et évitent les ambiguïtés.
        
- 📌 **Opérateurs pratiques** :
    
    - `IN` → équivalent à plusieurs `OR`.
        
    - `BETWEEN` → intervalle inclusif (utile aussi pour les dates).
        
    - `LIKE` → recherche de motifs dans les chaînes (`%` = plusieurs caractères, `_` = un seul caractère).
        
- 📌 **Dates** :
    
    - Attention aux bornes → `BETWEEN` inclut les limites.
        
    - Pour couvrir une journée entière, préciser l’heure (`23:59:59.999`) ou utiliser `>=` et `<`.

## Syntaxe
ORDER BY:
```sql
SELECT <select_list>
FROM <table_source>
ORDER BY <order_by_list> [ASC|DESC];
```
TOP:
```sql
SELECT TOP (N) <colonnes>
FROM <table>
WHERE <condition>
ORDER BY <colonne> [ASC|DESC];
```
OFFSET-FETCH:
```sql
ORDER BY <colonne> [ASC|DESC]
OFFSET <n> ROWS
FETCH NEXT <m> ROWS ONLY;
```
## Piège / à retenir
Order By:
**Sans DISTINCT** : tu peux trier sur n’importe quelle colonne de la table, même si elle n’est pas affichée.

---------------------------------------------------------------------
TOP:
📌 **Importance de ORDER BY** :

- Avec `ORDER BY` → garantit que les N lignes sont les “premières” selon un critère.
    
- Sans `ORDER BY` → résultats imprévisibles (aucun ordre garanti)

- **TOP seul** → coupe strictement à N lignes.
    
- **TOP WITH TIES** → élargit le résultat pour ne pas exclure des valeurs identiques au seuil.
    
- 👉 Utile pour éviter de “casser” un groupe de données ayant la même valeur (ex. prix, score, date)..
---------------------------------------------------------------------
OFFSET-FETCH:
- **TOP** → limite brutale du nombre de lignes.
    
- **OFFSET-FETCH** → permet de **paginer** (sauter des lignes + récupérer un bloc).

|Fonction|Syntaxe|Usage principal|Particularités|
|---|---|---|---|
|**TOP (N)**|`` `SELECT` `TOP` `10` `...` ``|Retourner un nombre fixe de lignes|Dépend de `` `ORDER` `BY` `` pour définir quelles lignes sont “premières”. Sans `` `ORDER` `BY` ``, résultat imprévisible.|
|**TOP (N) WITH TIES**|`` `SELECT` `TOP` `10` `WITH` `TIES` `...` `ORDER` `BY` `Prix` `DESC` ``|Inclure les ex æquo avec la dernière valeur|Peut retourner plus de N lignes si plusieurs ont la même valeur de tri.|
|**TOP (N) PERCENT**|`` `SELECT` `TOP` `10` `PERCENT` `...` ``|Retourner un pourcentage du total|Arrondi à l’entier supérieur. Peut aussi être combiné avec `` `WITH` `TIES` ``.|
|**OFFSET-FETCH**|`` `ORDER` `BY` `Colonne` `OFFSET` `20` `ROWS` `FETCH` `NEXT` `10` `ROWS` `ONLY` ``|Pagination (sauter X lignes et récupérer Y lignes)|OFFSET obligatoire, FETCH optionnel. Chaque requête est indépendante, pas d’état côté serveur.|
EXEMPLE:
```sql
-- Page 1 (10 premières lignes)
SELECT ProductID, ProductName, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY;

-- Page 2 (lignes 11 à 20)
SELECT ProductID, ProductName, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;
```
---------------------------------------------------------------------
SUPPRESSION DE DOUBLONS:
select par défaut :`ALL` = comportement implicite (toutes les lignes, y compris doublons)
## Questions que j'ai eues

![[Pasted image 20260701121542.png]]
![[Pasted image 20260701121819.png]]
