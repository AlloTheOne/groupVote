//
//  CustomTextField.swift
//  groupVote
//
//  Created by Alaa . on 30/07/2023.
//

import SwiftUI

struct CustomTextField: View {
    @State var input = ""
    @State var label = ""
    @State var placeholder = ""
    var body: some View {
        LabeledContent {
            TextField(placeholder, text: $input)
            
        } label: {
            Text(label)
                .padding(.horizontal)
        }
        .padding()
        .background(Color("TextFColor"))
        .cornerRadius(10)
        .padding(.vertical)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField()
    }
}