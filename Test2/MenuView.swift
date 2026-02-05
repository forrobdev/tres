//
//  MenuView.swift
//  Test2
//
//  Created by Robin Despaquis on 05/02/2026.
//

import SwiftUI

struct MenuView: View {

    @Binding var isPlaying: Bool
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
            Spacer()
            Button(action: {
                withAnimation(.spring()) {
                    isPlaying = true
                }
            }) {
                Text("JOUER")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .frame(width: 200, height: 60)
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue.ignoresSafeArea())
    }

}

#Preview {
    // Le .constant(false) sert juste pour que la prévisualisation fonctionne
    MenuView(isPlaying: .constant(false))
}
