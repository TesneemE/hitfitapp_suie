//
//  BarChartDayView.swift
//  HIITFIIT
//
//  Created by Tes Essa on 10/2/24.
//

import SwiftUI
import Charts
struct BarChartDayView: View {
    let day: ExerciseDay
    var body: some View {
        Chart{
            ForEach(Exercise.names, id:\.self){
                name in
                BarMark(x: .value(name, name), y: .value("Total Count",day.countExercise(exercise: name)))
                    .foregroundStyle(Color("history-bar"))
            }
            RuleMark(y: .value("Exercise", 1))
                .foregroundStyle(.red)
        }
        .padding()
    }
}

struct BarChartDayView_Previews: PreviewProvider {
    static var history=HistoryStore(preview: true)
    static var previews: some View {
        BarChartDayView(day:history.exerciseDays[0])
            .environmentObject(history) //first date in history array
    }
}
