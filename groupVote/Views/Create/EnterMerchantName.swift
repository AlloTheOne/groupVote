//
//  EnterMerchantName.swift
//  groupVote
//
//  Created by Alaa . on 30/07/2023.
//

import SwiftUI

struct EnterMerchantName: View {
    var body: some View {
        VStack {
            Header()
            
            VStack {
                CustomLargeTitle(title: "Create Group Vote")
                
                CustomTextField(input: "", label: "Name", placeholder: "Restaurant’s Name")
                
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

struct EnterMerchantName_Previews: PreviewProvider {
    static var previews: some View {
        EnterMerchantName()
    }
}
