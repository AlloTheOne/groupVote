//
//  Voting.swift
//  groupVote
//
//  Created by Alaa . on 01/08/2023.
//

import SwiftUI



struct Voting: View {
    @State var namesArray: [String] = [] // this used to be for users' names
    @State var timer = 60
    @State var noOfMer = 0
    @State var currentMer = 0
    @State var groupID = UUID()
    @State var merNames: [String] = []
    @State var merID: [UUID?] = []
    @State var currentMerName = ""
    @State var showWinner = false
    
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
            //   1              2
            if currentMer < noOfMer {
                //                ForEach(0...noOfMer-1, id: \.self) { index in
                
                //                    CustomLargeTitle(title: "\(currentMerName)")
                Text(currentMerName)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding()
                //                }
                
                
                Spacer() //use padding instead
                HStack{
                    // votes = 0
                    Button {
                        //something
                        
                        //then + current merchant +1
                        //                    currentMer += 1
                        if noOfMer - 1 > currentMer {
                            currentMerName = merNames[currentMer + 1]
                        } else {
                            getWinnerMer(groupID: groupID)
                            showWinner = true
                        }
                    } label: {
                        //
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("lightRed"))
                            .frame(width: 76, height: 76)
                    }
                    .fullScreenCover(isPresented: $showWinner) {
                        Winner(groupID: groupID)
                    }
                    Spacer()
                    // votes + 1
                    Button {
                        //something
                        WebAPI.addVote(merchantID: merID[currentMer]!) { res in
                            switch res {
                            case .success(let success):
                                print(success)
                                //                            text += 1
                                if noOfMer - 1 > currentMer {
                                    currentMer += 1
                                    currentMerName = merNames[currentMer]
                                } else {
                                    getWinnerMer(groupID: groupID)
                                    showWinner = true
                                }
                                print(currentMer)
                                
                                print("currennt",currentMerName)
                            case .failure(let failure):
                                print(failure)
                            }
                        }
                        //then + current merchant +1
                        
                    } label: {
                        
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("lightGreen"))
                            .frame(width: 76, height: 76)
                    }
                    .fullScreenCover(isPresented: $showWinner) {
                        Winner(groupID: groupID)
                    }
                }
                //                .onTapGesture {
                //                    //
                //                }
                
                .padding()
            }
//            else {
//                // get winner merchant
//
//            }
            Spacer()
        }
        .padding()
        .background(Color("BGGrey"))
        .onAppear {
            // get all merchants?
            WebAPI.getAllGroupStuffByID(groupID: groupID) { res in
                switch res {
                case .success(let success):
                    print("SSSSUC",success)
                    for i in success {
//                        print("mer name",i.merchant.name)
//                        print("merCh",i.merchant)
//                        print("iiiii",i)
                        merNames += [i.merchant.name]
                        merID += [i.merchant.id]
                        noOfMer += 1
                    }
                    currentMerName = merNames[currentMer]
                    print("no of mer", noOfMer)
                    print("mer ids", merID)
                    print("mer names", merNames)
                    print(merNames.count)
                    print(currentMer)
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}

struct Voting_Previews: PreviewProvider {
    static var previews: some View {
        Voting()
    }
}


func getWinnerMer(groupID: UUID) {
    WebAPI.getWinnerMerchant(groupID: groupID) { res in
        switch res {
        case .success(let success):
            print("winner merchant", success)
            
        case .failure(let failure):
            print("failed getting winner merchant", failure)
        }
    }
}
