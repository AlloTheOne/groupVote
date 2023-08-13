//
//  groupVoteApp.swift
//  groupVote
//
//  Created by Alaa . on 29/07/2023.
//

import SwiftUI

@main
struct groupVoteApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            WaitingForOthers()
            // if actoken != nil
//
            if WebAPI.userSignedIn() {
                MainPage()
//                    .onAppear {
//                        print("main",WebAPI.accessToken)
//                    }
            } else {
                Auth()
//                    .onAppear {
//                        print("authh",WebAPI.accessToken)
//                    }
            }
            // mainpage
                
        }
    }
}
