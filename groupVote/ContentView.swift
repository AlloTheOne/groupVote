//
//  ContentView.swift
//  groupVote
//
//  Created by Alaa . on 29/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State var name = ""
    var body: some View {
        
        VStack {
           Header()
            
                
            VStack {
                
                
                CustomLargeTitle(title: "Enter Your Name So Your Friends know You")
                
                CustomTextField(input: name, label: "Name", placeholder: "Name")
                Spacer()
                
                CustomLargeButton(title: "Continue") {
                    // action
                }
                
                Spacer()
            }
            .padding()
        }
        .background(Color("BGGrey"))
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
