//
//  Auth.swift
//  groupVote
//
//  Created by Alaa . on 29/07/2023.
//

import SwiftUI

struct Auth: View {
    @State var name = String()
    @State var goToMainPage = false
    var body: some View {
        
        VStack {
           Header()
            
                
            VStack {
                
                
                CustomLargeTitle(title: "Enter Your Name So Your Friends know You")
                    .padding(.top)
                CustomTextField(input: $name, label: "Name", placeholder: "Name")
                    .padding(.top, 40)
                Spacer()
                
                CustomLargeButton(title: "Continue") {
                    // create user + token
                    WebAPI.authorize(name: name) { res in
                        switch res {
                        case .success(let success):
                            print(success)
                            goToMainPage = true
                        case .failure(let failure):
                            print(failure)
                        }
                    }
//                    WebAPI.userSignedIn()
                    
                }
                .fullScreenCover(isPresented: $goToMainPage) {
                    MainPage()
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
