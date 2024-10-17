//
//  TimerView.swift
//  HIITFIIT
//
//  Created by Tes Essa on 9/24/24.
//

import SwiftUI
struct CountdownView: View {
  let date: Date
  @Binding var timeRemaining: Int
  let size: Double
  var body: some View {
Text("\(timeRemaining)")  // 5
  .font(.system(size: size, design: .rounded))
  .padding()
  .onChange(of: date) { _ in  // 6 updates timeRemaining
    timeRemaining -= 1
  }
} }
struct TimerView: View {
@State private var timeRemaining: Int = 3  // 1 num of sec timer runs for each exercise
    //small for now until tested
@Binding var timerDone: Bool  // 2 startButton
let size: Double
var body: some View {
TimelineView(  // 3 changing numbers update countdown
  .animation(
    minimumInterval: 1.0,
    paused: timeRemaining <= 0)) { context in
      CountdownView(  // 4 gets date that triggered update
        date: context.date,
        timeRemaining: $timeRemaining,
        size: size)
    }
    .onChange(of: timeRemaining) { _ in
      if timeRemaining < 1 {
        timerDone = true  // 7 timeReamining=0, allows done button to be pressed
      }
} }
}
struct TimerView_Previews: PreviewProvider {
static var previews: some View {
TimerView(timerDone: .constant(false), size: 90)
}
}
