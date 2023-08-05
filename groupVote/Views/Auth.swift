//
//  Auth.swift
//  groupVote
//
//  Created by Alaa . on 29/07/2023.
//

import SwiftUI

struct Auth: View {
    @State var name = ""
    var body: some View {
        
        VStack {
           Header()
            
                
            VStack {
                
                
                CustomLargeTitle(title: "Enter Your Name So Your Friends know You")
                    .padding(.top)
                CustomTextField(input: name, label: "Name", placeholder: "Name")
                    .padding(.top, 40)
                Spacer()
                
                CustomLargeButton(title: "Continue") {
                    // action
                }
                
                Spacer()
            }
            .padding()
        }
        .background(Color("BGGrey"))
//        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Auth()
    }
}
