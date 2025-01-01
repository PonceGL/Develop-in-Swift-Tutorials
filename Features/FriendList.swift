//
//  FriendList.swift
//  Features
//
//  Created by Ponciano Guevara Lozano on 29/12/24.
//

import SwiftUI
import SwiftData

struct FriendList: View {
    @Query(sort: \Friend.name) private var friends: [Friend]
    @Environment(\.modelContext) private var context
    @State private var newFriend: Friend?
    
    var body: some View {
        NavigationSplitView {
            Group {
                if !friends.isEmpty {
                    List {
                        ForEach(friends) { friend in
                            NavigationLink(friend.name){
                                FriendDetail(friend: friend)
                            }
                        }
                        .onDelete(perform: deleteFriends(indexes:))
                    }
                } else {
                    ContentUnavailableView("Add Friends", systemImage: "person.and.person")
                }
            }
            .navigationTitle("Friends")
            .toolbar {
                ToolbarItem {
                    Button("Add friend", systemImage: "plus", action: addFriend)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .sheet(item: $newFriend) { friend in
                NavigationStack {
                    FriendDetail(friend: friend, isNew: true)
                }
                .interactiveDismissDisabled()
            }
        } detail: {
            Text("Select a friend")
                .navigationTitle("Friend")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func addFriend() {
        let newFriend = Friend(name: "")
        context.insert(newFriend)
        self.newFriend = newFriend
    }
    
    private func deleteFriends(indexes: IndexSet) {
        for index in indexes {
            context.delete(friends[index])
        }
    }
}

#Preview {
    FriendList()
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Empty List") {
    FriendList()
        .modelContainer(for: Friend.self, inMemory: true)
}
