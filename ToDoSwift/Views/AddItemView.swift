//
//  AddItemView.swift
//  ToDoSwift
//
//  Created by Dmitry Grigorev on 08.01.2023.
//

import SwiftUI

struct AddItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""

    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView{
            VStack {
                TextField("Type something here", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(.lightGray))
                .cornerRadius(10)
                
                Button(action: {
                    if textIsValid() {
                        listViewModel.createItem(newItemTitle: textFieldText)
                        presentationMode.wrappedValue.dismiss() // back to prev screen
                    } else {
                        alertTitle = "New item title must be at least 3 chars and non whitespaces only"
                        showAlert.toggle()
                    }
                }, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(14)
        }
        .navigationTitle("Add an item ")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func textIsValid() -> Bool {
        if textFieldText.count < 3 || textFieldText.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddItemView()
        }
        .environmentObject(ListViewModel())
    }
}
