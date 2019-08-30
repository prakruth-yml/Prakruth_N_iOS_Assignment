class AboutUsVM{
    
    var imageNames: [ImageCVData] = []
    var gridLayoutData: [GridsCVData] = []
    
    func getImageNames(){
        imageNames = [ImageCVData(imageName: "about1"), ImageCVData(imageName: "about2"), ImageCVData(imageName: "about3"), ImageCVData(imageName: "about4")]
    }
    
    func getGridCVData() {
        gridLayoutData = [GridsCVData(imageName: "icons_client", label: "Our Clients"), GridsCVData(imageName: "icons_expertise", label: "Our Expertise"), GridsCVData(imageName: "icons_directors", label: "The Leaders"), GridsCVData(imageName: "icons_locations", label: "We are At...")]
    }
}
