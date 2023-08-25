//
//  TodoListApp.swift
//  TodoList
//
//  Created by Panagiotis Tsapanidis on 2023-08-25.
//

import SwiftUI

@main
struct TodoListApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
        }
    }
}
