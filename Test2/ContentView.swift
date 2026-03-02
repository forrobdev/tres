//
//  ContentView.swift
//  Test2
//
//  Created by Robin Despaquis on 29/01/2026.
//

import SwiftUI

//struct UnoCard: Identifiable {
//    let id = UUID()
//    let color: String
//    let type: String
//}

struct ContentView: View {
    
    //Pour les stats
    @AppStorage("victories") private var victories = 0
    @AppStorage("pseudo") private var pseudo = "Anonyme"
    @AppStorage("gamesPlayed") private var gamesPlayed = 0
    @AppStorage("drawnCards") private var drawnCards = 0
    @AppStorage("minutesPlayed") private var minutesPlayed = 0
    
    @State private var miniDrawnCards: Int = 0
    
    let startingGameDate: Date = Date()
    
    @State private var showingWinAlert = false
    @State private var winnerName = ""
    
    @Binding var isPlaying: Bool
    @Binding var gamemode: Int
    
    @Namespace private var cardTransition
    @State private var userDeck: [card] = []
    @State private var botDeck: [card] = []
    @State private var middleCard: card = card(type: "rouge", color: "zero")
    @State private var played: Bool = false
    @State private var showColorSelect: Bool = false
    @State private var piocheBig: Bool = false
    @State private var middleBig: Bool = false
    let colors: [Color] = [.red, .blue, .yellow, .green]
    
    class card: Identifiable {
        
        var type: String
        var color: String
        var id = UUID()
        
        init(type:String, color:String) {
            self.type = type
            self.color = color
        }
    }
    
    @State private var unoCards: [card] = [
        // Cartes bleues Q = Sens interdit S = +2
        card(type: "zero", color: "bleu"),
        card(type: "un", color: "bleu"), card(type: "un", color: "bleu"),
        card(type: "deux", color: "bleu"), card(type: "deux", color: "bleu"),
        card(type: "trois", color: "bleu"), card(type: "trois", color: "bleu"),
        card(type: "quatre", color: "bleu"), card(type: "quatre", color: "bleu"),
        card(type: "cinq", color: "bleu"), card(type: "cinq", color: "bleu"),
        card(type: "six", color: "bleu"), card(type: "six", color: "bleu"),
        card(type: "sept", color: "bleu"), card(type: "sept", color: "bleu"),
        card(type: "huit", color: "bleu"), card(type: "huit", color: "bleu"),
        card(type: "neuf", color: "bleu"), card(type: "neuf", color: "bleu"),
        card(type: "Q", color: "bleu"), card(type: "Q", color: "bleu"),
        card(type: "S", color: "bleu"), card(type: "S", color: "bleu"),
        
        // Cartes rouges
        card(type: "zero", color: "rouge"),
        card(type: "un", color: "rouge"), card(type: "un", color: "rouge"),
        card(type: "deux", color: "rouge"), card(type: "deux", color: "rouge"),
        card(type: "trois", color: "rouge"), card(type: "trois", color: "rouge"),
        card(type: "quatre", color: "rouge"), card(type: "quatre", color: "rouge"),
        card(type: "cinq", color: "rouge"), card(type: "cinq", color: "rouge"),
        card(type: "six", color: "rouge"), card(type: "six", color: "rouge"),
        card(type: "sept", color: "rouge"), card(type: "sept", color: "rouge"),
        card(type: "huit", color: "rouge"), card(type: "huit", color: "rouge"),
        card(type: "neuf", color: "rouge"), card(type: "neuf", color: "rouge"),
        card(type: "Q", color: "rouge"), card(type: "Q", color: "rouge"),
        card(type: "S", color: "rouge"), card(type: "S", color: "rouge"),
        
        // Cartes jaunes
        card(type: "zero", color: "jaune"),
        card(type: "un", color: "jaune"), card(type: "un", color: "jaune"),
        card(type: "deux", color: "jaune"), card(type: "deux", color: "jaune"),
        card(type: "trois", color: "jaune"), card(type: "trois", color: "jaune"),
        card(type: "quatre", color: "jaune"), card(type: "quatre", color: "jaune"),
        card(type: "cinq", color: "jaune"), card(type: "cinq", color: "jaune"),
        card(type: "six", color: "jaune"), card(type: "six", color: "jaune"),
        card(type: "sept", color: "jaune"), card(type: "sept", color: "jaune"),
        card(type: "huit", color: "jaune"), card(type: "huit", color: "jaune"),
        card(type: "neuf", color: "jaune"), card(type: "neuf", color: "jaune"),
        card(type: "Q", color: "jaune"), card(type: "Q", color: "jaune"),
        card(type: "S", color: "jaune"), card(type: "S", color: "jaune"),
        
        // Cartes vertes
        card(type: "zero", color: "vert"),
        card(type: "un", color: "vert"), card(type: "un", color: "vert"),
        card(type: "deux", color: "vert"), card(type: "deux", color: "vert"),
        card(type: "trois", color: "vert"), card(type: "trois", color: "vert"),
        card(type: "quatre", color: "vert"), card(type: "quatre", color: "vert"),
        card(type: "cinq", color: "vert"), card(type: "cinq", color: "vert"),
        card(type: "six", color: "vert"), card(type: "six", color: "vert"),
        card(type: "sept", color: "vert"), card(type: "sept", color: "vert"),
        card(type: "huit", color: "vert"), card(type: "huit", color: "vert"),
        card(type: "neuf", color: "vert"), card(type: "neuf", color: "vert"),
        card(type: "Q", color: "vert"), card(type: "Q", color: "vert"),
        card(type: "S", color: "vert"), card(type: "S", color: "vert"),
        
        // Cartes noires J = +4 et K = Changement de couleur
        card(type: "J", color: "noir"), card(type: "J", color: "noir"), card(type: "J", color: "noir"), card(type: "J", color: "noir"),
        card(type: "K", color: "noir2"), card(type: "K", color: "noir2"), card(type: "K", color: "noir2"), card(type: "K", color: "noir2")
    ]
    
