//
//  WaitingForOthers.swift
//  groupVote
//
//  Created by Alaa . on 30/07/2023.
//

import SwiftUI

struct WaitingForOthers: View {
    @State var groupJoinID = "6789456"
    let pasteboard = UIPasteboard.general
    var body: some View {
        VStack {
            Header()
            
            
            CustomLargeTitle(title: " Group Vote")
            
            CustomLargeTitle(title: " Group ID:")
            
            HStack {
                CustomTextField(input: groupJoinID, label: "", placeholder: "")
                   
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
                Image(systemName: "arrow.counterclockwise")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 76, height: 76)
                CustomLargeTitle(title: "Waiting For Others To Join")
                    .scaledToFit()
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
            }
            .padding()
            
            
            
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

struct WaitingForOthers_Previews: PreviewProvider {
    static var previews: some View {
        WaitingForOthers()
    }
}
