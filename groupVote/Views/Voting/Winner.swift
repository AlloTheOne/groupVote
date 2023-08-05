//
//  Winner.swift
//  groupVote
//
//  Created by Alaa . on 01/08/2023.
//

import SwiftUI

struct Winner: View {
    var body: some View {
        NavigationView {
            
            
            VStack {
                Spacer()
                CustomLargeTitle(title: "McDonald's")
                
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
//        .padding()
    }
}

struct Winner_Previews: PreviewProvider {
    static var previews: some View {
        Winner()
    }
}
