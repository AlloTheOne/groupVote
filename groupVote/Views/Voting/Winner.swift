//
//  Winner.swift
//  groupVote
//
//  Created by Alaa . on 01/08/2023.
//

import SwiftUI

struct Winner: View {
    @State var winnerMer = ""
    @State var groupID = UUID()
    var body: some View {
        NavigationView {
            
            
            VStack {
                Spacer()
                Text(winnerMer)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding()
                
                CustomLargeTitle(title: "Won!")
                Spacer()
                HStack {

                    CustomLargeButton(title: "Again") {
                        //
                    }
                    CustomLargeButton(title: "Exit") {
                        //
                    }
                
                }
                Spacer()
            }
            .padding()
            .background(Color("BGGrey"))
//            .scaledToFill()
        }
        .onAppear {
            WebAPI.getWinnerMerchant(groupID: groupID) { res in
                switch res {
                case .success(let success):
                    print("winner merchant", success)
                    winnerMer = success.name
                case .failure(let failure):
                    print("failed getting winner merchant", failure)
                }
            }
        }
//        .padding()
    }
}

struct Winner_Previews: PreviewProvider {
    static var previews: some View {
        Winner()
    }
}
