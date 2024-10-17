//
//  ContentView.swift
//  HIITFIIT
//
//  Created by Tes Essa on 9/22/24.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("selectedTab") private var selectedTab = 9 //scene is kept the same even when app is exited plus rebuild w/ scene storage
//    var body: some View {
//        TabView{
//            WelcomeView()  //first page
//            ForEach(0 ..< 4) { number in
//              ExerciseView(index: number)
//            }  //for each num in rang of array, show ExerciseView(index: num)
//        }
//        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))  //don't show bottom three buttons for tabs
//    }
    var body: some View {
        ZStack {
            GradientBackground()
            TabView(selection: $selectedTab) {
            WelcomeView(selectedTab: $selectedTab)  // 1
              .tag(9)  // 2
            ForEach(Exercise.exercises.indices, id: \.self) { index in
              ExerciseView(selectedTab: $selectedTab, index: index)
                .tag(index)  // 3
            }
        }
            
    //      .environmentObject(HistoryStore())
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}  //preview

