//
//  Header.swift
//  groupVote
//
//  Created by Alaa . on 29/07/2023.
//

import SwiftUI

struct Header: View {
    @State var name = ""
    var body: some View {
        VStack {
            HStack {
                Text(name)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Spacer()
                Image(systemName: "gear") // fix the size
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .foregroundColor(.white)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .background(Color("HeaderGrey"))
//            Spacer()
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
