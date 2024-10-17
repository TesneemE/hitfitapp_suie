//
//  SuccessView.swift
//  HIITFIIT
//
//  Created by Tes Essa on 9/23/24.
//

import SwiftUI

struct SuccessView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedTab: Int
    var body: some View {
        ZStack {
            VStack{ //problem was image was too big, don't need spacing if its not
                Image(systemName:"hand.raised.fill")
                    .resizedToFill(width: 75, height: 75)
                    .font(.largeTitle)
                .foregroundColor(/*@START_MENU_TOKEN@*/.purple/*@END_MENU_TOKEN@*/)
    
                    Text("High Five!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                Text("""
                          Good job completing all four exercises!
                          Remember tomorrow's another day.
                          So eat well and get some rest.
                          """)
                        .foregroundColor(.gray)
                          .multilineTextAlignment(.center)
//                    Text("Good job completing all four exercises!")
//                        .foregroundColor(.gray)
//                    Text("Remember tomorrow's another day.")
//                        .foregroundColor(.gray)
//                    Text("So eat well and get some rest.")
//                        .foregroundColor(.gray)
            }
            VStack { //needs to be separated b/c of spacer
                Spacer()
                Button("Continue") {dismiss()
                    selectedTab = 9
                }
                    .padding()// not bottom?
            }
        }
            
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView(selectedTab: .constant(3))
            .presentationDetents([.medium, .large])
    }
}
