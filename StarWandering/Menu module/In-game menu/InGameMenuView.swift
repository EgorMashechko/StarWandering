
import UIKit

//MARK: Delegate
protocol InGameMenuViewDelegate: AnyObject {
    func didUserTapContinue(_ view: InGameMenuView)
    func didUserTapMenu(_ view: InGameMenuView)
}

class InGameMenuView: UIView {
    
    weak var delegate: InGameMenuViewDelegate?

//MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

//MARK: Methods
    @IBAction func onContinueButton(_ sender: UIButton) {
        delegate?.didUserTapContinue(self)
    }
    @IBAction func onMenuButton(_ sender: UIButton) {
        delegate?.didUserTapMenu(self)
    }
    
}
