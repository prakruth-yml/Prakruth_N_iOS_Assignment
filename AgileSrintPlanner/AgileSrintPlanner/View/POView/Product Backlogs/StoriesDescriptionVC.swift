import UIKit

class StoriesDescriptionVC: BaseVC {
    
    @IBOutlet private weak var tableView: UITableView!
    
    weak var viewModel: ProductBacklogsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = viewModel?.currentStory?.title
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.setStoryDescpDataSrc()
    }
}

extension StoriesDescriptionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.displayTitle.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StoryDescriptionTVCell.self), for: indexPath) as? StoryDescriptionTVCell else { return StoryDescriptionTVCell() }
        
        cell.titleLabel.text = viewModel?.displayTitle[indexPath.row]
        cell.descpLabel.text = viewModel?.dataSrc?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
