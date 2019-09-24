import UIKit
import Firebase
import FirebaseDatabase
import FirebaseUI

class BaseVM {
    
    var firebase = FirebaseManager()
    var constraintMultiplier:CGFloat = 0.65
    
    typealias SuccessHandler = ((_ error: Error?) -> Void)
    typealias SnapshotResponse = ((_ response: DataSnapshot) -> Void)
    typealias BaseCompletionHandler = (() -> Void)
    typealias ErrorCompletionHandler = ((Error?) -> Void)
}
