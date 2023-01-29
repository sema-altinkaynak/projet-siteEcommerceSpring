# SRA1-Projet
## Auteurs
- AYDOGDU BEKIR
- ID TALEB REDA
- VERDON LOUIS
- ALTINKAYNAK SEMAE

# Installation

Dans le dossier webapps de Tomcat, tapez les commandes
```
git clone https://github.com/louisverdon/JEE-PJ22-Retrait.git
cd JEE-PJ22-Retrait
mvn package
```

N'oubliez pas de modifier le server.xml dans conf/server.xml de Tomcat
```
<Context docBase="$chemin-vers-webapp/JEE-PJ22-Retrait/target/sra1-0.0.1-SNAPSHOT" path = "retrait" reloadable = "true"/>
```

# Aller sur l'application
Une fois Tomcat lancé, ouvrez votre navigateur et aller sur l'url suivante :
`localhost:8080/retrait/app/docks`
Pour naviguer sur les différentes pages de l'application, utiliser la bar de navigation en haut de la page.

# Fonctionnalités implémentés
1. Gestion de docks : ajout, modification et suppression  d’un quai
Un admin peut ajouter, modifier ou supprimer un quai à partir de l'url localhost:8080/retrait/app/docks
L'ajout d'un dock doit spécifier sa longueur, largeur, son X, son Y et si le dock est libre ou non.
Si un dock est supprimé la page n'est pas rechargée mais juste la ligne de la table qui est supprimée(c'est fait grâce au Ajax et JQuery).

Remarques: 
- Un dock ne peut pas être ajouté ou modifié si celui ci rentre en collision avec un autre dock.
- On ne peut pas ajouter plus 30 docks

2. Possibilité de visualiser les docks présents en mode 2D
La visualisation se fait avec le JQuery en récupérant les données(method Post) renvoyés par le serveur. Le plan 2D est construit gràce aux balise svg du html.

3. Récupération des commandes livrées

4. Génération d’une livraison
Génération d'une livraison a livré grâce à un affichage simple qui demande seulement l'identifiant à l'utilisateur. Cela envoie ensuite l'utilisateur vers la page du code barres qui est censé être imprimé. On vérifie ici que l'utilisateur existe bien et qu'un dock est disponible ou sinon un message d'erreur sera affiché avec l'erreur encourue.
Pour des facilitées d'utilisation, les utilisateurs ont été mockés.
Entrez alors l'un des identifiants suivants :
Reda, Bekir, Louis, Sema, one, one1, one2, one3

5. Affichage des livraisons en cours
Affichage de toutes les livraisons en cours, avec leurs identifiants, leurs status et l'employé attribué a celui-ci si déjà attribué. Si aucune commande n'est en cours, un message dira qu'il n'y a aucune commande. Après l'attribution, la page sera rafraîchie pour pouvoir affiché que l'employé a bien été attribué à la commande.

6. Prise en charge des livraison par des employés
Dans l'affichage de toutes les livraisons en cours, si aucun employé n'est attribué à l'un d'entre eux, une liste déroulante sera affichée pour que les employés puissent s'attribuer à la livraison.

7. Génération d’un code barre
Lorsque l'utilisateur a entré son identifiant, son code barre est généré et est affiché. Il pourra ensuite être imprimé.

8. Affichage des informations de la livraison
Dans l'onglet Request, l'employé peut noter les 12 premiers caractères du code barre généré.
Si le code barre est correct, il est redirigé vers les informations de la livraison (Id de la commande, Statut de la commande, nom du client, numéro du quai attribué).
Sinon, on lui demandera de ressaisir un code.

8. Validation d’une livraison
Sur la page d'information, si un employé a été attribué, l'employé peut valider la commande.
Cela permettra de libérer le quai et de changer le statut de la commande.

9. Affichage du nombre de livraison fait par heure
La page des statistiques permet d'afficher le nombre de commande livré par heure. Ainsi sur la page statistique, il y a une barre de recherche permettant de choisir les données affichées selon une date. 
Sur cette partie, il a fallu coder en dur la requete SQL sur le repository car il était plus simple d'utiliser SQL pour recuperer les données.
Il a fallu utiliser un mock pour les commandes et un mock pour les utilisateurs (plus précisement les employés)

10. Affichage du nombre de livraison fait par employé et par heure
Cette partie est similaire à la partie 9.
Le plus compliqué était d'enregistrer l'heure d'une date, cela a beaucoup posé problème

# Difficultés rencontrées
- Lors de l'ajout d'une date dans la base de données, il a été difficile de prendre en compte l'heure car la base de données ne prenait pas en compte les heures et minutes. Cette erreur était du à la base de données. 

- Pour la représentation des ddocks en 2D c'était difficile de retrouver les API Java qui faisait préalablement la visualisation 2D. Donc ce qui fait que la représenatation en 2D était gérée coté front-end(en utilisant la norme SVG). En effet, Ajax est utilisé afin de faire une requete GET et récupérer les données du coté back-end(Les données récupéré sont en format JSON).
