
####################################### définitions des classes ###################################################################
class Board
	attr_accessor :grid
	def initialize		# crée la grille de 9 cases 
		@grid = []
		for i in 1..3        # trois lignes dans la grille
			i_line =[]
			for j in 1 ..3   # trois cases par ligne
				newcase = BoardCase.new
				i_line.push newcase
			end
			@grid.push i_line

		end
	end

	def afficher        # affiche la grille
		for i in 0..2
			ligne = [@grid[i][0].etat , @grid[i][1].etat , @grid[i][2].etat] 
			puts(ligne.join(" "))
		end
	end

end

class BoardCase
	attr_accessor  :etat
	def initialize
		@etat = "."    # etats possibles : "." ou "X" ou "O" 
	end
	def tic(signe)     # méthode qui change le signe dans une case de la grille
		@etat = signe
	end
end

class Player
	attr_accessor :name , :signe , :choix_ligne, :choix_colonne
	def initialize(name, signe)     #nom du joueur et symbole associé
		@name = name
		@signe = signe
		@choix_ligne = nil
		@choix_colonne = nil
	end
	def play(board)                #actions faites quand un joueur joue
		puts("Hey #{@name}! Choisis une case :))) ")
		printf("> ligne : ")
		@choix_ligne = gets.chomp.to_i
		printf("> colonne : ")
		@choix_colonne = gets.chomp.to_i
		if @choix_ligne > 2 || @choix_colonne > 2    #gestion d'exception : si le joueur entre un numero de ligne ou de colonne trop grand
			puts("nombres trop grands")
			self.play(board)
		else
			if (board.grid[@choix_ligne][@choix_colonne].etat == ".")   #gestion d'exception : on fait l'action seulement si la case n'a pas été déjà cochée, 
				board.grid[@choix_ligne][@choix_colonne].tic(signe)
			else                                                        #sinon on dit d'en choisir une autre
				puts("case déjà remplie !")
				self.play(board)
			end		
		end
	end
end

class Game

	def initialize

		# definition des joueurs :
		puts("nom du joueur 1 ?")
		printf(">")
		name_1 = gets.chomp()
		puts("nom du joueur 2 ?")
		printf(">")
		name_2 = gets.chomp()
		@joueur_1 = Player.new(name_1, "X")
		@joueur_2 = Player.new(name_2, "O")

		# definition du plateau de jeu :
		@board = Board.new
		@board.afficher
	
		while !end_of_game       
			@joueur_1.play(@board)
			@board.afficher
			if(end_of_game)
				break
			else
				@joueur_2.play(@board)
				@board.afficher
			end
		end
	end

	def end_of_game  # gestion de fin de partie
		grid = @board.grid

		ligne_1_X = (grid[0][0].etat == "X" && grid[0][1].etat == "X" && grid[0][2].etat== "X")
		ligne_1_O = (grid[0][0].etat == "O" && grid[0][1].etat == "O" && grid[0][2].etat== "O")
		ligne_2_X = (grid[1][0].etat == "X" && grid[1][1].etat == "X" && grid[1][2].etat=="X")
		ligne_2_O = (grid[1][0].etat == "O" && grid[1][1].etat == "O" && grid[1][2].etat== "O")
		ligne_3_X = (grid[2][0].etat == "X" && grid[2][1].etat == "X" && grid[2][2].etat=="X")
		ligne_3_O = (grid[2][0].etat == "O" && grid[2][1].etat == "O" && grid[2][2].etat== "O")

		colonne_1_X = (grid[0][0].etat == "X" && grid[1][0].etat == "X" && grid[2][0].etat=="X")
		colonne_1_O = (grid[0][0].etat == "O" && grid[1][0].etat == "O" && grid[2][0].etat=="O")
		colonne_2_X = (grid[0][1].etat == "X" && grid[1][1].etat == "X" && grid[2][1].etat=="X")
		colonne_2_O = (grid[0][1].etat == "O" && grid[1][1].etat == "O" && grid[2][1].etat=="O") 
		colonne_3_X = (grid[0][2].etat == "X" && grid[1][2].etat == "X" && grid[2][2].etat=="X")
		colonne_3_O = (grid[0][2].etat == "O" && grid[1][2].etat == "O" && grid[2][2].etat=="O")

		diag_1_X = (grid[0][0].etat == "X" && grid[1][1].etat=="X" && grid[2][2].etat=="X")
		diag_1_O = (grid[0][0].etat == "O" && grid[1][1].etat=="O" && grid[2][2].etat=="O")
		diag_2_X = (grid[2][0].etat == "X" && grid[1][1].etat=="X" && grid[0][2].etat=="X")
		diag_2_O = (grid[2][0].etat == "O" && grid[1][1].etat=="O" && grid[0][2].etat=="O")

		#################### pour voir si la grille est totalement remplie ##################
		complete = 0
		for i in 0..2
			for j in 0..2
				if grid[i][j].etat != "." 
					complete +=1
				end
			end
		end
		if complete == 9 
			fullgrid = true
		else 
			fullgrid = false
		end 
		#####################################################################################

		if (ligne_1_X || ligne_2_X || ligne_3_X || colonne_1_X || colonne_2_X || colonne_3_X || diag_1_X || diag_2_X)     # conditions joueur 1 vainqueur
			puts("#{@joueur_1.name} a gagné !")
			return true
		elsif (ligne_1_O || ligne_2_O || ligne_3_O || colonne_1_O || colonne_2_O || colonne_3_O || diag_1_O || diag_2_O)  # conditions joueur 2 vainqueur
			puts("#{@joueur_2.name} a gagné !")
			return true
		elsif fullgrid        # personne n'est vainqueur mais la grille est pleine => match nul 
			puts("match nul !")
			return true
		else
			return false
		end
	end
end
###################################################################################################################################

########################### main ##########################################################

jeu = Game.new

###########################################################################################

