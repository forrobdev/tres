//
//  ContentView.swift
//  Test2
//
//  Created by Robin Despaquis on 29/01/2026.
//

import SwiftUI

struct UnoCard: Identifiable {
    let id = UUID() //Génère un ID unique
    let color: String
    let type: String
}

struct ContentView: View {
    
    @State private var showingWinAlert = false
    @State private var winnerName = ""
    @Binding var isPlaying: Bool
    
    @Namespace private var cardTransition
    @State private var userDeck: [UnoCard] = []
    @State private var botDeck: [UnoCard] = []
    @State private var middleCard: UnoCard = UnoCard(color: "rouge", type: "zero")
    @State private var played: Bool = false
    @State private var showColorSelect: Bool = false
    @State private var piocheBig: Bool = false
    @State private var middleBig: Bool = false
    let colors: [Color] = [.red, .blue, .yellow, .green]
    @State private var unoCards: Array = [
        //Cartes bleues Q = Sens interdit S = +2
        ["bleu", "zero"],
        ["bleu", "un"], ["bleu", "un"],
        ["bleu", "deux"], ["bleu", "deux"],
        ["bleu", "trois"], ["bleu", "trois"],
        ["bleu", "quatre"], ["bleu", "quatre"],
        ["bleu", "cinq"], ["bleu", "cinq"],
        ["bleu", "six"], ["bleu", "six"],
        ["bleu", "sept"], ["bleu", "sept"],
        ["bleu", "huit"], ["bleu", "huit"],
        ["bleu", "neuf"], ["bleu", "neuf"],
        ["bleu", "Q"], ["bleu", "Q"],
        ["bleu", "S"], ["bleu", "S"],
        
        //Cartes rouges
        ["rouge", "zero"],
        ["rouge", "un"], ["rouge", "un"],
        ["rouge", "deux"], ["rouge", "deux"],
        ["rouge", "trois"], ["rouge", "trois"],
        ["rouge", "quatre"], ["rouge", "quatre"],
        ["rouge", "cinq"], ["rouge", "cinq"],
        ["rouge", "six"], ["rouge", "six"],
        ["rouge", "sept"], ["rouge", "sept"],
        ["rouge", "huit"], ["rouge", "huit"],
        ["rouge", "neuf"], ["rouge", "neuf"],
        ["rouge", "Q"], ["rouge", "Q"],
        ["rouge", "S"], ["rouge", "S"],
        
        //Cartes jaunes
        ["jaune", "zero"],
        ["jaune", "un"], ["jaune", "un"],
        ["jaune", "deux"], ["jaune", "deux"],
        ["jaune", "trois"], ["jaune", "trois"],
        ["jaune", "quatre"], ["jaune", "quatre"],
        ["jaune", "cinq"], ["jaune", "cinq"],
        ["jaune", "six"], ["jaune", "six"],
        ["jaune", "sept"], ["jaune", "sept"],
        ["jaune", "huit"], ["jaune", "huit"],
        ["jaune", "neuf"], ["jaune", "neuf"],
        ["jaune", "Q"], ["jaune", "Q"],
        ["jaune", "S"], ["jaune", "S"],
        
        //Cartes vertes
        ["vert", "zero"],
        ["vert", "un"], ["vert", "un"],
        ["vert", "deux"], ["vert", "deux"],
        ["vert", "trois"], ["vert", "trois"],
        ["vert", "quatre"], ["vert", "quatre"],
        ["vert", "cinq"], ["vert", "cinq"],
        ["vert", "six"], ["vert", "six"],
        ["vert", "sept"], ["vert", "sept"],
        ["vert", "huit"], ["vert", "huit"],
        ["vert", "neuf"], ["vert", "neuf"],
        ["vert", "Q"], ["vert", "Q"],
        ["vert", "S"], ["vert", "S"],
        
        //Cartes noires J = +4 et K = Changement de couleur
        ["noir", "J"], ["noir", "J"], ["noir", "J"], ["noir", "J"],
        ["noir2", "K"], ["noir2", "K"], ["noir2", "K"], ["noir2", "K"]
    ];
    
