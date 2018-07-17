require_relative "boardcase.rb"
require_relative "player.rb"
require_relative "game.rb"


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

