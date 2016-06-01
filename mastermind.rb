# Author- Zachary Keller
# Date- 6/1/16
# Creates and plays the game Mastermind. It's really fun but a bit confusing, I have the directions
# built into the game but I suggest trying to learn how to play first.
class Mastermind
	
	#Like a Constructor: is called when an instance of the class is made
	def initialize
		run
	end
	
	#initializes the 'real' code
	def initBoard
		prng = Random.new
		spotOne = prng.rand(6).truncate + 97
		spotTwo = prng.rand(6).truncate + 97
		spotThree = prng.rand(6).truncate + 97
		spotFour = prng.rand(6).truncate + 97
		@real = [spotOne, spotTwo, spotThree, spotFour]
		#@real = [98, 100, 97, 98]
		#classfield
		@guesses = []
	end

	#updates the class field @guesses to reflect the guess the user just made
	def store(guessBoard)
		@guesses.unshift([guessBoard.shift,guessBoard.shift,guessBoard.shift,guessBoard.shift])
	end

	#asks the user for four guesses of the code
	def createGuess
		print "Please use lowercase letters a - f: \n" 
		print "first spot: " 
		first = gets
		print "second spot: " 
		second = gets
		print "third spot: " 
		third = gets
		print "fourth spot: " 
		fourth = gets
		guessBoard = [first.ord, second.ord, third.ord, fourth.ord]
		store(guessBoard)
		return [first.ord, second.ord, third.ord, fourth.ord]
	end	
	
	#displays all the guesses along with the red and white pins that tell you whether your guess was right.
	#it displays the board like the actual game
	def displayBoard
		x = 0
		print "\n"
		while x < @guesses.length
			print " -------------------\n"
			y = 0
			while y < @guesses[x].length
				if y < 4
					print "| " + @guesses[x][y].chr + " | " 
				else
					print @guesses[x][y]
				end
				y = y+1
			end
			print "\n -------------------\n"
			x = x+1
		end
		print "\n"
	
	end

	#uses an algorithm to check how well you guessed the code and adds red or white pins to the boad depending on how well you did
	def checkSpots
		temp = Array.new(@real)
		tempG = Array.new(@guesses[0])
		x = 0
		while x < 4			
			if temp[x] == tempG[x]
				@guesses[0].push('r')
				temp[x] = nil
				tempG[x] = nil
				
			end
			x = x+1
		end
		#print temp
		#print @real
		#print tempG
		#print @guesses
		#print "\n"
		x = 0
		while x < 4	
			if temp.include?(tempG[x])
				if tempG[x] != nil
					@guesses[0].push('w')
					temp.delete_at(temp.index(tempG[x]))
				end
			end
			x = x+1
		end
	end
			

	#runs the game, keeps going until you don't want to play anymore
	def run
		keepPlaying = true
		print "Welcome to Mastermind \n"
		print "Rules: The Computer will come up with a sequence of 4 letters from a, b, c, d, e, and f. \n
				For example, the computer might select: a b a e \n
				You then have 13 tries to guess the code. \n
				After each try, the board will be shown possibly with r or w next to your guess. \n
				r means that you have a correct letter in the correct spot. \n
				w means you have a correct letter in the wrong spot \n
				Use these clues to try and figure out the code. Good luck! \n\n"			
		while keepPlaying
			won = false
			lost = false
			initBoard
			#print @real
			while ! won && ! lost
				#print @real
				createGuess
				checkSpots
				displayBoard
				if @guesses[0].length == 8
					if @guesses[0][7].eql?('r')
						won = true
					end
				end
				if @guesses.length == 13
					lost = true
				end
			end
			if won
				print "You Won!! \n"
			elsif lost
				print "You Lost :( \n"
			end
			print "The code was: " + @real[0].chr + " | " + @real[1].chr + " | " + @real[2].chr + " | " + @real[3].chr + "\n"
			print "Play Again? yes or no: "
			ans = gets.chomp
			#print ans
			if ans.eql?('yes')
				print "\n Great! \n"
			else
				print "See you next time!\n"
				keepPlaying = false
			end
		end				
			
	end
end

#line of code that creates a new Mastermind game and actually begins to run the mastermind code
game = Mastermind.new


	
