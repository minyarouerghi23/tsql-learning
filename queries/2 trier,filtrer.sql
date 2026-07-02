--module 3: exercices de tri/filtrage des données
--Sort results using the ORDER BY clause
 /*SELECT Name, ListPrice
 FROM production.Product; --no order
 select name,listprice
 from Production.product
 order by listprice desc,name asc; --là elles sont ordonnées   --Name ne sert donc que de "tie-breaker" (départage) quand plusieurs lignes ont la même valeur de ListPrice. Si toutes les valeurs de ListPrice sont uniques dans ta table, la colonne Name n'aura jamais d'effet visible.
-------------------------------------------------------------------------------------------------------------------------------------------------------------
--Restrict results using TOP
  SELECT TOP (20) Name, ListPrice
 FROM production.Product

  SELECT TOP (20) WITH TIES Name, ListPrice
 FROM Production.Product
 ORDER BY ListPrice DESC;--inclut les ex-aecquos donc rajoute une ligne supplem d'ou 21

 ---------------------------------------------------------------------------------------
 --Retrieve pages of results with OFFSET and FETCH
  SELECT Name, ListPrice
 FROM production.Product
 ORDER BY Name OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY; --starting at pos 0 collecting 10 rows

  SELECT Name, ListPrice
 FROM production.Product
 ORDER BY Name OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY; --offset saite les lignes 

 ------------------------------------------------------------------------------------
 --Use the ALL and DISTINCT options
  SELECT distinct Color,size --Elle s'applique sur la combinaison des deux, pas juste sur Color seule. donc sql server regarde chaque paire (Color, Size) comme une unité, et élimine les paires qui sont des doublons exacts. 
 FROM production.Product; --all est implicite donc mm sans l'écrire : mm res

 ------------------------------------------------------------------------
 --Filter results with the WHERE clause
  SELECT Name, Color, Size
 FROM Production.Product
 WHERE ProductNumber LIKE 'FR-_[0-9][0-9]_-[0-9][0-9]'; --ou <>6 OU  ListPrice > 1000.00  OU LIKE 'HL Road Frame %';

 --is (not)null
 SELECT Name, ListPrice
FROM production.Product
WHERE SellEndDate IS NOT NULL;

SELECT Name,SellEndDate
FROM production.Product
WHERE SellEndDate between '2012-05-29' and '2013-05-29'; --gauche MIN droite MAX;

select p.name,p.listprice,pc.name as categoryName ,psc.productcategoryid
from Production.product p
join production.Productsubcategory psc
on p.ProductSubcategoryID=psc.ProductSubcategoryID --on s'arrete là si on ne veut afficher que id sans nom mais c pas pratique car vague

--double join pour afficher le  nom
join production.ProductCategory pc
on pc.ProductCategoryID=psc.ProductCategoryID;

SELECT ProductCategoryID, p.Name, p.ListPrice,p.SellEndDate --affiché pour confirmer la condition mteha keka w bara
FROM production.ProductSubcategory psc 
join production.Product p
on psc.ProductSubcategoryID=p.ProductSubcategoryID
WHERE psc.ProductCategoryID IN (1,3,4) and p.SellEndDate is null
order by psc.ProductCategoryID asc,p.listprice desc;  */

SELECT p.Name, p.ProductNumber, psc.ProductCategoryID
FROM production.Product p
join Production.ProductSubcategory psc
on p.ProductSubcategoryID=psc.ProductSubcategoryID
WHERE p.ProductNumber LIKE 'FR%' OR psc.ProductCategoryID IN (1,3,4);




