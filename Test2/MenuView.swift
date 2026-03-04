//
//  MenuView.swift
//  Test2
//
//  Created by Robin Despaquis on 05/02/2026.
//

import SwiftUI

struct MenuView: View {
    
    @Binding var gamemode: Int
    @Binding var isPlaying: Bool
    @State private var selectedTab = 0
    
    @AppStorage("onBoarded") private var onBoarded = false
    @AppStorage("pseudo") private var pseudo = "Anonyme"
    @AppStorage("level") private var level = 1
    @AppStorage("victories") private var victories = 0
    @AppStorage("gamesPlayed") private var gamesPlayed = 0
    @AppStorage("drawnCards") private var drawnCards = 0
    @AppStorage("minutesPlayed") private var minutesPlayed = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            Tab("Accueil", systemImage: "house", value: 0) {
                    VStack{
                        HStack {
                            ZStack {
                                Image(backgroundCard(level: level))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 110, height: 190)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                Text("\(level)")
                                    .font(.system(size: 40, weight: .bold))
                                    .foregroundColor(.white)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            HStack{
                                VStack(alignment: .leading){
                                    Text(whichHi())
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                    Text(pseudo)
                                        .font(.system(size: 40, weight: .bold))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                            }
                        }
                        Spacer()
                        HStack{
                            Text("Niveau \(level)")
                                .font(.title3.bold())
                                .foregroundColor(.white)
                            Spacer()
                            Text("\(victories)/\(level*5) Victoires")
                                .font(.callout)
                                .foregroundColor(.white)
                        }
                        ProgressView(value: Double(victories), total: Double(level*5))
                            .tint(.orange)
                            .padding()
                            .frame(width: 350, height: 30)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .clipShape(Capsule())
                        Spacer()
                        HStack {
                            Text("Statistiques")
                                .font(.title3.bold())
                                .foregroundColor(.white)
                            Spacer()
                        }
                        ScrollView(.horizontal) {
                            HStack{
                                VStack {
                                    Image(systemName: "flag.pattern.checkered.2.crossed")
                                        .font(.system(size: 23))
                                        .foregroundStyle(.orange)
                                        .frame(width: 60, height: 60)
                                        .background(Color.orange.opacity(0.2))
                                        .clipShape(Circle())
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                        
                                    Text(numberToText(value: gamesPlayed))
                                        .font(.title2.bold())
                                        .foregroundColor(.orange)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                    Text(pluriel(index: 1, value: gamesPlayed))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                }
                                .frame(width: 140, height: 200)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 40))
                                VStack {
                                    Image(systemName: "medal.star.fill")
                                        .font(.system(size: 25))
                                        .foregroundStyle(.orange)
                                        .frame(width: 60, height: 60)
                                        .background(Color.orange.opacity(0.2))
                                        .clipShape(Circle())
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                        
                                    Text(winPercent(wins: victories, gamesPlayed: gamesPlayed))
                                        .font(.title2.bold())
                                        .foregroundColor(.orange)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                    Text("de réussite")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                }
                                .frame(width: 140, height: 200)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 40))
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
                                        
                                    Text(numberToText(value: drawnCards))
                                        .font(.title2.bold())
                                        .foregroundColor(.orange)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                    Text(pluriel(index: 2, value: drawnCards))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                }
                                .frame(width: 140, height: 200)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 40))
                                VStack {
                                    Image(systemName: "clock.fill")
                                        .font(.system(size: 25))
                                        .foregroundStyle(.orange)
                                        .frame(width: 60, height: 60)
                                        .background(Color.orange.opacity(0.2))
                                        .clipShape(Circle())
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                        
                                    Text(numberToText(value: minutesPlayed))
                                        .font(.title2.bold())
                                        .foregroundColor(.orange)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                    Text(pluriel(index: 3, value: minutesPlayed))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                }
                                .frame(width: 140, height: 200)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 40))
                            }
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        }
                        .padding(EdgeInsets(top: 0, leading: -20, bottom: 0, trailing: -20))
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        LinearGradient(
                            colors: [.black, .blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .ignoresSafeArea()
                    )
            }
            
            
            Tab(value: 1) {
                VStack(spacing: 20){
                    HStack{
                        Text("Jouer")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    HStack {
                        Text("Parties classiques")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                        Spacer()
                    }
                    ScrollView(.horizontal) {
                        HStack(spacing: 20){
                            VStack(spacing: 0) {
                                VStack{
                                    HStack {
                                        Image("bot")
                                            .renderingMode(.template)
                                            .resizable()
                                            .frame(width: 45, height: 45)
                                            .foregroundStyle(.white)
                                        
                                        Spacer()
                                    }
                                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                                }
                                .background(
                                    LinearGradient(
                                        colors: [.orange, .yellow],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("1v1 contre une IA")
                                        .font(.title2.bold())
                                        .foregroundColor(.orange)
                                        .padding(EdgeInsets(top: -5, leading: 0, bottom: 0, trailing: 0))
                                    Text("Plongez-vous dans un 1v1 classique contre une intelligence artificielle")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(20)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .background(Color.white)
                            }
                            .frame(width: 290, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                            .onTapGesture {
                                gamemode = 0
                                isPlaying = true
                            }
                            VStack(spacing: 0) {
                                VStack{
                                    HStack {
                                        Image("cards")
                                            .renderingMode(.template)
                                            .resizable()
                                            .frame(width: 45, height: 45)
                                            .foregroundStyle(.white)
                                        
                                        Spacer()
                                    }
                                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                                }
                                .background(
                                    LinearGradient(
                                        colors: [Color(red: 76/255, green: 175/255, blue: 80/255), Color(red: 139/255, green: 194/255, blue: 74/255)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Main Double")
                                        .font(.title2.bold())
                                        .foregroundColor(Color(red: 76/255, green: 175/255, blue: 80/255))
                                        .padding(EdgeInsets(top: -5, leading: 0, bottom: 0, trailing: 0))
                                    Text("Commencez la partie avec 14 cartes, toujours contre une IA")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(20)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .background(Color.white)
                            }
                            .frame(width: 290, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                            .onTapGesture {
                                gamemode = 1
                                isPlaying = true
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    }
                    .padding(EdgeInsets(top: 0, leading: -20, bottom: 0, trailing: -20))
                    HStack {
                        Text("Parties déjantées")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                        Spacer()
                    }
                    ScrollView(.horizontal) {
                        HStack(spacing: 20){
                            VStack(spacing: 0) {
                                VStack{
                                    HStack {
                                        Image(systemName: "hare.fill")
                                            .font(.system(size: 35))
                                            .foregroundStyle(.white)
                                        
                                        Spacer()
                                    }
                                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                                }
                                .background(
                                    LinearGradient(
                                        colors: [Color.red, Color(red: 227/255, green: 135/255, blue: 93/255)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Partie rapide")
                                        .font(.title2.bold())
                                        .foregroundColor(.red)
                                        .padding(EdgeInsets(top: -5, leading: 0, bottom: 0, trailing: 0))
                                    Text("Commencez la partie avec seulement 4 cartes")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(20)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .background(Color.white)
                            }
                            .frame(width: 290, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                            .onTapGesture {
                                gamemode = 2
                                isPlaying = true
                            }
                            VStack(spacing: 0) {
                                VStack{
                                    HStack {
                                        Image(systemName: "bolt.fill")
                                            .font(.system(size: 35))
                                            .foregroundStyle(.white)
                                        
                                        Spacer()
                                    }
                                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                                }
                                .background(
                                    LinearGradient(
                                        colors: [Color(red: 122/255, green: 69/255, blue: 214/255), Color(red: 225/255, green: 93/255, blue: 227/255)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Bonus Boost")
                                        .font(.title2.bold())
                                        .foregroundColor(Color(red: 122/255, green: 69/255, blue: 214/255))
                                        .padding(EdgeInsets(top: -5, leading: 0, bottom: 0, trailing: 0))
                                    Text("Toutes les cartes spéciales ont 2x plus de chance d'être piochées !")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(20)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .background(Color.white)
                            }
                            .frame(width: 290, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                            .onTapGesture {
                                gamemode = 3
                                isPlaying = true
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    }
                    .padding(EdgeInsets(top: 0, leading: -20, bottom: 0, trailing: -20))
                    Spacer()
                    Spacer()
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(
                        colors: [.black, .blue],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                )
            } label: {
                Label("Jouer", systemImage: "flag.pattern.checkered.2.crossed")
            }
            Tab(value: 2) {
                VStack {
                    HStack{
                        Text("Profil")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    Spacer()
                    Button(action: {
                        withAnimation(.spring()) {
                            pseudo = "Robin"
                            level = 1
                            victories = 0
                            minutesPlayed = 0
                            gamesPlayed = 0
                            drawnCards = 0
                            onBoarded = false
                        }
                    }) {
                        Text("Supprimer les données")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .frame(width: 350, height: 60)
                            .background(Color.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 10)
                    }
                    Button(action: {
                        withAnimation(.spring()) {
                            pseudo = ""
                            onBoarded = false
                        }
                    }) {
                        Text("Modifier le pseudo")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .frame(width: 350, height: 60)
                            .background(Color.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 10)
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(
                        colors: [.black, .blue],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                )
            } label: {
                Label("Profil", systemImage: "person.crop.circle")
            }
        }

    }

}

//Personnalisation du message d'accueil en fonction de l'heure
func whichHi() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH"
    
    let currentHourString = dateFormatter.string(from: Date())
    let currentHour = Int(currentHourString) ?? 0
    
    if currentHour > 18 {
        return "Bonsoir"
    } else if currentHour > 12 {
        return "Bon après-midi"
    } else if currentHour > 6 {
        return "Bonjour"
    } else {
        return "Bonne nuit 😴"
    }
    
}

func backgroundCard(level: Int) -> String {
    var newBackground: String = ""
    
    if (level < 3) {
        newBackground = "vert"
    } else if (level < 6) {
        newBackground = "bleu"
    } else if (level < 9) {
        newBackground = "rouge"
    } else if (level < 12) {
        newBackground = "jaune"
    } else {
        newBackground = "noir2"
    }
    
    return newBackground
}

func winPercent(wins: Int, gamesPlayed: Int) -> String {
    if gamesPlayed == 0 {
        return "0%"
    } else {
        return "\(wins*100/gamesPlayed)%"
    }
}


#Preview {
    // Le .constant(false) sert juste pour que la prévisualisation fonctionne
    MenuView(gamemode: .constant(0), isPlaying: .constant(true))
}
