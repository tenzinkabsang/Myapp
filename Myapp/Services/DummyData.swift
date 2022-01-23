
import Foundation
import Firebase




func addDummyData() {
    let db = Firestore.firestore()
    
    db.collection("users")
        .addDocument(data: [
            "email": "test1@gmail.com",
            "profileImageUrl": "https://avatars.githubusercontent.com/u/1808150?s=400&u=56f519596ffe7ab040c50ffd1e0a9ad546353bef&v=4",
            "username": "Michael",
            "location": [ "latitude": "36.114647", "longitude": "-115.172813" ]])
    
    
}
