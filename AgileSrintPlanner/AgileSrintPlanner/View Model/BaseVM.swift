import UIKit
import Firebase
import FirebaseDatabase
import FirebaseUI

class BaseVM {
    typealias SuccessHandler = ((_ error: Error?) -> Void)
    typealias SnapshotResponse = ((_ response: DataSnapshot) -> Void)
    typealias BaseCompletionHandler = (() -> Void)
    typealias ErrorCompletionHandler = ((Error?) -> Void)
}
