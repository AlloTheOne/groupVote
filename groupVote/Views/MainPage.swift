//
//  MainPage.swift
//  groupVote
//
//  Created by Alaa . on 30/07/2023.
//

import SwiftUI

struct MainPage: View {
    @State var join_id = ""
    @State var showEnterMerchantName = false
    @State var showJoinForm = false
    var body: some View {
        VStack {
            Header(name: "Alaa")
            
            Spacer()
            
            CustomLargeTitle(title: "Create Group Vote")
            
            Button {
                // show merchant form
                showEnterMerchantName = true
            } label: {
                Image(systemName: "arrow.right.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 74, height: 74)
                    .foregroundColor(.gray)
                    .padding()
            }
            .fullScreenCover(isPresented: $showEnterMerchantName) {
                EnterMerchantName()
            }
            Spacer()
            CustomLargeTitle(title: "Or Join One:")
            
            VStack {
                CustomTextField(input: $join_id, label: "", placeholder: "Enter Group ID")
                
                CustomLargeButton(title: "Join") {
                    // show join merchant form
                    // slide in join id
                    
                    WebAPI.joinGroup(join_id: Int(join_id) ?? 0) { res in
                        switch res {
                        case .success(let success):
                            print(success)
                        case .failure(let failure):
                            print(failure)
                        }
                    }
                    
                    showJoinForm = true
                    
                }
                .fullScreenCover(isPresented: $showJoinForm) {
                    JoinMerchantName(join_id: join_id)
                }
            }
            .padding()
            Spacer()
        }
        .background(Color("BGGrey"))
        .onAppear {
            
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