    var body: some View {
        VStack {
            //Cartes du bot
            VStack {
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 5) {
                        ForEach(botDeck) { card in
                            ZStack {
                                Image("dos")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    }
                    .padding()
                }
                HStack{
                    Text("\(botDeck.count)")
                        .font(.headline)
                    Image("cards")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Bot")
                    Spacer()
                }
                .padding(.leading, 25)
                .frame(maxWidth: .infinity)
            }
            Spacer()
            //Carte du milieu et carte piocher
            HStack {
                ZStack {
                    Image(middleCard.color)
                        .resizable()
                        .scaledToFit()
                        .scaledToFill()
                        .frame(width: 110, height: 190)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .matchedGeometryEffect(id: middleCard.id, in: cardTransition, isSource: true)
                    
                    if middleCard.type != "J" && middleCard.type != "K" {
                        Image(middleCard.type)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: rightSize(type : middleCard.type))
                    }
                }
                .scaleEffect(middleBig ? 0.8 : 1.0)
                .animation(.bouncy(duration: 0.3), value: middleBig)
                .padding(.bottom, 8)
                Image("dos")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 190)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .scaleEffect(piocheBig ? 0.8 : 1.0)
                    .animation(.bouncy(duration: 0.3), value: piocheBig)
                    .onTapGesture {
                        if played {
                            print("Pas ton tour attends !")
                        } else {
                            played = true
                            piocher(botPlaying: false)
                            botPlay()
                        }
                    }
            }
            Spacer()
            //Cartes de l'user
            VStack {
                HStack{
                    Text("\(userDeck.count)")
                        .font(.title)
                    Image("cards")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    Spacer()
                    if showColorSelect {
                        ForEach(colors, id: \.self) { color in
                            Button(action: {
                                selectedColor(colorSelected: color)
                            }) {
                                Circle()
                                    .fill(color)
                                    .frame(width: 40, height: 40)
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.leading, 25)
                .frame(maxWidth: .infinity)
                
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 10) {
                        ForEach(userDeck) { card in
                            ZStack {
                                Image(card.color)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 110, height: 190)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                if card.type != "J" && card.type != "K" {
                                    Image(card.type)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: rightSize(type : card.type))
                                }
                            }
                            .matchedGeometryEffect(id: card.id, in: cardTransition, isSource: true)
                            .onTapGesture {
                                if played {
                                    print("Pas ton tour attends !")
                                } else {
                                    if isCardValid(type: card.type, color: card.color) {
                                        
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                            middleCard = card
                                            userDeck.removeAll { $0.id == card.id }
                                            played = true
                                        }
                                        
                                        if !isSpecialCard(type: card.type, color: card.color, player: "user") {
                                            botPlay()
                                            isWinning(cards: userDeck, player: "user")
                                        }
                                    } else {
                                        print("Pas valide essaye une autre")
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .scrollClipDisabled()
            }
        }
        .background(
            LinearGradient(
                colors: played ? [.red, .black] : [.black, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .onAppear() {
            regenerateDeck(botPlaying: true)
            regenerateDeck(botPlaying: false)
        }
        
        .alert("\(winnerName) a gagné !", isPresented: $showingWinAlert) {
            Button("Rejouer") {
                resetGame()
            }
            Button("Retour au menu") {
                isPlaying = false
            }
        } message: {
            Text("Quelle partie endiablée !")
        }
    }
    
//    //Gérer la taille d'un numéro sur une carte
//    func rightSize(type: String = "deux") -> CGFloat {
//        if type == "S" || type == "Q" {
//            return 55
//        } else if type == "un" {
//            return 18
//        } else {
//            return 30
//        }
//    }
    
    //Piocher une carte pour un joueur
    func piocher(botPlaying: Bool = false) {
        
        if let randomIndex = unoCards.indices.randomElement() {
            
            //On supprime la carte piochée
            let newCard = unoCards.remove(at: randomIndex)
            
            let newColor = newCard[0]
            let newType = newCard[1]
            
            animPiocher()
            if botPlaying {
                botDeck.append(UnoCard(color: newColor, type: newType))
                played = false
            } else {
                userDeck.append(UnoCard(color: newColor, type: newType))
            }
        } else {
            //Le paquet est vide en générer un nouveau
        }
    }
    
    //Regénérer le deck de cartes d'un joueur
    func regenerateDeck(botPlaying: Bool = false) {
        if botPlaying {
            botDeck.removeAll()
            for _ in 1...7 {
                piocher(botPlaying: true)
            }
        } else {
            userDeck.removeAll()
            for _ in 1...7 {
                piocher(botPlaying: false)
            }
        }
    }
    
    //Le bot check ses cartes, joue ou pioche s'il ne peut rien jouer
    func botPlay () {
        print("Bot : Je regarde chaque carte de mon jeu")
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(3))
            
            var validCards: [UnoCard] = []
            for card in botDeck {
                
                if isCardValid(type: card.type, color: card.color) {
                    validCards.append(card)
                    print("je peux jouer un \(card.type) \(card.color)")
                }
            }
            
            if validCards.isEmpty {
                print("je peux rien jouer je pioche")
                piocher(botPlaying: true)
                played = false
            } else {
                let botPlay = validCards.randomElement()!
                print("j'ai joué un \(botPlay.type) \(botPlay.color)!'")
                middleCard = botPlay
                botDeck.removeAll { $0.id == botPlay.id }
                if !isSpecialCard(type: botPlay.type, color: botPlay.color, player: "bot") {
                    isWinning(cards: botDeck, player: "Bot")
                    played = false
                }
            }
        }
    }
    
    //Quelqu'un gagne ?
    func isWinning(cards: [UnoCard], player: String = "bot") {
        if cards.isEmpty {
            win(winner: player)
        }
    }
    
    //Affiche le winner
    func win(winner: String = "Bot") {
        winnerName = winner
        showingWinAlert = true
    }
    
    //Animer quand on tire une carte dans la pioche
    func animPiocher() {
        piocheBig = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            piocheBig = false
        }
    }
    
    //Animer quand on pose une carte au milieu
    func animMiddle() {
        print("Voici l'animation d'une nouvelle carte au centre")
        middleBig = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            middleBig = false
        }
    }
    
    //Check si une carte peut être jouée
    func isCardValid(type: String = "un", color: String = "rouge") -> Bool {
        if color == "noir" || color == "noir2" || middleCard.color == color || middleCard.type == type {
            animMiddle()
            return true
        } else {
            return false
        }
    }
    
    //Est-ce une carte spéciale ? => Réalise le comportement spécial si besoin
    func isSpecialCard(type: String = "un", color: String = "rouge",player: String = "user") -> Bool {
        
        if color == "noir" {
            plus(number: 4, toBot: player == "user" ? true : false)
            if player == "user" {
                showColorSelect = true
            } else {
                botChooseColor()
            }
            return true
        } else if color == "noir2" {
            if player == "user" {
                showColorSelect = true
            } else {
                botChooseColor()
            }
            return true
        } else if type == "Q" {
            if player == "user" {
                played = false
                isWinning(cards: userDeck, player: player)
                print("Tour du bot skippé !")
            } else {
                played = true
                isWinning(cards: userDeck, player: player)
                print("Tour du joueur skippé !")
                botPlay()
            }
            return true
        } else if type == "S" {
            plus(number: 2, toBot: player == "user" ? true : false)
            isWinning(cards: userDeck, player: player)
            played = player == "user" ? true : false
            if player == "user" {
                botPlay()
            }
            return true
        } else {
            return false
        }
    }
    
    //Ajoute X cartes à un joueur
    func plus(number: Int = 2,toBot: Bool = true){
        for _ in 0...number-1 {
            piocher(botPlaying: toBot)
        }
        print("\(number) cartes ajoutées au bot ? => \(toBot)")
    }
    
    func selectedColor(colorSelected: Color = .blue) {
        showColorSelect = false
        played = true
        isWinning(cards: userDeck, player: "user")
        var newColor = "bleu"
        if colorSelected == .blue {
            newColor = "bleu"
        } else if colorSelected == .green {
            newColor = "vert"
        } else if colorSelected == .yellow {
            newColor = "jaune"
        } else if colorSelected == .red {
            newColor = "rouge"
        }
        middleCard = UnoCard(color: newColor, type: middleCard.type)
        botPlay()
    }
    
    func botChooseColor() {
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(1))
            let newCard = botDeck.randomElement()
            let newColor = newCard!.color
            isWinning(cards: userDeck, player: "bot")
            middleCard = UnoCard(color: newColor, type: middleCard.type)
            played = false;
        }
    }
    
    func resetGame() {
        userDeck.removeAll()
        botDeck.removeAll()
        
        regenerateDeck(botPlaying: true)
        regenerateDeck(botPlaying: false)
        
        played = false
    }
}

#Preview {
    ContentView(isPlaying: .constant(true))
}
