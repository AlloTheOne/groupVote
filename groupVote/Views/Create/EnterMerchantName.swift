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
//                            print("success.groupID:", success.group)
//                            print("success:", success)
//                            guard let groupID = success.groupID else {
//                                print("empty")
//                                return
//                            }
                            if success.group.id != nil {
                                self.groupID = success.group.id!
                                print("inside if")
                            }
//                            else {
//                                return
//                            }
                            showGroup = true
//                            guard let merchantID = success.merchantID else {
//                                return
//                            }
                            
                            
                            print("did i come here?")
                        case .failure(let failure):
                            print("failed creating new group:", failure)
                        }
                    }
                    WebAPI.getGroupByID(groupID: groupID) { res in
                        switch res {
                        case .success(let success):
                            print(success.id)
                        case .failure(let failure):
                            print("failed calling group",failure)
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
