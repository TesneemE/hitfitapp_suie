//
//  HistoryView.swift
//  HIITFIIT
//
//  Created by Tes Essa on 9/23/24.
//

import SwiftUI

struct HistoryView: View {
  @EnvironmentObject var history: HistoryStore
  @Binding var showHistory: Bool
  @State private var addMode = false
  var headerView: some View {
    HStack {
        Button {
          addMode = true
        } label: {
          Image(systemName: "plus")
        }
        .padding(.trailing)
    EditButton()
      Spacer()
      Text("History")
        .font(.title)
      Spacer()
      Button {
        showHistory.toggle()
      } label: {
        Image(systemName: "xmark.circle")
      }
      .font(.title)
    }
  }

    func dayView(day: ExerciseDay) -> some View {
      DisclosureGroup {
          BarChartDayView(day: day)
              .deleteDisabled(true)
      } label: {
        Text(day.date.formatted(as: "d MMM YYYY"))
          .font(.headline)
    } }

  func exerciseView(day: ExerciseDay) -> some View {
      ForEach(day.uniqueExercises, id: \.self) { exercise in
          Text(exercise)
              .badge(day.countExercise(exercise: exercise))
    }
  }
    

  var body: some View {
    VStack {
        Group {
          if addMode {
            Text("History")
                  .font(.title)
              } else {
            headerView }
            }
        .padding()
        List($history.exerciseDays, editActions: [.delete]) { $day in
          dayView(day: day)
        }
        if addMode {
          AddHistoryView(addMode: $addMode)
                .background(Color.primary.colorInvert()
                .shadow(color: .primary.opacity(0.5), radius: 7))
        }
    }
    .onDisappear {
      try? history.save()
    }
  }
}

struct HistoryView_Previews: PreviewProvider {
  static var history = HistoryStore(preview: true)
  static var previews: some View {
    HistoryView(showHistory: .constant(true))
      .environmentObject(history)
  }
}
