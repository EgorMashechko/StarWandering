

import UIKit

//MARK: Delegate
protocol ResultsViewDelegate: AnyObject {
    func didUserTapDone(_ view: ResultsView)
}

class ResultsView: UIView {
    
//MARK: Properties
    private var cellID = "id"
    @IBOutlet var resultsTableView: UITableView!
    private var results: [Result]? {
        ResultsManager.shared.results?.sorted(by: { (first, second) -> Bool in
            return first.value > second.value
        })
    }
    weak var delegate: ResultsViewDelegate?
    
//MARK: Initialization
    override func awakeFromNib() {
        setupTableView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//MARK: Methods
    private func setupTableView() {
        resultsTableView.backgroundColor = .clear
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.tableFooterView = UIView()
        resultsTableView.register(UINib(nibName: "ResultsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellID)
    }
    
    @IBAction func onDoneButton(_ sender: Any) {
        delegate?.didUserTapDone(self)
    }
}

//MARK: TableView delegate/data source
extension ResultsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let resultCell = cell as? ResultsTableViewCell else  {return cell}
        guard let result = results?[indexPath.row] else {return cell}
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyyMd")
        resultCell.dateLabel.text = dateFormatter.string(from: result.date)
        resultCell.scoreValueLabel.text = String(result.value)
        return resultCell
    }
    
}
