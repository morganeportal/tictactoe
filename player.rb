require_relative "board.rb"
require_relative "boardcase.rb"
require_relative "game.rb"


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

