
struct OnboardScreenData {
    
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
}
