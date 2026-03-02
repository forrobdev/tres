//
//  OnboardingView.swift
//  Test2
//
//  Created by Robin Despaquis on 24/02/2026.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("pseudo") private var pseudo = "Anonyme"
    @AppStorage("onBoarded") private var onBoarded = false
    @State private var selectedTab = 0
    
    private var isPseudoValid: Bool {
        pseudo.count >= 3 && pseudo.count <= 13
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack(alignment: .leading) {
                Spacer()
                Spacer()
                Text("Bienvenue sur Tres")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                Text("Jouez au célèbre jeu de cartes, remportez des victoires, montez en niveau et gagnez des récompenses exclusives !")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                Button(action: {
                    withAnimation(.spring()) {
                        selectedTab += 1
                    }
                }) {
                    Text("Continuer")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .frame(width: 350, height: 60)
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 0))
            }
//            .frame(maxWidth: .infinity, alignment: .leading)
            .tag(0)
            .padding(.horizontal, 20)
            VStack(alignment: .leading) {
                Spacer()
                Spacer()
                Text("Les règles du jeu")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                Text("Vous commencez avec 7 cartes en main. À votre tour, jouez une carte qui correspond au chiffre ou à la couleur de celle au centre. Le premier à ne plus avoir de cartes gagne !")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                Button(action: {
                    withAnimation(.spring()) {
                        selectedTab += 1
                    }
                }) {
                    Text("Continuer")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .frame(width: 350, height: 60)
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 0))
            }
//            .frame(maxWidth: .infinity, alignment: .leading)
            .tag(1)
            .padding(.horizontal, 20)
            VStack(alignment: .leading) {
                Spacer()
                Spacer()
                Text("Avant de commencer")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                Text("Choisissez un pseudonyme et commencez à jouer dès maintenant !")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                TextField("Votre pseudo...", text: $pseudo)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(15)
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.bottom, 50)
                    .submitLabel(.done)
                    .onChange(of: pseudo) {oldValue, newValue in
                        if newValue.count > 13 {
                            pseudo = String(newValue.prefix(13))
                        }
                    }
                
                Button(action: {
                    withAnimation(.spring()) {
                        onBoarded = true
                    }
                }) {
                    Text("Continuer")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .frame(width: 350, height: 60)
                        .background(pseudo.isEmpty ? Color.gray : Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                }
                .disabled(!isPseudoValid)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 0))
            }
//            .frame(maxWidth: .infinity, alignment: .leading)
            .tag(2)
            .padding(.horizontal, 20)
        }
        .tabViewStyle(.page)
        .background(
            LinearGradient(
                colors: [.black, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }
}
