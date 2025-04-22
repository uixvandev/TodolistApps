//
//  TodoInputForm.swift
//  TodolistApps
//
//  Created by irfan wahendra on 19/04/25.
//

import SwiftUI

struct TodoInputForm: View {
  @EnvironmentObject var manager: DataManager
  @Environment(\.managedObjectContext) var viewContext
  
  @Binding var isPresented: Bool
  @State private var title: String = ""
  @State private var date: Date = Date()
  @State private var status: TodoStatus = .pending
  @State var todo: Todo?
  
  var body: some View {
    NavigationView{
      Form{
        Section{
          TextField("Enter todo title", text: $title)
        } header: {
          Text("Title")
        }
        
        Section{
          DatePicker("Select a date", selection: $date, displayedComponents: .date)
        } header: {
          Text("Date")
        }
        
        Section{
          Picker("Select status", selection: $status) {
            ForEach(TodoStatus.allCases, id: \.self) { status in
              Text(status.rawValue)
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        } header: {
          Text("Status")
        }
      }
      .navigationTitle("New Todo")
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("Cancel") {
            isPresented = false
          }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Save") {
            self.saveTodo(title: title, date: date, status: status.rawValue)
            isPresented = false
          }
        }
      }
      .onAppear{
        if let todo = todo {
          self.title = todo.title!
          self.date = todo.date!
          self.status = todo.status == "completed" ? .completed : .pending
        }
      }
    }
  }
  
  func saveTodo(title: String, date: Date, status: String) {
    let todoSave = todo ?? Todo(context: viewContext)
    if todoSave.id == nil {
      todoSave.id = UUID()
    }
    
    todoSave.title = title
    todoSave.date = date
    todoSave.status = status
    
    do {
      try self.viewContext.save()
      print("Todo saved successfully")
    } catch {
      print("Whoops \(error.localizedDescription)")
    }
  }
}

#Preview {
  TodoInputForm(isPresented: .constant(false))
}
