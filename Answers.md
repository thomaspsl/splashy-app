
## Expliquez ce qu’est LazyVGrid et pourquoi on l’utilise.

Une LazyVGrid permet de créer une colonne d'objet ayant pour taille la quantité minimal d'objet qui se trouve à l'intérieur. On l'utilise par ce qu'il permet de pouvoir faire une colonne / liste des images à afficher dans un "cadre".

## Expliquez les différents types de colonnes et pourquoi on utilise flexible ici.

Les différents types de colonne : fixed / flexible / adaptive. On utilise flexible pour permettre à la colonne de s'adapter à l'espace disponible. 

## Votre grille ne doit pas être très jolie, expliquez pourquoi les images prennent toute la largeur de l’écran.

Les images prennent toute la largueur de l'écran parce qu'aucun padding leur a été mis.


## Il existe 3 façons de faire un appel asynchrone en Swift : Expliquez les différences entre ces 3 méthodes.

- async/await
- Combine
- completionHandler / GCD

async/await : Simplifie la gestion des appels asynchrones, rend le code plus lisible et plus facile à maintenir.
Combine : framework de programmation réactive qui permet de gérer les flux de données asynchrones.
completionHandler / GCD : Flexible et compatible avec les versions antérieures de Swift. Utilise des blocs de complétion (completionHandler) et Grand Central Dispatch (GCD) pour gérer les tâches asynchrones.
