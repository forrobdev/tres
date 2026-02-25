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
    @AppStorage("level") private var level = 14
    @AppStorage("victories") private var victories = 45
    
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
                                HStack {
                                    Image("trois")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30)
                                    Image("trois")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30)
                                }
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
                        HStack{
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
            }
            
            
            Tab(value: 1) {
                HStack{
                    VStack{
                        Text("Jouer")
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


#Preview {
    // Le .constant(false) sert juste pour que la prévisualisation fonctionne
    MenuView(isPlaying: .constant(false))
}