    var body: some View {
        ZStack{
            VStack {
                HStack{
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 23))
                        .foregroundStyle(.white)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        .onTapGesture {
                            isPlaying = false
                        }

                    Spacer()
                }
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
                                                isWinning(cards: userDeck, player: pseudo)
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
            if showingWinAlert {
                VStack(){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Gagnant de la partie")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                            Text(winnerName)
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        VStack {
                            Image(systemName: "clock.fill")
                                .font(.system(size: 25))
                                .foregroundStyle(.orange)
                                .frame(width: 60, height: 60)
                                .background(Color.orange.opacity(0.2))
                                .clipShape(Circle())
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                
                            Text(numberToText(value: calcTime()))
                                .font(.title2.bold())
                                .foregroundColor(.orange)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                            Text(pluriel(index: 3, value: calcTime()))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                        }
                        .frame(width: 140, height: 200)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        Spacer()
                        VStack {
                            Image("cards")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.orange)
                                .padding(15)
                                .frame(width: 60, height: 60)
                                .background(Color.orange.opacity(0.2))
                                .clipShape(Circle())
                                .padding(.bottom, 5)
                                
                            Text(numberToText(value: miniDrawnCards))
                                .font(.title2.bold())
                                .foregroundColor(.orange)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                            Text(pluriel(index: 2, value: miniDrawnCards))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                        }
                        .frame(width: 140, height: 200)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                    }
                    Spacer()
                    Button(action: {
                        withAnimation(.spring()) {
                            isPlaying = false
                        }
                    }) {
                        Text("Revenir à l'accueil")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 10)
                    }
                    
                }
                .padding(.init(top: 180, leading: 75, bottom: 180, trailing: 75))
//                .frame(width: 350, height: 260)
                .background(Color.black.opacity(0.7))
//                .clipShape(RoundedRectangle(cornerRadius: 40))
//                .padding(.init(top: 50, leading: 20, bottom: 50, trailing: 20))
            }
        }
        .onAppear() {
            regenerateDeck(botPlaying: true)
            regenerateDeck(botPlaying: false)
        }
        
