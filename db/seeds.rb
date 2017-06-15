tags = [
	'Vie', 'Âge', 'Mort', 'Alimentation', 'Aliment',
	'Jeu', 'Sport', 'Commerce', 'Argent', 'Économie',
	'Entreprise', 'Possession', 'Communication', 'Langage', 'Écriture',
	'Informer', 'Télécommunications', 'Internet', 'Nom', 'Mouvement',
	'Déplacement', 'Transports', 'Bateau', 'Automobile', 'Train',
	'Avion', 'Deux-Roues', 'Corps', 'Organe', 'Santé',
	'Hygiène', 'Sommeil', 'Position', 'Sexualité', 'Techniques',
	'Instruments', 'Ordinateurs', 'Animal', 'Invertebré', 'Vertebré',
	'Plante', 'Pouvoir', 'Politique', 'Pays', 'Justice',
	'Securité', 'Militaire', 'Famille', 'Mariage', 'Matière',
	'Atome', 'Déchet', 'Feu', 'Eau', 'Force',
	'Édifice', 'Ville', 'Voie', 'Espace', 'Orientation',
	'Distance', 'Univers', 'Terre', 'Mer', 'Continent',
	'Climat', 'Saison', 'Temps', 'Date - Calendrier', 'Fait',
	'Intellect', 'Savoir', 'Apprentissage', 'Sens', 'Oui - Non',
	'Vérité', 'Société', 'Fête', 'Esprit', 'Religion',
	'Nombre', 'Mesure', 'Dimension', 'Sentiment', 'Salutation',
	'Faire', 'Finalité', 'Travail', 'Agriculture', 'Industrie',
	'Sens', 'Vision', 'Audition', 'Toucher', 'Être Humain',
	'Soi', 'Objets', 'Textile', 'Art'
]

themes = [
	{ name: 'Communication',          color: '#5597ba' },
	{ name: 'Innovation & technique', color: '#d16c92' },
	{ name: 'Pouvoir & politique',    color: '#53c18a' },
	{ name: 'Culture',                color: '#db9957' },
	{ name: 'Jeux',                   color: '#6e88d1' },
	{ name: 'Sport',                  color: '#d1595c' },
	{ name: 'Santé',                  color: '#75c756' },
	{ name: 'Espace & temps',         color: '#4e6c85' },
	{ name: 'Économie',               color: '#72d4d0' }
]

tags.each { |tag| Tag.create name: tag }

themes.each do |theme|
	Theme.create(
		name: theme[:name],
		color: theme[:color]
	)
end

20.times do |n|
	Indefinition.create(
		name: "Nom de l'indef",
		description: "Bonjour Lucas, j'espère que tout va bien, et que surtout, tu t'amuses bien à coder, je te souhaite un bon projet Tut :)",
		auteur: "Oui"
		)
end
# 20.times do |n|
# 	Issue.create(
# 		content: 'Issue #'+n.to_s,
# 		theme: Theme.order('RANDOM()').limit(1).first
# 	)
# 	puts n.to_s
# end
#
#
# 50.times do |n|
# 	Article.create(
# 		title: 'Article #'+n.to_s,
# 		content: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
# 		author: User.first,
# 		issue: Issue.order('RANDOM()').limit(1).first,
# 		tags: Tag.order('RANDOM()').limit(rand(10))
# 	)
# 	puts n.to_s
# end
