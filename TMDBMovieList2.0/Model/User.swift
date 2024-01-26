//
//  User.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 19/1/24.
//

import Firebase
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable, Hashable {
    @DocumentID var id: String?
    let username: String
    var fullname: String
    let email: String
    var profileImageUrl: String
    var bio: String?
}

extension User {
    static var Mock_Users = User(username: "test",
                                 fullname: "testing",
                                 email: "test@gmail.com",
                                 profileImageUrl: "www.test.com")
}
