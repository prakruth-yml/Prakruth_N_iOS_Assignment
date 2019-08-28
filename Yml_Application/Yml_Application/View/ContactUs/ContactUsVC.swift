import UIKit
import MessageUI

class ContactUsVC: BaseVC {

    @IBOutlet weak var callUsNumber: UILabel!
    @IBOutlet weak var businessEmail: UILabel!
    @IBOutlet weak var followUs: UILabel!
    @IBOutlet weak var locations: UILabel!
    @IBOutlet weak var locationsSiliconValley: UILabel!
    
    var viewModel = ContactUsViewModel()
    
//    var openGMaps = { (urlStr: String) -> Void in
//        self.openApplicationWithURL(urlStr: urlStr)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let callUsTGR = UITapGestureRecognizer(target: self, action: #selector(didPressCallUs(_:)))
        let emailTGR = UITapGestureRecognizer(target: self, action: #selector(didPressEmail(_:)))
        let followUsTGR = UITapGestureRecognizer(target: self, action: #selector(didPressFollowUs(_:)))
        let locationsTGR = UITapGestureRecognizer(target: self, action: #selector(didPressLocations(_:)))
        let locationsSVTGR = UITapGestureRecognizer(target: self, action: #selector(didPressLocationsSV(_:)))
        locationsSiliconValley.addGestureRecognizer(locationsSVTGR)
        callUsNumber.addGestureRecognizer(callUsTGR)
        businessEmail.addGestureRecognizer(emailTGR)
        followUs.addGestureRecognizer(followUsTGR)
        locations.addGestureRecognizer(locationsTGR)
        
        showAlert(alertTitle: "Hello", message: "Hello", actionTitle: "Close", actionStyle: .cancel)
    }
    
    @objc func didPressCallUs(_ sender: UITapGestureRecognizer){
        
        guard let number = callUsNumber else { fatalError() }
        openApplicationWithURL(urlStr: "tel://\(number.text ?? "973926767")")
    }
    
    @objc func didPressEmail(_ sender: UITapGestureRecognizer){
        
//        let mailComposer = MFMailComposeViewController()
//        mailComposer.mailComposeDelegate = self
//        mailComposer.setToRecipients(["prakruth.bcbs@gmail.com"])
//        mailComposer.setSubject("Test")
//        mailComposer.setMessageBody("Test", isHTML: false)
//        if MFMailComposeViewController.canSendMail(){
//            self.navigationController?.pushViewController(mailComposer, animated: true)
//        }
//        else{
//        
//        }
        let email = "prakruth.bcbs@gmail.com"
        openApplicationWithURL(urlStr: "mailto:\(email)")
    }
    
    @objc func didPressFollowUs(_ sender: UITapGestureRecognizer){
        openApplicationWithURL(urlStr: "fb://profile/prakruth.nagaraj")
    }
    
    @objc func didPressLocations(_ sender: UITapGestureRecognizer){
        let actionArray = [UIAlertAction(title: "Google Maps", style: .default, handler:{ (alert: UIAlertAction?) -> Void in
            print("IN GMAS")
            let temp = self.viewModel.getBangalore()
            self.openApplicationWithURL(urlStr: "comgooglemaps://center=\(temp.latitude),\(temp.longitude)&zoom=14")
        }), UIAlertAction(title: "Apple Maps", style: .default, handler: { (alert: UIAlertAction?) -> Void in
            print("IN APM")
            let temp = self.viewModel.getBangalore()
            self.openApplicationWithURL(urlStr: "http://maps.apple.com/maps?daddr=\(temp.latitude),\(temp.longitude)")
        })]
        showAlert(alertTitle: "Get Directions", message: "Your Choice?",  actionStyle: .default, alertActionArray: actionArray)
    }
    
    @objc func didPressLocationsSV(_ sender: UITapGestureRecognizer){
        let actionArray = [UIAlertAction(title: "Google Maps", style: .default, handler: { (alert: UIAlertAction?) -> Void in
            let temp = self.viewModel.getLa()
            self.openApplicationWithURL(urlStr: "comgooglemaps://center=\(temp.latitude),\(temp.longitude)&zoom=14")
        }), UIAlertAction(title: "Apple Maps", style: .default, handler: { (alert: UIAlertAction?) -> Void in
            print("IN APM")
            let temp = self.viewModel.getLa()
            self.openApplicationWithURL(urlStr: "http://maps.apple.com/maps?daddr=\(temp.latitude),\(temp.longitude)")
        })]
        showAlert(alertTitle: "Get Directions", message: "Your Choice?",  actionStyle: .default, alertActionArray: actionArray)
    }
    
    //Function to make API call to Google. Returns json response with the lats and longs
    func getLatLongFromString(addr: String){
        var urlComponents = URLComponents(string: "https://maps.googleapis.com/maps/api/geocode/json")
        let appKeyQuery = URLQueryItem(name: "key", value: AppDelegate.googleMapsApiKey)
        let countryQuery = URLQueryItem(name: "address", value: addr)
        urlComponents?.queryItems = [appKeyQuery, countryQuery]
        
        guard let apiUrl = urlComponents?.url else { fatalError("No Url") }
        let task = URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            guard let data = data else { fatalError("Error") }
            guard let jsonResponse = (try? JSONSerialization.jsonObject(with: data)) as? [String : Any] else { fatalError("No Response") }
            print(jsonResponse)
//            guard let results = jsonResponse["results"] as? [[String : Any]] else { fatalError("No results") }
            guard let geometry = jsonResponse["geometry"] as? [String : Any] else { fatalError("No Geometry") }
            print("*************************")
            print(geometry)
            guard let location = geometry["location"] as? [String : Any] else { fatalError("No location") }
            print("*************************")
            print(location)
        }
        task.resume()
    }
}

extension ContactUsVC {
    
    func showMaps(latitude: Double, longitude: Double, name: String){
//        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: MapViewVC.self)) as? MapViewVC{
//            viewController.latitute = latitude
//            viewController.longitude = longitude
//            viewController.name = name
//            self.navigationController?.pushViewController(viewController, animated: true)
//        }
        
        
    }
    
    func showAlert(alertTitle: String, message: String, actionTitle: String, actionStyle: UIAlertAction.Style){
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: actionStyle, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(alertTitle: String, message: String, actionStyle: UIAlertAction.Style, alertActionArray: [UIAlertAction]) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .actionSheet)
        for item in alertActionArray{
            alert.addAction(item)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func openApplicationWithURL(urlStr: String){
        guard let url = URL(string: urlStr) else { fatalError() }
        let application = UIApplication.shared
        if application.canOpenURL(url){
            application.open(url, options: [:], completionHandler: nil)
        }
        else{
            showAlert(alertTitle: "Oops!!!", message: "Couldn't Open the Application", actionTitle: "Close", actionStyle: .cancel)
        }
    }
}

extension ContactUsVC: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
