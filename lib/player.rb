class Player
	attr_accessor :name, :life_points, :players
	@@players = []
	#Initialisation du joueur
	def initialize(player_name)
		@name = player_name
		@life_points = 10
		@@players << self
	end
	#Affichage de l'état du joueur
	def show_state
		puts "Il reste #{@life_points} points de vie à #{@name}"
	end
	#Le joueur peut prendre des degats jusqu'a tomber a zero
	def gets_damage(atk)
		@life_points -= atk
		(@life_points > 0)? nil: (puts "Le joueur #{@name} a été tué!")
	end
	#Methode de randomisation de l'atk dmg
	def compute_damage
		rand(1..6)
	end
	def attacks(player)
		puts "Le joueur #{name} attaque le joueur #{player.name}"
		atk_dmg = self.compute_damage
		puts "Il lui inflige #{atk_dmg} points de dégats"
		@@players.each do |ennemi|
			(ennemi.name == player.name)? (ennemi.gets_damage(atk_dmg)): nil
		end
	end
end

class HumanPlayer < Player
	attr_accessor :weapon_level
	#Initialisation du joueur Humain
	def initialize(player_name)
		@name = player_name.to_s
		@weapon_level = 1
		@life_points = 100
		@@players << self
	end
	#Affichage de l'état du joueur Humain
	def show_state
		puts "Il reste #{@life_points} points de vie à #{@name} et son arme est niveau #{weapon_level}"
	end
	#Methode de randomisation de l'atk dmg en fonction du lvl de l'arme
	def compute_damage
		rand(1..6) * @weapon_level
	end
	#Methode de recherche d'une arme, si plus forte on prend sinon on laisse
	def search_weapon
		found_weapon_lvl = rand(1..6)
		puts "Tu as trouvé une arme de niveau #{found_weapon_lvl}"
		if (found_weapon_lvl > @weapon_level)
			puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends.\n\n"
			@weapon_level = found_weapon_lvl
		else
			puts "M@*#$... elle n'est pas mieux que ton arme actuelle...\n\n"
		end
	end
	#Methode de recherche d'un pack de soin en fonction d'une randomisation sur 6
	def search_health_pack 
		dice = rand(1..6)
		if dice == 1
			puts "Tu n'as rien trouver"
		elsif dice >= 2 && dice <= 5
			@life_points += 50
			@life_points = @life_points.clamp(0, 100)
		else
			puts "Waow, tu as trouvé un pack de +80 points de vie !"
			@life_points += 80
			@life_points = @life_points.clamp(0, 100)
		end
	end
end