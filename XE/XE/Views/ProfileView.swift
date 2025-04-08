//
//  ProfileView.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI
import PhotosUI
import SwiftData

struct ProfileView: View {
    
    @Environment(\.modelContext) private var modelContext // Access to the model context for saving data
    @Query private var profiles: [ProfileItem] // Query to fetch the profile items

    @State private var selectedItem: PhotosPickerItem? = nil // Holds the selected photo picker item
    @State private var showPhotoPicker = false // Flag to show photo picker

    @State private var vm = ProfileViewModel() // ViewModel for profile data

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 30) {
                Group {
                    // Display profile image or default image if none exists
                    if let image = vm.profileUIImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                .shadow(radius: 10)
                .onTapGesture { if vm.isEditing { showPhotoPicker = true } }
                .photosPicker(isPresented: $showPhotoPicker, selection: $selectedItem, matching: .images)
                .onChange(of: selectedItem) { _, newItem in
                    // Load the selected image
                    if let item = newItem {
                        Task {
                            if let data = try? await item.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                vm.profileUIImage = uiImage
                            }
                        }
                    }
                }

                // Remove photo button if editing and profile image exists
                if vm.isEditing && vm.profileUIImage != nil {
                    Button(role: .destructive) { vm.profileUIImage = nil } label: {
                        Text("Remove Photo").font(.subheadline)
                    }
                }

                // Profile fields for name, year of birth, and gender
                ProfileField(title: "Name:", value: $vm.name, isEditing: vm.isEditing)
                ProfilePicker(selection: $vm.selectedYearOfBirth, title: "Year of Birth:", options: vm.yearsOfBirth, isEditing: vm.isEditing)
                ProfilePicker(selection: $vm.selectedGender, title: "Gender:", options: vm.genders, isEditing: vm.isEditing)

                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
            .navigationBarItems(trailing: Button(action: {
                // Toggle edit/save state and save the profile if in editing mode
                if vm.isEditing {
                    vm.save(to: modelContext, existingProfile: profiles.first)
                }
                vm.isEditing.toggle()
            }) {
                Text(vm.isEditing ? "Save" : "Edit")
                    .font(.headline)
                    .foregroundColor(Color("XEColor"))
            })
        }
        .onAppear {
            vm.load(from: profiles.first)
        }
    }
}

#Preview {
    ProfileView()
}
