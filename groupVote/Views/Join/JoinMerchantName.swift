//
//  JoinMerchantName.swift
//  groupVote
//
//  Created by Alaa . on 30/07/2023.
//

import SwiftUI

struct JoinMerchantName: View {
    @State var text = ""
    var body: some View {
        VStack {
            Header()
            
            VStack {
                CustomLargeTitle(title: "Join Group Vote")
                
                CustomTextField(input: $text, label: "Name", placeholder: "Restaurant’s Name")
                
                // plus sign button
                
                Spacer()
                CustomLargeButton(title: "Create") {
                    // action
                }
                Spacer()
            }
            .padding()
        }
        .background(Color("BGGrey"))
    }
}

struct JoinMerchantName_Previews: PreviewProvider {
    static var previews: some View {
        JoinMerchantName()
    }
}
