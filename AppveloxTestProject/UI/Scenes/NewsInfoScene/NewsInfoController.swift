import UIKit
import SnapKit

public final class NewsInfoController: BaseController {
    public var viewModel: NewsInfoViewModelProtocol!
}

extension NewsInfoController {
    override func setupSelf() {
        super.setupSelf()
        
        view.backgroundColor = .green
    }
    
    override func addSubviews() {
        super.addSubviews()
   
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
    
    }
}

// MARK: - NewsInfoControllerProtocol
extension NewsInfoController: NewsInfoControllerProtocol {
 
}

// MARK: - Actions
extension NewsInfoController {

}


private extension NewsInfoController{

}


