//
//  HIITFIITApp.swift
//  HIITFIIT
//
//  Created by Tes Essa on 9/22/24.
//

import SwiftUI

@main

struct HIITFIITApp: App {
    @StateObject private var historyStore = HistoryStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                  print(URL.documentsDirectory) //You print the URL of the app’s Documents directory to the console
                }
                .environmentObject(historyStore) //makes history available again
                .alert(isPresented: $historyStore.loadingError) {
                  Alert(
                    title: Text("History"),
                    message: Text(
                      """
                      Unfortunately we can't load your past history.
                      Email support:
                        support@xyz.com
                      """)) //if history won't load
                }
//                .buttonStyle(.raised)
        }
    }
}
