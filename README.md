# Spinkop
 <p align="right"><sup>Projet tuteuré MMI 2016</sup></p>
 
 ### Configuration requise
 - [Ruby](https://www.ruby-lang.org/fr/documentation/installation/)
 - [Rails 4](http://guides.rubyonrails.org/getting_started.html#installing-rails)
 - [PostgreSQL](https://www.postgresql.org)
 
 ### Installation
 - Cloner le repository sur votre ordinateur
 - Exécuter ```bundle``` dans le répertoire du projet
 - Lancer postgreSQL
 - Exécuter ```rake db:create``` puis ```rake db:migrate``` dans le répertoire du projet
 - Pour entrer automatiquement tous thèmes et tags en base de données, exécuter ```rake db:seed``` dans le répertoire du projet
 
 ### Démarrage
 - Lancer postgreSQL
 - Lancer le serveur Rails (```rails s``` dans le répertoire du projet)
 - L'application est accessible depuis ```localhost:3000``` dans votre navigateur
 
 ### En cas de problème lors du démarrage ou de l'accès à l'application
 - Exécuter ```bundle``` dans le répertoire du projet
 - S'assurer que postgreSQL est bien en fonctionnement
 - Vérifier qu'il n'y a pas de migration en attente, sinon exécuter ```rake db:migrate``` dans le répertoire du projet
 
 ### Précautions à prendre sur le repository
 - __Renseigner des libellés indicatifs pour vos commits:__ Très bref descriptif de vos modifications
 - __Optimiser le travail de groupe:__ N'écrasez pas le travail des autres membres de l'équipe, concertez-vous. Pushez uniquement sur la branche qui concerne votre travail.
