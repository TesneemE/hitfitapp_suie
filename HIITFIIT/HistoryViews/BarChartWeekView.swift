//
//  BarChartWeekView.swift
//  HIITFIIT
//
//  Created by Tes Essa on 10/2/24.
//
import SwiftUI
import Charts

struct BarChartWeekView: View {
  @EnvironmentObject var history: HistoryStore
  @State private var weekData: [ExerciseDay] = []
  @State private var isBarChart = true
  var body: some View {
    VStack {
      Text("History for Last Week")
        .font(.title)
        .padding()
      if isBarChart {
        Chart(weekData) { day in
          ForEach(Exercise.names, id: \.self) { name in
            BarMark(
              x: .value("Date", day.date, unit: .day),
              y: .value("Total Count", day.countExercise(exercise: name)))
            .foregroundStyle(by: .value("Exercise", name))
          }
        }
        .chartForegroundStyleScale([
          "Burpee": Color("chart-burpee"),
          "Squat": Color("chart-squat"),
          "Step Up": Color("chart-step-up"),
          "Sun Salute": Color("chart-sun-salute")
        ])
        .padding()
      } else {
        Chart(weekData) { day in
          LineMark(
          x: .value("Date", day.date, unit: .day),
          y: .value("Total Count", day.exercises.count))
          .symbol(.circle)
          .interpolationMethod(.catmullRom)
        }
        .padding()
      }
      Toggle("Bar Chart", isOn: $isBarChart)
        .padding()
    }
    .onAppear {
      let firstDate = history.exerciseDays.first?.date ?? Date()
      let dates = firstDate.previousSevenDays
      weekData = dates.map { date in
        // swiftlint:disable:next trailing_closure
        history.exerciseDays.first(
          where: { $0.date.isSameDay(as: date) })
        ?? ExerciseDay(date: date)
      }
    }
  }
}

struct BarChartWeekView_Previews: PreviewProvider {
  static var previews: some View {
      BarChartWeekView()
      .environmentObject(HistoryStore(preview: true))
  }
}
