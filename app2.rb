require 'bundler'
require 'pry'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts " 
------------------------------------------------
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------"

players =[]

#Création de tous les pnj et récupération du nom du pj + création
player1 = Player.new("Perceval")
player2 = Player.new("Karadoc")
puts "Quel nom voulez vous donner a votre personnage?"
print "> "
username = gets.chomp
user = HumanPlayer.new(username)

players << player1
players << player2

#Création de la boucle de la phase d'attaque
while user.life_points >0 && (player1.life_points > 0 || player2.life_points >0)
	puts "Point de vie : #{user.life_points}"
	puts "Quelle action veux-tu effectuer ?"
	puts "a - chercher une meilleure arme"
	puts "s - chercher à se soigner"
	puts
	puts "attaquer un joueur en vue :"
	#Check des points de vie des pnj
	if player1.life_points > 0
		puts "0 - #{player1.name} a #{player1.life_points} points de vie"
	else
		puts "#{player1.name} Est mort"
	end
	if player2.life_points > 0
		puts "1 - #{player2.name} a #{player2.life_points} points de vie"
	else
		puts "#{player2.name} Est mort"
	end
	print "> "
	#Récupération et mise en place de l'action du pj
	action = gets.chomp
	case action.to_s
	when "a"
		user.search_weapon
	when "s"
		user.search_health_pack
	when "0"
		user.attacks(player1)
	when "1"
		user.attacks(player2)
	else
		puts "Mauvaise commande"
	end
	puts
	#Check points de vie des pnj
	break if (player1.life_points <= 0 && player2.life_points <= 0)
	x = rand(1..3)
	case x.to_s
	when "1"
		puts "Ils vous attaquent avec du sable pilé !"
	when "2"
		puts "Ils vous attaquent avec des objets redondant !"
	when "3"
		puts "\"BATTEZ VOUS A MAINS NUES\" vous crient-ils \"CAR LES ARMES C'EST POURRI SAUF POUR CEUX QUI AIMENT SE LA PÊTER\" continuent-ils avant de vous attaquer !"
	end
	#Action des pnj + check points de vie du pj
	players.each {|enemy| enemy.attacks(user) if enemy.life_points > 0 && user.life_points > 0}
	break if user.life_points <= 0
	puts "\nIl te reste #{user.life_points} points de vie."
	puts 
end

#Fin de partie, check qui a gagné en fonction des points de vie de chacuns
if user.life_points <= 0
	puts "Dommage vous avez PERDU !!"
elsif player1.life_points <= 0 && player2.life_points <= 0
	puts "Félicitations vous avez GAGNÉ avec #{user.life_points} points de vie restant!!"
end