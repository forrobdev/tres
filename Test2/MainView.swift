//
//  MainView.swift
//  Test2
//
//  Created by Robin Despaquis on 05/02/2026.
//

import SwiftUI

struct MainView: View {
    @State private var isPlaying = false
    
    var body: some View {
        Group {
            if isPlaying {
                ContentView(isPlaying: .constant(true))
                    .transition(.move(edge: .trailing))
            } else {
                MenuView(isPlaying: $isPlaying)
                    .transition(.move(edge: .leading))
            }
        }
    }
}
