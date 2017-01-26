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
	{ name: 'Communication',          image: 'communication', color: '#5597ba' },
	{ name: 'Innovation & technique', image: 'innovation',    color: '#d16c92' },
	{ name: 'Pouvoir & politique',    image: 'political',     color: '#53c18a' },
	{ name: 'Culture',                image: 'culture',       color: '#db9957' },
	{ name: 'Jeux',                   image: 'games',         color: '#6e88d1' },
	{ name: 'Sport',                  image: 'sport',         color: '#d1595c' },
	{ name: 'Santé',                  image: 'medical',       color: '#75c756' },
	{ name: 'Espace & temps',         image: 'space',         color: '#4e6c85' },
	{ name: 'Économie',               image: 'money',         color: '#72d4d0' }
]

tags.each { |tag| Tag.create name: tag }

themes.each do |theme|
	Theme.create(
		name: theme[:name],
		image: File.new("#{Rails.root}/db/files/themes/#{theme[:image]}.jpg"),
		color: theme[:color]
	)
end