//        .alert("\(winnerName) a gagné !", isPresented: $showingWinAlert) {
//            Button("Rejouer") {
//                resetGame()
//            }
//            Button("Retour au menu") {
//                isPlaying = false
//            }
//        } message: {
//            Text("Quelle partie endiablée !")
//        }
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
            
            //Supprime la carte piochée
            let newCard = unoCards.remove(at: randomIndex)
            
            animPiocher()
            if botPlaying {
                botDeck.append(newCard)
                played = false
            } else {
                miniDrawnCards = miniDrawnCards + 1
                userDeck.append(newCard)
            }
        } else {
            if (gamemode == 3) {
                unoCards = [
                // Cartes bleues
                card(type: "zero", color: "bleu"),
                card(type: "un", color: "bleu"), card(type: "un", color: "bleu"),
                card(type: "deux", color: "bleu"), card(type: "deux", color: "bleu"),
                card(type: "trois", color: "bleu"), card(type: "trois", color: "bleu"),
                card(type: "quatre", color: "bleu"), card(type: "quatre", color: "bleu"),
                card(type: "cinq", color: "bleu"), card(type: "cinq", color: "bleu"),
                card(type: "six", color: "bleu"), card(type: "six", color: "bleu"),
                card(type: "sept", color: "bleu"), card(type: "sept", color: "bleu"),
                card(type: "huit", color: "bleu"), card(type: "huit", color: "bleu"),
                card(type: "neuf", color: "bleu"), card(type: "neuf", color: "bleu"),
                // Cartes spéciales bleues doublées (4 de chaque au lieu de 2)
                card(type: "Q", color: "bleu"), card(type: "Q", color: "bleu"), card(type: "Q", color: "bleu"), card(type: "Q", color: "bleu"),
                card(type: "S", color: "bleu"), card(type: "S", color: "bleu"), card(type: "S", color: "bleu"), card(type: "S", color: "bleu"),
                
                // Cartes rouges
                card(type: "zero", color: "rouge"),
                card(type: "un", color: "rouge"), card(type: "un", color: "rouge"),
                card(type: "deux", color: "rouge"), card(type: "deux", color: "rouge"),
                card(type: "trois", color: "rouge"), card(type: "trois", color: "rouge"),
                card(type: "quatre", color: "rouge"), card(type: "quatre", color: "rouge"),
                card(type: "cinq", color: "rouge"), card(type: "cinq", color: "rouge"),
                card(type: "six", color: "rouge"), card(type: "six", color: "rouge"),
                card(type: "sept", color: "rouge"), card(type: "sept", color: "rouge"),
                card(type: "huit", color: "rouge"), card(type: "huit", color: "rouge"),
                card(type: "neuf", color: "rouge"), card(type: "neuf", color: "rouge"),
                // Cartes spéciales rouges doublées
                card(type: "Q", color: "rouge"), card(type: "Q", color: "rouge"), card(type: "Q", color: "rouge"), card(type: "Q", color: "rouge"),
                card(type: "S", color: "rouge"), card(type: "S", color: "rouge"), card(type: "S", color: "rouge"), card(type: "S", color: "rouge"),
                
                // Cartes jaunes
                card(type: "zero", color: "jaune"),
                card(type: "un", color: "jaune"), card(type: "un", color: "jaune"),
                card(type: "deux", color: "jaune"), card(type: "deux", color: "jaune"),
                card(type: "trois", color: "jaune"), card(type: "trois", color: "jaune"),
                card(type: "quatre", color: "jaune"), card(type: "quatre", color: "jaune"),
                card(type: "cinq", color: "jaune"), card(type: "cinq", color: "jaune"),
                card(type: "six", color: "jaune"), card(type: "six", color: "jaune"),
                card(type: "sept", color: "jaune"), card(type: "sept", color: "jaune"),
                card(type: "huit", color: "jaune"), card(type: "huit", color: "jaune"),
                card(type: "neuf", color: "jaune"), card(type: "neuf", color: "jaune"),
                // Cartes spéciales jaunes doublées
                card(type: "Q", color: "jaune"), card(type: "Q", color: "jaune"), card(type: "Q", color: "jaune"), card(type: "Q", color: "jaune"),
                card(type: "S", color: "jaune"), card(type: "S", color: "jaune"), card(type: "S", color: "jaune"), card(type: "S", color: "jaune"),
                
                // Cartes vertes
                card(type: "zero", color: "vert"),
                card(type: "un", color: "vert"), card(type: "un", color: "vert"),
                card(type: "deux", color: "vert"), card(type: "deux", color: "vert"),
                card(type: "trois", color: "vert"), card(type: "trois", color: "vert"),
                card(type: "quatre", color: "vert"), card(type: "quatre", color: "vert"),
                card(type: "cinq", color: "vert"), card(type: "cinq", color: "vert"),
                card(type: "six", color: "vert"), card(type: "six", color: "vert"),
                card(type: "sept", color: "vert"), card(type: "sept", color: "vert"),
                card(type: "huit", color: "vert"), card(type: "huit", color: "vert"),
                card(type: "neuf", color: "vert"), card(type: "neuf", color: "vert"),
                // Cartes spéciales vertes doublées
                card(type: "Q", color: "vert"), card(type: "Q", color: "vert"), card(type: "Q", color: "vert"), card(type: "Q", color: "vert"),
                card(type: "S", color: "vert"), card(type: "S", color: "vert"), card(type: "S", color: "vert"), card(type: "S", color: "vert"),
                
                // Cartes noires doublées (8 de chaque au lieu de 4)
                card(type: "J", color: "noir"), card(type: "J", color: "noir"), card(type: "J", color: "noir"), card(type: "J", color: "noir"),
                card(type: "J", color: "noir"), card(type: "J", color: "noir"), card(type: "J", color: "noir"), card(type: "J", color: "noir"),
                
                card(type: "K", color: "noir2"), card(type: "K", color: "noir2"), card(type: "K", color: "noir2"), card(type: "K", color: "noir2"),
                card(type: "K", color: "noir2"), card(type: "K", color: "noir2"), card(type: "K", color: "noir2"), card(type: "K", color: "noir2")
            ]
            } else {
                unoCards = [
                    // Cartes bleues Q = Sens interdit S = +2
                    card(type: "zero", color: "bleu"),
                    card(type: "un", color: "bleu"), card(type: "un", color: "bleu"),
                    card(type: "deux", color: "bleu"), card(type: "deux", color: "bleu"),
                    card(type: "trois", color: "bleu"), card(type: "trois", color: "bleu"),
                    card(type: "quatre", color: "bleu"), card(type: "quatre", color: "bleu"),
                    card(type: "cinq", color: "bleu"), card(type: "cinq", color: "bleu"),
                    card(type: "six", color: "bleu"), card(type: "six", color: "bleu"),
                    card(type: "sept", color: "bleu"), card(type: "sept", color: "bleu"),
                    card(type: "huit", color: "bleu"), card(type: "huit", color: "bleu"),
                    card(type: "neuf", color: "bleu"), card(type: "neuf", color: "bleu"),
                    card(type: "Q", color: "bleu"), card(type: "Q", color: "bleu"),
                    card(type: "S", color: "bleu"), card(type: "S", color: "bleu"),
                    
                    // Cartes rouges
                    card(type: "zero", color: "rouge"),
                    card(type: "un", color: "rouge"), card(type: "un", color: "rouge"),
                    card(type: "deux", color: "rouge"), card(type: "deux", color: "rouge"),
                    card(type: "trois", color: "rouge"), card(type: "trois", color: "rouge"),
                    card(type: "quatre", color: "rouge"), card(type: "quatre", color: "rouge"),
                    card(type: "cinq", color: "rouge"), card(type: "cinq", color: "rouge"),
                    card(type: "six", color: "rouge"), card(type: "six", color: "rouge"),
                    card(type: "sept", color: "rouge"), card(type: "sept", color: "rouge"),
                    card(type: "huit", color: "rouge"), card(type: "huit", color: "rouge"),
                    card(type: "neuf", color: "rouge"), card(type: "neuf", color: "rouge"),
                    card(type: "Q", color: "rouge"), card(type: "Q", color: "rouge"),
                    card(type: "S", color: "rouge"), card(type: "S", color: "rouge"),
                    
                    // Cartes jaunes
                    card(type: "zero", color: "jaune"),
                    card(type: "un", color: "jaune"), card(type: "un", color: "jaune"),
                    card(type: "deux", color: "jaune"), card(type: "deux", color: "jaune"),
                    card(type: "trois", color: "jaune"), card(type: "trois", color: "jaune"),
                    card(type: "quatre", color: "jaune"), card(type: "quatre", color: "jaune"),
                    card(type: "cinq", color: "jaune"), card(type: "cinq", color: "jaune"),
                    card(type: "six", color: "jaune"), card(type: "six", color: "jaune"),
                    card(type: "sept", color: "jaune"), card(type: "sept", color: "jaune"),
                    card(type: "huit", color: "jaune"), card(type: "huit", color: "jaune"),
                    card(type: "neuf", color: "jaune"), card(type: "neuf", color: "jaune"),
                    card(type: "Q", color: "jaune"), card(type: "Q", color: "jaune"),
                    card(type: "S", color: "jaune"), card(type: "S", color: "jaune"),
                    
                    // Cartes vertes
                    card(type: "zero", color: "vert"),
                    card(type: "un", color: "vert"), card(type: "un", color: "vert"),
                    card(type: "deux", color: "vert"), card(type: "deux", color: "vert"),
                    card(type: "trois", color: "vert"), card(type: "trois", color: "vert"),
                    card(type: "quatre", color: "vert"), card(type: "quatre", color: "vert"),
                    card(type: "cinq", color: "vert"), card(type: "cinq", color: "vert"),
                    card(type: "six", color: "vert"), card(type: "six", color: "vert"),
                    card(type: "sept", color: "vert"), card(type: "sept", color: "vert"),
                    card(type: "huit", color: "vert"), card(type: "huit", color: "vert"),
                    card(type: "neuf", color: "vert"), card(type: "neuf", color: "vert"),
                    card(type: "Q", color: "vert"), card(type: "Q", color: "vert"),
                    card(type: "S", color: "vert"), card(type: "S", color: "vert"),
                    
                    // Cartes noires J = +4 et K = Changement de couleur
                    card(type: "J", color: "noir"), card(type: "J", color: "noir"), card(type: "J", color: "noir"), card(type: "J", color: "noir"),
                    card(type: "K", color: "noir2"), card(type: "K", color: "noir2"), card(type: "K", color: "noir2"), card(type: "K", color: "noir2")
                ]
            }
        }
    }
    
    //Regénérer le deck de cartes d'un joueur
    func regenerateDeck(botPlaying: Bool = false) {
        var drawNumber: Int = 7
        
        if (gamemode == 1){
            drawNumber = 14
        } else if (gamemode == 2) {
            drawNumber = 4
        }
        
        if botPlaying {
            botDeck.removeAll()
            for _ in 1...drawNumber {
                piocher(botPlaying: true)
            }
        } else {
            userDeck.removeAll()
            for _ in 1...drawNumber {
                piocher(botPlaying: false)
            }
        }
    }
    
    //Le bot check ses cartes, joue ou pioche s'il ne peut rien jouer
    func botPlay () {
        if !showingWinAlert {
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(3))
                
                var validCards: [card] = []
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
    }
    
    //Quelqu'un gagne ?
    func isWinning(cards: [card], player: String = "bot") {
        if cards.isEmpty {
            win(winner: player)
        }
    }
    
    //Affiche le winner
    func win(winner: String = "Bot") {
        gamesPlayed += 1
        
        if (winner == pseudo) {
            victories += 1
        }
        
        minutesPlayed += calcTime()
        drawnCards = miniDrawnCards
        
        winnerName = winner
        showingWinAlert = true
    }
    
    //Calculer les minutes jouées
    func calcTime() -> Int {
        let endingGameDate = Date()
        let seconds = endingGameDate.timeIntervalSince(startingGameDate)
        let minutes = Int(seconds / 60)
        
        print("La partie a duré \(minutes) minutes")
        return minutes
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
                isWinning(cards: userDeck, player: pseudo)
                print("Tour du bot skippé !")
            } else {
                played = true
                isWinning(cards: userDeck, player: pseudo)
                print("Tour du joueur skippé !")
                botPlay()
            }
            return true
        } else if type == "S" {
            plus(number: 2, toBot: player == "user" ? true : false)
            isWinning(cards: userDeck, player: pseudo)
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
        isWinning(cards: userDeck, player: pseudo)
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
        middleCard = card(type: middleCard.type, color: newColor)
        botPlay()
    }
    
    func botChooseColor() {
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(1))
            let newCard = botDeck.randomElement()
            let newColor = newCard!.color
            isWinning(cards: userDeck, player: "bot")
            middleCard = card(type: middleCard.type, color: newColor)
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
    ContentView(isPlaying: .constant(true), gamemode: .constant(0))
}
