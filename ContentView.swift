//
//  ContentView.swift
//  todolist
//
//  Created by Reze on 4/17/26.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    var name: String
    var checked: Bool
}

struct ContentView: View {
    @State var items: [Item] = [
        .init(name: "아침 운동하기", checked: false),
        .init(name: "프로젝트 기획안 작성", checked: false),
        .init(name: "장보기", checked: true),
        .init(name: "친구와 저녁 약속", checked: false),
        .init(name: "책 읽기", checked: false),
        .init(name: "이메일 확인하기", checked: true),
        .init(name: "주간 보고서 작성", checked: false),
    ]
        
    
    var body: some View {
        HStack {
            Text("오늘의 할 일")
                .bold()
                .foregroundStyle(Color.blue)
                .padding(.leading, 25)
                .font(.system(size: 20))
            
            Spacer()
            
            Text(Date(), style: .date)
                .foregroundStyle(Color.gray)
                .padding(.trailing, 25)
        }
        
        ScrollView {
            ForEach(items.indices, id: \.self) { index in
                HStack {
                    Button {
                        items[index].checked.toggle()
                    } label: {
                        Image(systemName: items[index].checked ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(items[index].checked ? Color.gray : .blue)
                            .font(.system(size: 20))
                    }
                    
                    Text(items[index].name)
                        .foregroundColor(items[index].checked ? Color.gray : .black)
                    
                    Spacer()
                    
                    Button {
                        items.remove(at: index)
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(Color.red)
                    }
                }
                .padding()
            }
        }
        .padding()
        
        VStack{
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    items.append(Item(name: "새 할일", checked: false))
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                            .frame(width: 64, height: 64)
                        
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
