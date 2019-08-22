
class OnboardScreenData {
    
    let bgImageName: String
    let productLogoName: String
    let productTitleName: String
    let productDescriptionName: String
    
    init(bgName: String, productLogo: String, productTitle: String, productDesc: String){
        self.bgImageName = bgName
        self.productLogoName = productLogo
        self.productTitleName = productTitle
        self.productDescriptionName = productDesc
    }
    
    static func initValues() -> [OnboardScreenData] {
        
        return[OnboardScreenData(bgName: "", productLogo: "", productTitle: "Hello", productDesc: "We are a design and innovation agency, creating digital products and experiences that have a lasting impact."), OnboardScreenData(bgName: "mobile-70", productLogo: "state-farm-logo", productTitle: "State Farm", productDesc: "All things insurance, all things banking, all in one app."), OnboardScreenData(bgName: "home-depot-mobile", productLogo: "thd-logo", productTitle: "The Home Depot", productDesc: "The ultimate power tool: A best-in-class digital experience for The Home Depot."), OnboardScreenData(bgName: "home-mob", productLogo: "paypal-logo", productTitle: "PayPal", productDesc: "Payment giant goes mobile-by-design."), OnboardScreenData(bgName: "molekule-mobile2", productLogo: "molekule", productTitle: "Molekule", productDesc: "he world's first intelligent air purifier, & the app putting clean air in people's hands.")]
    }
}
