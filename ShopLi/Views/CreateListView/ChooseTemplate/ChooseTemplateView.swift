import Foundation
import SwiftUI

struct ChooseTemplateView: View {
    @StateObject var viewModel: ChooseTemplateViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
            NavigationView {
                VStack {
                    List {
                        ForEach(viewModel.package.lists) { list in
                            HStack {
                                Image(systemName: viewModel.selectedListID == list.id ? "checkmark.circle.fill" : "circle")
                                    .onTapGesture {
                                        viewModel.selectList(list)
                                    }
                                Text(list.name)
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())

                    Button(action: {
                        viewModel.duplicateSelectedList(package: viewModel.package)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Continue")
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(viewModel.selectedListID == nil ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                    .disabled(viewModel.selectedListID == nil)
                }
                .navigationBarTitle("Select List to Duplicate", displayMode: .inline)
            
            }
        }
}
