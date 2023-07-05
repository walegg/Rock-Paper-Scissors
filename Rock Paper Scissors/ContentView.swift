//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Louis Mille on 04/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var playerMoves = ["Rock", "Paper", "Scissors"]
    @State private var gameMoves = ["Scissors", "Rock", "Paper"]
    @State private var gameMove = Int.random(in: 0...2)
    @State private var playerOutcome = Bool.random()
    @State private var outcomeTitle = ""
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    @State private var currentRound = 1
    @State private var showingScore = false
    @State private var resetGame = false
    
    var moveImage: some View {
        VStack {
            Button {
                rockTapped()
            } label: {
                Image(playerMoves[0])
            }
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 30)
            
            Button {
                paperTapped()
            } label: {
                Image(playerMoves[1])
            }
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 30)
            
            Button {
                scissorsTapped()
            } label: {
                Image(playerMoves[2])
            }
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 30)
        }
    }

    var body: some View {
        ZStack {
            EllipticalGradient(gradient: .init(colors: [.purple, .blue]))
                .ignoresSafeArea()
            
            VStack {
                Text("Guess the right move 😝")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical, 5)
                
                Text("Game's move:")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                VStack {
                    Image(gameMoves[gameMove])
                        .frame(maxWidth: .infinity)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal, 30)
                }
                
                Text("Your move:")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                Text("(You have to \(winOrLoose()))")
                
                moveImage
                
                VStack {
                    Text("Round \(currentRound)/10")
                        .foregroundColor(.white)
                }
                
                Text("Score: \(currentScore)")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Next round", action: nextRound)
        } message: {
            Text("Your score is \(currentScore)")
        }
        .alert(scoreTitle, isPresented: $resetGame) {
            Button("Start again", action: newRound)
        } message: {
            Text("Your final score is \(currentScore)")
        }
    }
    
    func rockTapped () {
        if gameMove == 0 && playerMoves[0] == "Rock" && playerOutcome == true  {
            //Scissors & Win
            scoreTitle = "Good answer"
            currentRound += 1
            currentScore += 1
        } else if gameMove == 2 && playerMoves[0] == "Rock" && playerOutcome == false {
            //Paper & Lose
            scoreTitle = "Good answer"
            currentRound += 1
            currentScore += 1
        } else if gameMove == 2 && playerMoves[2] == "Scissors" && playerOutcome == true {
            scoreTitle = "You were supposed to win!"
            currentRound += 1
            currentScore -= 1
        } else if gameMove == 0 && playerMoves[1] == "Paper" && playerOutcome == false {
            scoreTitle = "You were supposed to lose!"
            currentRound += 1
            currentScore -= 1
        } else {
            scoreTitle = "Tie!"
            currentRound += 1
        }
        showingScore = true
    }

    func paperTapped () {
        if gameMove == 1  && playerMoves[1] == "Paper" && playerOutcome == true {
            // Rock & Win
            scoreTitle = "Good answer!"
            currentRound += 1
            currentScore += 1
        } else if gameMove == 0 && playerMoves[1] == "Paper" && playerOutcome == false {
            // Scissors & Lose
            scoreTitle = "Good answer!"
            currentRound += 1
            currentScore += 1
        } else if gameMove == 1 && playerMoves[0] == "Rock" && playerOutcome == true {
            scoreTitle = "You were supposed to win!"
            currentRound += 1
            currentScore -= 1
        } else if gameMove == 1 && playerMoves[2] == "Scissors" && playerOutcome == false {
            scoreTitle = "You were supposed to lose!"
            currentRound += 1
            currentScore -= 1
        } else {
            scoreTitle = "Tie!"
            currentRound += 1
        }
        showingScore = true
    }

    func scissorsTapped () {
        if gameMove == 2 && playerMoves[2] == "Scissors" && playerOutcome == true {
            //Paper & Win
            scoreTitle = "Good answer!"
            currentRound += 1
            currentScore += 1
        } else if gameMove == 1 && playerMoves[2] == "Scissors" && playerOutcome == false {
            // Rock & Lose
            scoreTitle = "Good answer!"
            currentRound += 1
            currentScore += 1
        } else if gameMove == 1  && playerMoves[1] == "Paper" && playerOutcome == true {
            scoreTitle = "You were supposed to win!"
            currentRound += 1
            currentScore -= 1
        } else if gameMove == 2 && playerMoves[0] == "Rock" && playerOutcome == false {
            scoreTitle = "You were supposed to lose!"
            currentRound += 1
            currentScore -= 1
        } else {
            scoreTitle = "Tie!"
            currentRound += 1
        }
        showingScore = true
    }
    
    func winOrLoose() -> String {
        if playerOutcome == true {
            return "win"
        } else {
            return "lose"
        }
    }
    
    func nextRound() {
        if currentRound == 11 {
            scoreTitle = "No more round"
            resetGame = true
    
        } else {
            gameMove = Int.random(in: 0...2)
            playerOutcome.toggle()
        }
    }
    
    func newRound() {
        if resetGame == true {
            currentScore = 0
            currentRound = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
