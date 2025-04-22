//
//  ContentView.swift
//  TodolistApps
//
//  Created by irfan wahendra on 19/04/25.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  @State private var searchKeyword: String = ""
  @State private var isSheetPresented: Bool = false
  
  @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Todo.date, ascending: true)], animation: .default)
  private var todos: FetchedResults<Todo>
  
  var body: some View {
    NavigationView {
      List {
        ForEach(filteredTodos, id: \.self) { todo in
          TodoRowView(todo: todo)
        }
        .onDelete(perform: deleteTodo)
      }
      .listStyle(.insetGrouped)
      .navigationTitle("Todo List")
      .searchable(text: $searchKeyword)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            isSheetPresented.toggle()
          }) {
            Image(systemName: "plus")
          }
        }
      }
      .sheet(isPresented: $isSheetPresented) {
        TodoInputForm(isPresented: $isSheetPresented)
          .environment(\.managedObjectContext, viewContext)
      }
    }
  }
  
  private var filteredTodos: [Todo] {
    guard !searchKeyword.isEmpty else {
      return Array(todos)
    }
    
    return todos.filter {
      $0.title?.localizedCaseInsensitiveContains(searchKeyword) == true
    }
  }
  
  private func deleteTodo(at offsets: IndexSet) {
    for index in offsets {
      let todo = filteredTodos[index]
      viewContext.delete(todo)
    }
    
    do {
      try viewContext.save()
    } catch {
      print("❌ Failed to delete: \(error.localizedDescription)")
    }
  }
}

// Create a separate view for each row to simplify the parent view
struct TodoRowView: View {
  @ObservedObject var todo: Todo
  
  var body: some View {
    NavigationLink(destination: TodoDetailView(todo: todo)) {
      HStack(alignment: .center) {
        VStack(alignment: .leading, spacing: 4) {
          Text(todo.title ?? "Untitled")
            .font(.headline)
          
          if let date = todo.date {
            Text(formatDate(date))
              .font(.caption)
              .foregroundColor(.gray)
          }
        }
        
        Spacer()
        
        StatusIndicator(status: todo.status == "completed" ? .completed : .pending)
      }
    }
  }
  
  private func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter.string(from: date)
  }
}

#Preview {
  ContentView()
}
