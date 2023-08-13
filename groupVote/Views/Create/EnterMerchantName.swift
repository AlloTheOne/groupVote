//
//  EnterMerchantName.swift
//  groupVote
//
//  Created by Alaa . on 30/07/2023.
//

import SwiftUI

struct EnterMerchantName: View {
    @State var text = ""
    @State var showGroup = false
    @State var groupID = UUID()
    @State var merchantID = UUID()
    var body: some View {
        VStack {
            Header()
            
            VStack {
                CustomLargeTitle(title: "Create Group Vote")
                
                CustomTextField(input: $text, label: "Name", placeholder: "Restaurant’s Name")
                
                // plus sign button
                
                Spacer()
                CustomLargeButton(title: "Create") {
                    // create group / merchant
                    WebAPI.postMerchantGroup(name: text) { res in
                        switch res {
                        case .success(let success):
                            // go to group
                            groupID = success.groupID
                            merchantID = success.merchantID
                            
                            showGroup = true
                        case .failure(let failure):
                            print("failed creating new group:", failure)
                        }
                    }
                }
                .fullScreenCover(isPresented: $showGroup) {
                    WaitingForOthers(groupID: $groupID)
                }
                
                Spacer()
            }
            .padding()
        }
        .background(Color("BGGrey"))
    }
}

struct EnterMerchantName_Previews: PreviewProvider {
    static var previews: some View {
        EnterMerchantName()
    }
}
