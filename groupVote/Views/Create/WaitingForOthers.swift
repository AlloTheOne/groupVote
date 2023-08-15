//
//  WaitingForOthers.swift
//  groupVote
//
//  Created by Alaa . on 30/07/2023.
//

import SwiftUI

struct WaitingForOthers: View {
    @Binding var groupID: UUID
    @State var groupJoinID = Int()
    @State var text = ""
    let pasteboard = UIPasteboard.general
    @State var stringJoin_id = ""
    var body: some View {
        VStack {
            Header()
            
            
            CustomLargeTitle(title: " Group Vote")
            
            CustomLargeTitle(title: " Group ID:")
            
            HStack {
                CustomTextField(input: $stringJoin_id, label: "", placeholder: "")
                   
                // copy button
                Button {
                    pasteboard.string = stringJoin_id
                } label: {
                    Image(systemName: "doc.on.clipboard.fill")
                                        .foregroundColor(.white)
                }
                    
            }
            .padding(.horizontal)
            Divider()
                .padding()
            // if no users this
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
            // else get users
            
            
            
            Spacer()
            // if someone joined activate 
            CustomLargeButton(title: "Start") {
                // action
            }
            .padding()
            Spacer()
        }
        .background(Color("BGGrey"))
        // on appear get group / merchant by ids
        .onAppear {
            WebAPI.getGroupByID(groupID: groupID) { res in
                switch res {
                case .success(let success):
                    stringJoin_id = String(success.join_id)
                    print(success)
                case .failure(let failure):
                    print("failed getting group:", failure)
                }
            }
        }
    }
}

//struct WaitingForOthers_Previews: PreviewProvider {
//    static var previews: some View {
//        WaitingForOthers()
//    }
//}
