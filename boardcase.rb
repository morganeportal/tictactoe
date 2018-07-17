require_relative "board.rb"
require_relative "player.rb"
require_relative "game.rb"


class BoardCase
	attr_accessor  :etat
	def initialize
		@etat = "."    # etats possibles : "." ou "X" ou "O" 
	end
	def tic(signe)     # méthode qui change le signe dans une case de la grille
		@etat = signe
	end
end

