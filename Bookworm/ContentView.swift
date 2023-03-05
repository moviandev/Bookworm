//
//  ContentView.swift
//  Bookworm
//
//  Created by Matheus Viana on 05/03/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        NavigationView {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
