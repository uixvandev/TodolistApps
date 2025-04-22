//
//  TodoInputForm.swift
//  TodolistApps
//
//  Created by irfan wahendra on 19/04/25.
//

import SwiftUI

struct TodoDetailView: View {
  @ObservedObject var todo: Todo
  @State var isShowingEditForm: Bool = false
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10){
      Text(todo.title ?? "")
        .font(.title)
      Text(formatDate(todo.date ?? Date()))
        .font(.subheadline)
        .foregroundStyle(.gray)
      StatusIndicator(status: todo.status == "completed" ? .completed : .pending)
    }
    .padding()
    .navigationTitle("Todo Details")
    .toolbar {
      Button("Edit") {
        isShowingEditForm.toggle()
      }
    }
    .sheet(isPresented: $isShowingEditForm) {
      TodoInputForm(isPresented: $isShowingEditForm, todo: todo)
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
  TodoDetailView(todo: Todo(context: DataManager().container.viewContext))
}
