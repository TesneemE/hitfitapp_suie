//
//  RatingView.swift
//  HIITFIIT
//
//  Created by Tes Essa on 9/23/24.
//

import SwiftUI

struct RatingView: View {
    let exerciseIndex: Int
    @AppStorage("ratings") private var ratings = ""
    @State private var rating = 0
    let maximumRating = 5
    let onColor = Color.red  // 3
    let offColor = Color.gray
    init(exerciseIndex: Int) {
        self.exerciseIndex = exerciseIndex
        let desiredLength = Exercise.exercises.count
        if ratings.count < desiredLength {
          ratings = ratings.padding(
            toLength: desiredLength,
            withPad: "0",
            startingAt: 0)
        }
      }
    fileprivate func convertRating() {
      let index = ratings.index(
        ratings.startIndex,
        offsetBy: exerciseIndex)
      let character = ratings[index]
        rating = character.wholeNumberValue ?? 0  //makes sure rating is redrawn when opened in two screens
    }
    var body: some View {
        HStack {
            ForEach(1 ..< maximumRating + 1, id: \.self) { index in
                Button(action: {
                  updateRating(index: index)
                }, label: {
                  Image(systemName: "waveform.path.ecg")
                    .foregroundColor(
                      index > rating ? offColor : onColor)
                    .font(.body)
                })
                .buttonStyle(EmbossedButtonStyle(buttonShape: .round))
                .onChange(of: ratings) { _ in
                  convertRating()
                }
                .onAppear {
                  convertRating()
                }
//                1. Your app runs onAppear(perform:) every time the view appears.
//                2. ratings is labeled as @AppStorage so its value is stored in the UserDefaults property list file. You create a String.Index to index into the string using exerciseIndex.
//                3. You extract the correct character from the string using the String.Index.
//                4. Convert the character to an integer. If the character is not an integer, the result of wholeNumberValue will be an optional value of nil. The two question marks are known as the nil coalescing operator. If the result of wholeNumberValue is nil, then use the value after the question marks — in this case, zero. You’ll learn more about optionals in the next chapter.

                //only up to index tapped is onColor
            }
        }
        .font(.largeTitle)  // makes 5 ecg images in stack large
    }
    func updateRating(index: Int) {
        rating = index
        let index = ratings.index(
            ratings.startIndex,
            offsetBy: exerciseIndex)
        ratings.replaceSubrange(index...index, with: String(rating))
    }
}

struct RatingView_Previews: PreviewProvider {
  @AppStorage("ratings") static var ratings: String?
  static var previews: some View {
      ratings = nil //removes from Preview User Defaults
    return RatingView(exerciseIndex: 0)
      .previewLayout(.sizeThatFits)
  }
}
