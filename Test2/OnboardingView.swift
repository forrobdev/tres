//
//  OnboardingView.swift
//  Test2
//
//  Created by Robin Despaquis on 24/02/2026.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onBoarded") private var onBoarded = false
    @State private var selectedTab = 0
    
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
                Text("Jouez au célèbre jeu de cartes contre un bot de n'importe où !")
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
            VStack(alignment: .leading) {
                Spacer()
                Spacer()
                Text("Bienvenue sur Tres")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                Text("Jouez au célèbre jeu de cartes contre un bot de n'importe où !")
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
            VStack(alignment: .leading) {
                Spacer()
                Spacer()
                Text("Bienvenue sur Tres")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                Text("Jouez au célèbre jeu de cartes contre un bot de n'importe où !")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                Button(action: {
                    withAnimation(.spring()) {
                        onBoarded = true
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
            .tag(2)
        }
        .tabViewStyle(.page)
        .background(Color.blue.ignoresSafeArea())
    }
}
