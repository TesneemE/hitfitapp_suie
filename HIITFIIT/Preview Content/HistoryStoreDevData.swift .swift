//
//  HistoryStoreDevData.swift .swift
//  HIITFIIT
//
//  Created by Tes Essa on 9/23/24.
//

import Foundation

extension HistoryStore {
  func createDevData() {
    // Development data
    exerciseDays = [
      ExerciseDay(
        date: Date().addingTimeInterval(-86400),
        exercises: [
          Exercise.exercises[0].exerciseName,
          Exercise.exercises[1].exerciseName,
          Exercise.exercises[2].exerciseName,
          Exercise.exercises[0].exerciseName,
          Exercise.exercises[0].exerciseName
        ]),
      ExerciseDay(
        date: Date().addingTimeInterval(-86400 * 3),
        exercises: [
          Exercise.exercises[2].exerciseName,
          Exercise.exercises[2].exerciseName,
          Exercise.exercises[3].exerciseName
        ]),
      ExerciseDay(
        date: Date().addingTimeInterval(-86400 * 4),
        exercises: [
          Exercise.exercises[1].exerciseName,
          Exercise.exercises[1].exerciseName
        ]),
      ExerciseDay(
        date: Date().addingTimeInterval(-86400 * 5),
        exercises: [
          Exercise.exercises[0].exerciseName,
          Exercise.exercises[1].exerciseName,
          Exercise.exercises[3].exerciseName,
          Exercise.exercises[3].exerciseName
        ])
    ]
  }

  // copy history.plist to Documents directory
  func copyHistoryTestData() {
    let filename = "history.plist"
    if let resourceURL = Bundle.main.resourceURL {
      let sourceURL = resourceURL.appending(component: filename)
      let documentsURL = URL.documentsDirectory
      let destinationURL = documentsURL.appending(component: filename)
      do {
        try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
      } catch {
        print("Failed to copy", filename)
      }
      print("Sample History data copied to Documents directory")
    }
  }

  // This method creates random test data.
  func createHistoryTestData() {
    print("Data construction started")
    exerciseDays = []
    let numberOfDays: Int = 720
    for day in 0..<numberOfDays {
      guard let date =
        Calendar.current.date(byAdding: .day, value: -day, to: Date())
      else {
        continue
      }
      var exerciseNames: [String] = []
      // repeat a random number of times (max 6) (max 24 exercises)
      // this will result in eg
      // [Squat, Step Up, Burpee, Step Up, Sun Salute, Step Up, Sun Salute]
      for _ in 0..<Int.random(in: 0...5) {
        for exercise in Exercise.exercises {
          if Bool.random() {
            exerciseNames.append(exercise.exerciseName)
          }
        }
      }
      if !exerciseNames.isEmpty {
        exerciseDays.append(ExerciseDay(date: date, exercises: exerciseNames))
      }
    }
    try? save()
    print("Data construction completed")
  }
}
