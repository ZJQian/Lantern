//
//  LanternNavigationBar.swift
//  Lantern
//
//  Created by admin on 2023/7/20.
//

import UIKit

class LanternNavigationBar: UIView {

    private var leftItemButtonActionCallback: (() -> Void)?
    
    var titleView: UIView? {
        didSet {
            guard let titleView = titleView else {
                return
            }
            let titleViewHeight = titleView.bounds.size.height
            let titleViewWidth = titleView.bounds.size.width
            let marginTop = (UIScreen.navigation_bar_height - titleViewHeight) / 2.0
            let marginLeft = (UIScreen.width - titleViewWidth) / 2.0
            titleView.frame = CGRect(x: marginLeft, y: UIScreen.status_bar_height + marginTop, width: titleViewWidth, height: titleViewHeight)
            addSubview(titleView)
        }
    }
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.frame = CGRect(x: 60, y: UIScreen.status_bar_height, width: UIScreen.width - 120, height: UIScreen.navigation_bar_height)
        return titleLabel
    }()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var height: CGFloat {
        return UIScreen.navigation_bar_height+UIScreen.status_bar_height
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var leftButton: UIButton = {
        let leftbtn = UIButton()
        leftbtn.contentHorizontalAlignment = .left
        leftbtn.frame = CGRect(x: 15, y: UIScreen.status_bar_height, width: 40, height: UIScreen.navigation_bar_height)
        leftbtn.addTarget(self, action: #selector(leftbtnAction), for: .touchUpInside)
        return leftbtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.status_bar_height + UIScreen.navigation_bar_height)
        x_setLeftBarButtonItem()
        setTitleLabel()
    }
    
    @objc func leftbtnAction() {
        guard let leftItemButtonActionCallback = leftItemButtonActionCallback else {
            return
        }
        leftItemButtonActionCallback()
    }
    
    private func setTitleLabel() {
        addSubview(titleLabel)
    }
    
    func hideLeftButton() {
        leftButton.isHidden = true
    }
    
    func leftItemButtonAction(_ closure: (() -> Void)?) {
        leftItemButtonActionCallback = closure
    }
    
    func x_setLeftBarButtonItem(_ img: UIImage? = UIImage(named: "icon_back_black")) {
        leftButton.setImage(img, for: .normal)
        addSubview(leftButton)
    }
    
    func x_setRightBarButtonItems(_ items: [UIView]?) {
        addSubview(stackView)
        stackView.spacing = 15
        stackView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(UIScreen.status_bar_height)
            make.bottom.equalToSuperview()
        }
        if let tempItems = items {
            tempItems.forEach { view in
                stackView.addArrangedSubview(view)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
