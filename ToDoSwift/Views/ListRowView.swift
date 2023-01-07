//
//  ListRowView.swift
//  ToDoSwift
//
//  Created by Dmitry Grigorev on 07.01.2023.
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var firstItem: ItemModel = ItemModel(title: "First preview item", isCompleted: false)
    static var secondItem: ItemModel = ItemModel(title: "Second preview item", isCompleted: true)
    
    static var previews: some View {
        Group{
            ListRowView(item: firstItem)
            ListRowView(item: secondItem)
        }
        .previewLayout(.sizeThatFits)
    }
}
