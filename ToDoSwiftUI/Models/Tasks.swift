//
//  Tasks.swift
//  ToDoSwiftUI
//
//  Created by Alexandre Legros on 28/03/2022.
//

import Foundation

struct Tasks: Identifiable {
    var id = UUID()
    let taskName: String
    var createdDate = Date()
    var isDone: Bool = false

    func dateFormated(dateOfTask: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM YYYY à HH:mm:ss"
        return dateFormatter.string(from: dateOfTask)
    }

}
