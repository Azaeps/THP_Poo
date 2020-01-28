require 'bundler'
require 'pry'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

#Création des deux joeurs
player1 = Player.new("José")
player2 = Player.new("Josiane")

#Premier affichage de l'état des joueurs
puts "Voici l'état de nos joueurs :"
player1.show_state
player2.show_state
sleep 1
puts 
#Boucle phase d'attaque
loop do
	#Check du nombre de points de vie et phase d'attaque
	puts "Passons à la phase d'attaque :"
	(player2.life_points <= 0)? break : nil
	player2.attacks(player1)
	sleep(1)
	(player1.life_points <= 0)? break : nil
	player1.attacks(player2)
	(player2.life_points <= 0)? break : nil
	sleep(1)
	puts
	#Affichage de l'état des joueurs a chaque tour
	puts "Voici l'état de nos joueurs :"
	sleep(1)
	player1.show_state
	player2.show_state
	puts
end
(player1.life_points > 0)? 
(puts "\nJosé a gagné le combat"): 
(puts "\nJosianne a gagné le combat")