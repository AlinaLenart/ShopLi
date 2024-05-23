import Foundation
import SwiftUI

struct RenameListView: View {
    @ObservedObject var viewModel: ListDetailsViewModel
    
    var body: some View {
        VStack {
            Text("Rename List")
                .font(.headline)
            
            TextField("Enter new name", text: $viewModel.newName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Button("Cancel") {
                    viewModel.showRenameSheet = false
                }
                .foregroundColor(.red)
                
                Spacer()
                
                Button("Save") {
                    viewModel.renameList(viewModel.newName)
                    viewModel.showRenameSheet = false
                }
            }
            .padding()
        }
    }
}
