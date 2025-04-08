//
//  XETextField.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI

// A custom text field view with optional endpoint-based data fetching and dropdown suggestions
struct XETextField: View {
    
    var title: String
    var placeholder: String
    var keyboardType: UIKeyboardType = .default
    var endpoint: String? // Optional endpoint for fetching data when text changes
    
    @StateObject private var viewModel: XETextFieldViewModel // ViewModel handling data fetching and validation
    
    @Binding var text: String
    @Binding var isSelected: Bool
    
    @FocusState private var isFocused: Bool //Observe where user touches (outside/inside the field)
    @State var lastSelectedText:String = ""
    
    //Initialize in order to pass endpoint to viewModel
    init(title: String, placeholder: String, keyboardType: UIKeyboardType = .default, text: Binding<String>, endpoint: String? = nil, isSelected: Binding<Bool>) {
        
        self.title = title
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.endpoint = endpoint
        
        _viewModel = StateObject(wrappedValue: XETextFieldViewModel(endpoint: endpoint ?? ""))
        
        self._text = text
        self._isSelected = isSelected
        
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {

            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .focused($isFocused) // Bind the field's focus state
                .onChange(of: text) { _, newValue in
                    
                    //Location is not selected if text changed
                    if endpoint != nil {
                       
                        if newValue != lastSelectedText {
                            viewModel.fetchData(query: newValue)
                            isSelected = false
                        }
                        
                    }
                
                }
                .onSubmit {
                    
                    // Validate selection only when there's an endpoint and the selection hasn't been made
                    if endpoint != nil && !isSelected {
                        text = viewModel.validateAndSetSelection(query: text)
                    }
                }
                .onChange(of: isFocused) { _, newFocus in
                    
                    // Validate selection when focus is lost and endpoint exists
                    if !newFocus, endpoint != nil {
                        text = viewModel.validateAndSetSelection(query: text)
                    }
                }
            
            // Show loading indicator while fetching data
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding(.top, 5)
            }
            
            // Show dropdown results if available and text matches criteria
            if viewModel.showResults && !viewModel.locations.isEmpty {
                
                DropdownView(
                    text: $text,
                    showResults: $viewModel.showResults,
                    isSelected: $isSelected,
                    lastSelectedText: $lastSelectedText,
                    results: viewModel.locations.map { DropdownView.ResultItem(text: $0.mainText) }
                )
    
            }
        }
        .padding(.horizontal)
        .alert("Error", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {
                viewModel.showAlert = false
            }
        } message: {
            Text(viewModel.errorMessage ?? "An unknown error occurred.")
        }
    }
    
    // Function to validate the selection from the dropdown
    private func validateSelection() {
        // Validate and finalize the selection using the ViewModel's method
        text = viewModel.validateSelection(query: text)
    }
}

#Preview {
    VStack {
        XETextField(
            title: "Title",
            placeholder: "Type a title",
            text: .constant(""),
            isSelected: .constant(false)
        )
        .padding()
        
        XETextField(
            title: "Location*",
            placeholder: "Enter location",
            text: .constant(""),
            endpoint: APIEndpoints.autocomplete,
            isSelected: .constant(false)
        )
        .padding()
    }
}
