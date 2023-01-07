//
//  ToDoSwiftApp.swift
//  ToDoSwift
//
//  Created by Dmitry Grigorev on 07.01.2023.
//

import SwiftUI

/**
 Used MVVM architecture
 Experimental SwiftUI App
 */

@main
struct ToDoSwiftApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
