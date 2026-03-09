//
//  ContentView.swift
//  Task Manager
//
//  Created by Manish Ahire on 09/03/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var taskManager = TaskManager()
    @State private var newTaskTitle = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Add a new task", text: $newTaskTitle)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: {
                        if !newTaskTitle.trimmingCharacters(in: .whitespaces).isEmpty {
                            taskManager.addTask(newTaskTitle)
                            newTaskTitle = ""
                        }
                    }) {
                        Text("Add")
                    }
                }
                .padding()
                
                List {
                    ForEach(taskManager.tasks) { task in
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .onTapGesture {
                                    taskManager.toggleTask(task)
                                }
                            
                            Text(task.title)
                                .strikethrough(task.isCompleted)
                        }
                    }
                    .onDelete(perform: taskManager.deleteTask)
                }
            }
            .navigationTitle("Tasks")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
