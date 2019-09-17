import UIKit

class StoriesDescriptionVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var storyDetails: Story?
    var viewModel = ProductBacklogsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = storyDetails?.title
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let storyDetails = storyDetails else { return }
        
        viewModel.dataSrc = ["Story", storyDetails.summary, storyDetails.description, storyDetails.platform, storyDetails.status]
    }
}

extension StoriesDescriptionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StoryDescriptionTVCell.self), for: indexPath) as? StoryDescriptionTVCell else { return StoryDescriptionTVCell() }
        
        cell.titleLabel.text = viewModel.displayTitle[indexPath.row]
        cell.descpLabel.text = viewModel.dataSrc?[indexPath.row]
        if cell.titleLabel.text == "Status" {
            if viewModel.dataSrc?[indexPath.row] != "Done" {
                cell.backgroundColor = .red
                cell.descpLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            } else {
                cell.backgroundColor = .white
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
