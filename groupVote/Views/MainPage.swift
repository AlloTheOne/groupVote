//
//  MainPage.swift
//  groupVote
//
//  Created by Alaa . on 30/07/2023.
//

import SwiftUI

struct MainPage: View {
    @State var join_id = ""
    var body: some View {
        VStack {
            Header(name: "Alaa")
            
            Spacer()
            
            CustomLargeTitle(title: "Create Group Vote")
            
            Button {
                // action
            } label: {
                Image(systemName: "arrow.right.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 74, height: 74)
                    .foregroundColor(.gray)
                    .padding()
            }
            Spacer()
            CustomLargeTitle(title: "Or Join One:")
            
            VStack {
                CustomTextField(input: join_id, label: "", placeholder: "Enter Group ID")
                
                CustomLargeButton(title: "Join") {
                    // action
                }
            }
            .padding()
            Spacer()
        }
        .background(Color("BGGrey"))
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
