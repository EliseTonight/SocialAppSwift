//
//  SearchView.swift
//  IMxyb
//
//  Created by Elise on 16/5/9.
//  Copyright © 2016年 Elise. All rights reserved.
//  搜索控制器

import UIKit

protocol SearchViewDelegate: NSObjectProtocol {
    func searchView(_ searchView: SearchView, searchTitle: String)
}

class SearchView: UIView {
    /// 动画时长
    fileprivate let animationDuration = 0.5
    var searchTextField: SearchTextField!
    var searchBtn: UIButton!
    /// 是否已经缩放过
    fileprivate var isScale: Bool = false
    weak var delegate: SearchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        searchTextField = SearchTextField()
        let margin: CGFloat = 20
        searchTextField.frame = CGRect(x: margin, y: 20 * 0.5, width: AppWidth - 2 * margin, height: 30)
        searchTextField.delegate = self
        addSubview(searchTextField)
        
        searchBtn = SearchButton(frame: CGRect(x: AppWidth - 100, y: 0, width: 100, height: 50), target: self, action: "searchBtnClick:")
        
        addSubview(searchBtn)
        
        // 监听键盘弹出
        NotificationCenter.default.addObserver(self, selector: "keyBoardWillshow", name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func keyBoardWillshow() {
        
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.searchBtn.alpha = 1
            self.searchBtn.isSelected = false
            if !self.isScale {
                self.searchTextField.frame.size.width = self.searchTextField.width - 60
                self.isScale = true
            }
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    func resumeSearchTextField() {
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            if self.isScale {
                self.searchBtn.alpha = 0
                self.searchBtn.isSelected = false
                self.searchTextField.frame.size.width = self.searchTextField.width + 60
                self.isScale = false
            }
        })
    }
    
    func searchBtnClick(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            searchTextField.becomeFirstResponder()
        } else if searchTextField.text!.isEmpty {
            return
        } else {
            sender.isSelected = true
            if delegate != nil {
                delegate!.searchView(self, searchTitle: searchTextField.text!)
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text!.isEmpty {
            return false
        }
        
        searchBtnClick(searchBtn)
        return true
    }
}
