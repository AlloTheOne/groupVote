//
//  Voting.swift
//  groupVote
//
//  Created by Alaa . on 01/08/2023.
//

import SwiftUI

struct Voting: View {
    var body: some View {
        VStack {
            //
            HStack {
//                Text("1/5")
//                    .foregroundColor(.white)
                CustomLargeTitle(title: "1/5")
                    .foregroundColor(Color("lightGreen"))
                
                Spacer()
//                Text("00:50")
//                    .foregroundColor(.white)
                CustomLargeTitle(title: "00:50")
                
            }
            .padding()
            Spacer()
            
            CustomLargeTitle(title: "MccDonald's")
            Spacer() //use padding instead
            HStack{
                Image(systemName: "xmark.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("lightRed"))
                    .frame(width: 76, height: 76)
                Spacer()
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("lightGreen"))
                    .frame(width: 76, height: 76)
            }
            .padding()
            Spacer()
        }
        .padding()
        .background(Color("BGGrey"))
    }
}

struct Voting_Previews: PreviewProvider {
    static var previews: some View {
        Voting()
    }
}
