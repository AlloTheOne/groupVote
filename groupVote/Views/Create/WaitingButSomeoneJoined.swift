//
//  WaitingButSomeoneJoined.swift
//  groupVote
//
//  Created by Alaa . on 01/08/2023.
//

import SwiftUI

struct WaitingButSomeoneJoined: View {
    @State var groupJoinID = "6789456"
    @State var text = ""
    let pasteboard = UIPasteboard.general
    var body: some View {
        VStack {
            Header()
            
            CustomLargeTitle(title: " Group Vote")
            
            CustomLargeTitle(title: " Group ID:")
            
            HStack {
                CustomTextField(input: $groupJoinID, label: "", placeholder: "")
                   
                // copy button
                Button {
                    pasteboard.string = groupJoinID
                } label: {
                    Image(systemName: "doc.on.clipboard.fill")
                                        .foregroundColor(.white)
                }
                    
            }
            .padding(.horizontal)
            Divider()
                .padding()
            VStack {
                CustomTextField(input: $text, label: "", placeholder: "")
                CustomTextField(input: $text, label: "", placeholder: "")
                
            }
            .padding(.horizontal)
            
            
            
            Spacer()
            CustomLargeButton(title: "Start") {
                // action
            }
            .padding()
            Spacer()
        }
        .background(Color("BGGrey"))
    }
}

struct WaitingButSomeoneJoined_Previews: PreviewProvider {
    static var previews: some View {
        WaitingButSomeoneJoined()
    }
}
