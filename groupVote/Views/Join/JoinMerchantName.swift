//
//  JoinMerchantName.swift
//  groupVote
//
//  Created by Alaa . on 30/07/2023.
//

import SwiftUI

struct JoinMerchantName: View {
    @State var join_id = ""
    @State var text = ""
    @Binding var groupID: UUID
    @State var showWaitingRoom = false
    var body: some View {
        VStack {
            Header()
            
            VStack {
                CustomLargeTitle(title: "Join Group Vote")
                
                CustomTextField(input: $text, label: "Name", placeholder: "Restaurant’s Name")
                
                // plus sign button
                
                Spacer()
                CustomLargeButton(title: "Create") {
                    // create merchant
                    WebAPI.postMerchant(name: text, groupID: groupID) { res in
                        print(groupID)
                        print(text)
                        switch res {
                        case .success(let success):
                            print("merchant posted",success)
                            showWaitingRoom = true
                        case .failure(let failure):
                            print("failed posting merchant",failure)
                        }
                    }
                }
                .fullScreenCover(isPresented: $showWaitingRoom) {
                    WaitingForOthers(groupID: $groupID)
                }
                Spacer()
            }
            .padding()
        }
        .background(Color("BGGrey"))
        .onAppear {
//            WebAPI.joinGroup(join_id: Int(join_id) ?? 0) { res in
//                switch res {
//                case .success(let success):
//                    // get group id from here
//                    print(success)
//                case .failure(let failure):
//                    print(failure)
//                }
//            }
            // so i can post mecharnt from here
            // oorr maybe i do join group from the main page and here only post merchants?
//            WebAPI.
        }
    }
}

//struct JoinMerchantName_Previews: PreviewProvider {
//    static var previews: some View {
//        JoinMerchantName()
//    }
//}
