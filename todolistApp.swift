import SwiftUI
import Combine

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}

class TodoViewModel: ObservableObject {
    @Published var todos: [TodoItem] = [
        .init(title: "아침 운동하기", isCompleted: false),
        .init(title: "프로젝트 기획안 작성", isCompleted: false),
        .init(title: "장보기", isCompleted: true),
        .init(title: "친구와 저녁 약속", isCompleted: false),
        .init(title: "책 읽기", isCompleted: false),
        .init(title: "이메일 확인하기", isCompleted: true),
        .init(title: "주간 보고서 작성", isCompleted: false)
    ]
    
    func toggle(_ item: TodoItem) {
        guard let i = todos.firstIndex(where: { $0.id == item.id }) else { return }
        todos[i].isCompleted.toggle()
    }
    
    func add() {
        todos.append(.init(title: "새 항목", isCompleted: false))
    }
    
    func delete(_ item: TodoItem) {
        todos.removeAll { $0.id == item.id }
    }
}

struct ContentView: View {
    @StateObject private var vm = TodoViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("오늘의 할 일").font(.title2).bold()
                    Spacer()
                    Text("오늘 날짜").foregroundColor(.gray).font(.subheadline)
                }.padding()
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(vm.todos) { item in
                            row(item)
                        }
                    }.padding()
                }
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: vm.add) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.title2)
                            .frame(width: 50, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
        }
        .background(Color(.systemGray6))
    }
    
    private func row(_ item: TodoItem) -> some View {
        HStack {
            Button {
                vm.toggle(item)
            } label: {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(item.isCompleted ? .gray : .blue)
                    .font(.title3)
            }
            
            Text(item.title)
                .foregroundColor(item.isCompleted ? .gray : .primary)
                .strikethrough(item.isCompleted)
            
            Spacer()
            
            Button {
                vm.delete(item)
            } label: {
                Image(systemName: "trash").foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#Preview {
    ContentView()
}
