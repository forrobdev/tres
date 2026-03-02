//
//  MenuView.swift
//  Test2
//
//  Created by Robin Despaquis on 05/02/2026.
//

import SwiftUI

struct MenuView: View {

    @Binding var isPlaying: Bool
    @State private var selectedTab = 0
    
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
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
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
                VStack{
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
                        HStack{
                            VStack() {
                                HStack {
                                    Image("bot")
                                        .renderingMode(.template)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 35, height: 35)
                                        .foregroundStyle(.white)
                                        .padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
                                    
                                    Spacer()
                                }
                                .background(
                                    LinearGradient(
                                        colors: [.orange, .yellow],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                Text("1v1 contre une IA")
                                    .font(.title2.bold())
                                    .foregroundColor(.orange)
                                    .multilineTextAlignment(.leading)
                                
                                Text("Plongez-vous directement dans un 1v1 avec une intelligence artificielle")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                                
                            }
                            .background(Color.white)
                            .frame(width: 270, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                            .onTapGesture {
                                isPlaying = true
                            }
                        }
                    }
                    HStack {
                        Text("Parties déjantées")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                        Spacer()
                    }
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
                HStack{
                    VStack{
                        Text("Profil")
                        Text("Robin")
                    }
                }
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

func pluriel(index: Int, value: Int) -> String {
    var text: String = ""
    
    if (index == 1) {
        if (value > 1) {
            text = "parties jouées"
        } else {
            text = "partie jouée"
        }
    } else if (index == 2) {
        if (value > 1) {
            text = "cartes piochées"
        } else {
            text = "carte piochée"
        }
        
    } else if (index == 3) {
        if (value > 1) {
            text = "minutes jouées"
        } else {
            text = "minute jouée"
        }
    }
    
    return text
}

func numberToText(value: Int) -> String {
    var text: String = "\(value)"
    
    if (value < 10) {
        text = "0\(value)"
    }
    
    return text
}

func winPercent(wins: Int, gamesPlayed: Int) -> String {
    return "\(wins*100/gamesPlayed)%"
}


#Preview {
    // Le .constant(false) sert juste pour que la prévisualisation fonctionne
    MenuView(isPlaying: .constant(false))
}
