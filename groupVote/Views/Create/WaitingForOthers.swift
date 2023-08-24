//
//  WaitingForOthers.swift
//  groupVote
//
//  Created by Alaa . on 30/07/2023.
//

import SwiftUI
import RefreshableScrollView

struct WaitingForOthers: View {
    @Binding var groupID: UUID
    @State var groupJoinID = Int()
    @State var text = ""
    let pasteboard = UIPasteboard.general
    @State var stringJoin_id = ""
    @State var namesArray: [String] = []
    @State var noOfUsers = 0
    @State var showVotingPage = false
    var body: some View {
        
            VStack {
                
                Header()
                RefreshableScrollView {
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
                    if noOfUsers <= 0 {
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
                    }
                // else get users
                    else {
                        VStack {
                        ForEach(namesArray.indices) { index in
                            CustomTextField(input: $text, label: namesArray[index] + " Joined" , placeholder: "")
                        }
                        }
                        .padding(.horizontal)
                    }
                
                
                Spacer()
                // if someone joined activate
                CustomLargeButton(title: "Start") {
                    // action
                    // update close
                    WebAPI.updateGroup(groupID: groupID, tie: false, close: true, end: false) { res in
                        switch res {
                        case .success(let success):
                            print("update group",success)
                            showVotingPage = true
                        case .failure(let failure):
                            print("failed updating",failure)
                        }
                    }
                }
                .fullScreenCover(isPresented: $showVotingPage, content: {
                    Voting(groupID: groupID)
                })
                .padding()
                Spacer()
               
                }
            }
            .background(Color("BGGrey"))
            // on appear get group / merchant by ids
        // on drag get joined users
            .refreshable {
//                WebAPI.getAllGroupStuffByID(groupID: groupID) { res in
//                    switch res {
//                    case .success(let success):
//                        print("refresh")
//                        print(success)
//                    case .failure(let failure):
//                        print("refresh fail")
//                        print(failure)
//                    }
//                }
                WebAPI.getAllUsersByID(groupID: groupID) { res in
                    switch res {
                    case .success(let success):
                        noOfUsers = 0
                        namesArray = []
                        print("users",success)
                        for i in success {
                            namesArray += [i.name]
                            print("names array", namesArray)
                            if i.name.count > 1 {
                                noOfUsers += 1
                            }
                        }
                        print("no of users", noOfUsers)
                    case .failure(let failure):
                        print("failed getting users",failure)
                    }
                }
            }
            .onAppear {
                WebAPI.getGroupByID(groupID: groupID) { res in
                    switch res {
                    case .success(let success):
                        stringJoin_id = String(success.join_id)
                        print("here",success)
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
