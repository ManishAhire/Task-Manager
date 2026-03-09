//
//  TaskManager.swift
//  Task Manager
//
//  Created by Manish Ahire on 09/03/26.
//

import Foundation

class TaskManager: ObservableObject {
    
    @Published var tasks: [Task] = []
    
    private let tasksKey = "SavedTasks"
    
    init() {
        loadTasks()
    }
    
    func addTask(_ title: String) {
        let newTask = Task(title: title)
        tasks.append(newTask)
        saveTasks()
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTasks()
    }
    
    func toggleTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            saveTasks()
        }
    }
    
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }
    }
    
    private func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: tasksKey),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            self.tasks = decoded
        }
    }
}
