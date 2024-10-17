//
//  HistoryStore.swift
//  HIITFIIT
//
//  Created by Tes Essa on 9/23/24.
//

import Foundation

struct ExerciseDay: Identifiable {
  let id = UUID()
  let date: Date
  var exercises: [String] = []
    var uniqueExercises: [String] {
      Array(Set(exercises)).sorted(by: <) //sorted alphabetically
    }
    func countExercise(exercise: String)-> Int{
        exercises.filter{$0 == exercise}.count
    }
}
class HistoryStore: ObservableObject {
  @Published var exerciseDays: [ExerciseDay] = []
  @Published var loadingError = false

  enum FileError: Error {
    case loadFailure
    case saveFailure
  }

  init(preview: Bool = false) {
    do {
      try load()
    } catch {
      loadingError = true
    }
    #if DEBUG
    if preview {
      createDevData()
    } else {
      if exerciseDays.isEmpty {
        copyHistoryTestData()
        try? load()
      }
    }
    #endif
  }

  var dataURL: URL {
    URL.documentsDirectory
      .appendingPathComponent("history.plist")
  }

  func load() throws {
    guard let data = try? Data(contentsOf: dataURL) else {
      return
    }
    do {
      let plistData = try PropertyListSerialization.propertyList(
        from: data,
        options: [],
        format: nil)
      let convertedPlistData = plistData as? [[Any]] ?? []
      exerciseDays = convertedPlistData.map {
        ExerciseDay(
          date: $0[1] as? Date ?? Date(),
          exercises: $0[2] as? [String] ?? [])
      }
    } catch {
      throw FileError.loadFailure
    }
  }

  func save() throws {
    let plistData = exerciseDays.map {
      [$0.id.uuidString, $0.date, $0.exercises]
    }
    do {
      let data = try PropertyListSerialization.data(
        fromPropertyList: plistData,
        format: .binary,
        options: .zero)
      try data.write(to: dataURL, options: .atomic)
    } catch {
      throw FileError.saveFailure
    }
  }

  func addDoneExercise(_ exerciseName: String) {
    let today = Date()
    if let firstDate = exerciseDays.first?.date,
      today.isSameDay(as: firstDate) {
      exerciseDays[0].exercises.append(exerciseName)
    } else {
      exerciseDays.insert(
        ExerciseDay(date: today, exercises: [exerciseName]),
        at: 0)
    }
    do {
      try save()
    } catch {
      fatalError(error.localizedDescription)
    }
  }
    func addExercise(date: Date, exerciseName: String) {
      let exerciseDay = ExerciseDay(date: date, exercises:
    [exerciseName])
    // 1
      if let index = exerciseDays.firstIndex(
        where: { $0.date.yearMonthDay <= date.yearMonthDay }) {
        // 2
        if date.isSameDay(as: exerciseDays[index].date) {
          exerciseDays[index].exercises.append(exerciseName)
    // 3
    } else {
          exerciseDays.insert(exerciseDay, at: index)
        }
    // 4
    } else {
        exerciseDays.append(exerciseDay)
      }
    // 5
    try? save() }
}


//class HistoryStore: ObservableObject {
//    @Published var exerciseDays: [ExerciseDay] = []  //publishes to any subscriber
//    @Published var loadingError = false
//    var dataURL: URL {
//      URL.documentsDirectory
//        .appendingPathComponent("history.plist")
//    }
//    init() {
//      #if DEBUG
////      createDevData()
//      #endif
//        print("Initializing HistoryStore")
//        do {
//          try load()
//        } catch {
//          print(loadingError = true)
//        }
//    }
//
//    enum FileError: Error {
//        case loadFailure
//        case saveFailure
//    }
//    func load() throws {
//        guard let data = try? Data(contentsOf: dataURL) else {
//        return
//        }
//        do {
//    // 1
////        let data = try Data(contentsOf: dataURL)
//        // 2
//        let plistData = try PropertyListSerialization.propertyList(
//          from: data,
//          options: [],
//          format: nil)
//    // 3
//        let convertedPlistData = plistData as? [[Any]] ?? []
//        // 4
//        exerciseDays = convertedPlistData.map {
//          ExerciseDay(
//            date: $0[1] as? Date ?? Date(),
//            exercises: $0[2] as? [String] ?? [])
//    }
//    } catch {
//        throw FileError.loadFailure
//      }
////        1. Read the data file into a byte buffer. This buffer is in the property list format. If history.plist doesn’t exist on disk, Data(contentsOf:) will throw an error. Throwing an error is not correct in this case, as there will be no history when your user first launches your app. You’ll fix this error at the end of this chapter.
////        2. Convert the property list format into a format that your app can read.
////        3. When you serialize from a property list, the result is always of type Any. To cast to another type, you use the type cast operator as?. This will return nil if the type cast fails. Because you wrote history.plist yourself, you can be pretty sure about the contents, and you can cast plistData from type Any to the [[Any]] type that you serialized out to file. If for some reason history.plist isn’t of type [[Any]], you provide a fall-back of an empty array using the nil coalescing operator ??.
////        4. With convertedPlistData cast to the expected type of [[Any]], you use map(_:) to convert each element of [Any] back to ExerciseDay. You also ensure that the data is of the expected type and provide fall-backs if necessary.
//    }
//    func save() throws {
////      var plistData: [[Any]] = []
////      for exerciseDay in exerciseDays {
////        plistData.append(([
////          exerciseDay.id.uuidString,
////          exerciseDay.date,
////          exerciseDay.exercises
////    ])) }
//       let plistData = exerciseDays.map {
//           [$0.id.uuidString, $0.date, $0.exercises]
//         }
//        do { // 1
//            let data = try PropertyListSerialization.data(
//               fromPropertyList: plistData,
//               format: .binary,
//               options: .zero)
//           // 2
//             try data.write(to: dataURL, options: .atomic)
//           } catch {
//           // 3
//             throw FileError.saveFailure
//           }
////        1. You convert your history data to a serialized property list format. The result is a
////        Data type, which is a buffer of bytes.
////        2. You write to disk using the URL you formatted earlier.
////        3. The conversion and writing may throw errors, which you catch by throwing an error.
//
//    }
//    func addDoneExercise(_ exerciseName: String) { //call this in doneButton
//      let today = Date()
//        if let firstDate = exerciseDays.first?.date,
//          today.isSameDay(as: firstDate) { // 1 if let means can accept nil , first? means can be nil, stacking conditionals
//        print("Adding \(exerciseName)")
//        exerciseDays[0].exercises.append(exerciseName) //same day add to current day
//      } else {
//        exerciseDays.insert( // 2
//          ExerciseDay(date: today, exercises: [exerciseName]),  //new day
//          at: 0)
//    }
//        print("History: ", exerciseDays)
//        do {
//          try save()
//        } catch {
//          fatalError(error.localizedDescription)
//        }
//    }
//}
