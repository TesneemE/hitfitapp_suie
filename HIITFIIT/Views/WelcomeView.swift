//
//  WelcomeView.swift
//  HIITFIIT
//
//  Created by Tes Essa on 9/22/24.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var selectedTab: Int
    @State private var showHistory = false
    @State private var showReports = false
    var getStartedButton: some View {
      RaisedButton(buttonText: "Get Started") {
        selectedTab = 0
      }
    .padding() }
    var historyButton: some View{
        Button(
            action: {
                showHistory=true
            }, label:
                { Text("History")
                        .fontWeight(.bold)
                        .padding([.leading, .trailing], 5)
            })
        .padding(.bottom, 10)
        .buttonStyle(EmbossedButtonStyle())
    }
    
    var reportsButton: some View{
        Button(
            action: {
                showReports=true
            }, label:
                { Text("Report")
                        .fontWeight(.bold)
                        .padding([.leading, .trailing], 5)
            })
        .padding(.bottom, 10)
        .buttonStyle(EmbossedButtonStyle())
    }
    var buttonHStack: some View {
       HStack(spacing: 40) {
         historyButton
         reportsButton
       }
       .padding(10)
     }
    var body: some View {
      GeometryReader { geometry in
        VStack {
          HeaderView(
            selectedTab: $selectedTab,
            titleText: "Welcome")
          Spacer()
          // container view
          ContainerView {
            ViewThatFits {
              VStack {
                WelcomeView.images
                WelcomeView.welcomeText
                getStartedButton
                Spacer()
                buttonHStack
              }
              VStack {
                WelcomeView.welcomeText
                getStartedButton
                Spacer()
                buttonHStack
              }
            }
          }
          .frame(height: geometry.size.height * 0.8)
        }
        .sheet(isPresented: $showHistory) {
          HistoryView(showHistory: $showHistory)
        }
        .sheet(isPresented: $showReports) {
          BarChartWeekView()
        }
      }
    }
        
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
//        WelcomeView()
        WelcomeView(selectedTab: .constant(9))
    }
}
