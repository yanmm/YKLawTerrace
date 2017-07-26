//
//  YKNotaryApplyTwoController.swift
//  YKProject
//
//  Created by Yuki on 2016/12/8.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKNotaryApplyTwoController: YKPhotoTableViewController,YKSelectedDelegate,UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var stuffTextField: UITextField!
    @IBOutlet weak var useTextField: UITextField!
    @IBOutlet weak var nextBtn: IBDesignableButton!
    @IBOutlet weak var collectView: UICollectionView!
    @IBOutlet weak var selectHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var footerView: UIView!
    fileprivate var lastSelectMoldels: [ZLSelectPhotoModel] = []
    fileprivate var arrDataSources: [UIImage] = []
    fileprivate var cellArray: [String] = []
    fileprivate var browseVC = ImageBrowseVC()
    fileprivate var minHeight: CGFloat = 134
    var notary_id = 0 // 记录ID值
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorColor = UIColor(hex6: 0xE9E9E9)
        cellArray.append("提交有关材料类型")
        nextBtn.isEnabled = false
        nextBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
        
        itemTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        itemTextField.leftViewMode = UITextFieldViewMode.always
        itemTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        itemTextField.rightViewMode = UITextFieldViewMode.always
        itemTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        stuffTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        stuffTextField.leftViewMode = UITextFieldViewMode.always
        stuffTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        stuffTextField.rightViewMode = UITextFieldViewMode.always
        stuffTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        useTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        useTextField.leftViewMode = UITextFieldViewMode.always
        useTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        useTextField.rightViewMode = UITextFieldViewMode.always
        useTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
//        tap.delegate = self
//        tableView.addGestureRecognizer(tap)
        initCollectionView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideKeyBoard()
    }
    
    /// 选择图片
    @IBAction func chooseImage(_ sender: UIButton) {
        hideKeyBoard()
        let view = YKAlertView.initView(NSLocalizedString("title.PhotoVC.SelectOperation", comment: ""), message: nil, style: YKAlertViewStyle.actionSheet)
        view.addButton(NSLocalizedString("title.PhotoVC.PhotoAlbum", comment: ""), style: YKButtonStyle.normal, color: YKButtonColor.normal) {
            let actionSheet = ZLPhotoActionSheet()
            //设置照片最大选择数
            actionSheet.maxSelectCount = 3 - self.arrDataSources.count
            actionSheet.showPhotoLibrary(withSender: self, last: self.lastSelectMoldels) { (selectPhotos, selectPhotoModels) in
                if self.arrDataSources.count >= 3 {
                    YKProgressHUD.popupError("最多只能选择3张图片")
                    return
                }
                self.arrDataSources.append(contentsOf: selectPhotos)
                let newHeight: CGFloat = (kScreenWidth - 30) / 3  * CGFloat(ceilf(Float(self.arrDataSources.count) / 3.0)) + 10
                self.selectHeightConstraint.constant = 44 + newHeight
                self.footerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: self.minHeight + newHeight)
                self.collectView.reloadData()
                self.tableView.reloadData()
            }
        }
        view.addButton(NSLocalizedString("title.PhotoVC.TakingPictures", comment: ""), style: YKButtonStyle.normal, color: YKButtonColor.normal) {
            if self.arrDataSources.count >= 3 {
                YKProgressHUD.popupError("最多只能选择3张图片")
                return
            }
            self.presentCamera()
        }
        view.addButton(NSLocalizedString("alert.cancel", comment: ""), style: YKButtonStyle.cancel, color: YKButtonColor.normal, handler: nil)
        view.showView()
    }
    
    /// 初始化照片cell
    func initCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (kScreenWidth - 30 - 9 ) / 3, height: (kScreenWidth - 30 - 9 ) / 3)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        layout.sectionInset = UIEdgeInsetsMake(3, 0, 3, 0)
        collectView.collectionViewLayout = layout
        collectView.backgroundColor = UIColor.white
        collectView.register(UINib(nibName: "ZLCollectionCell", bundle: Bundle(for:object_getClass(self))), forCellWithReuseIdentifier: "ZLCollectionCell")
    }
    
    /// 隐藏键盘
    func hideKeyBoard() {
        self.view.endEditing(true)
    }
    
    /// 检测textField
    func checkTextField() {
        if itemTextField.text?.characters.count != 0 &&
            stuffTextField.text?.characters.count != 0 &&
            useTextField.text?.characters.count != 0 &&
            cellArray.count > 1 {
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = UIColor(hex6: 0x54ACEB)
        } else {
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
        }
    }
    
    @IBAction func nextBtnClick(_ sender: UIButton) {
        hideKeyBoard()
        if arrDataSources.count == 0 {
            YKProgressHUD.popupError("至少上传一张图片")
            return
        }
        var array = cellArray
        array.removeFirst()
        if let with_notary_items = itemTextField.text, let submit_stuff1 = stuffTextField.text, let with_use_place = useTextField.text {
            YKHttpClient.shared.notaryApplyTwo(self.notary_id, with_notary_items: with_notary_items, submit_stuff1: submit_stuff1, with_use_place: with_use_place, submit_stuff: array, attachment: self.arrDataSources, completionHandler: { (id, error) in
                if let id = id {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotaryApplyThreeID") as! YKNotaryApplyThreeController
                    vc.title = "公证办理(3)"
                    vc.notary_id = id
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.showAlert(error: error)
                }
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrDataSources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZLCollectionCell", for: indexPath) as! ZLCollectionCell
        cell.btnSelect.isHidden = true
        cell.imageView.image = arrDataSources[indexPath.row]
        cell.imageView.contentMode = UIViewContentMode.scaleAspectFill
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hideKeyBoard()
        browseVC.imageArray = arrDataSources
        browseVC.imageIndex = indexPath.item
        browseVC.imageDelete = { (index) in
            self.arrDataSources.remove(at: hex2dec("\(index)"))
            let newHeight: CGFloat = (kScreenWidth - 30) / 3  * CGFloat(ceilf(Float(self.arrDataSources.count) / 3.0)) + 10
            self.selectHeightConstraint.constant = self.arrDataSources.count != 0 ? 44 + newHeight : 44
            self.footerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: self.minHeight + newHeight)
            self.tableView.reloadData()
            self.collectView.reloadData()
        }
        self.navigationController?.pushViewController(browseVC, animated: true)
    }
    
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if self.arrDataSources.count >= 3 {
                YKProgressHUD.popupError("最多只能选择3张图片")
                return
            }
            self.arrDataSources.append(image)
            let newHeight: CGFloat = (kScreenWidth - 30) / 3  * CGFloat(ceilf(Float(self.arrDataSources.count) / 3.0)) + 10
            self.selectHeightConstraint.constant = 44 + newHeight
            self.footerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: self.minHeight + newHeight)
            self.collectView.reloadData()
            self.tableView.reloadData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lawApplyTwoCell", for: indexPath) as! YKLawApplyTwoCell
        if indexPath.row == 0 {
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        } else {
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        cell.bindData(cellArray[indexPath.row], indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            hideKeyBoard()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectedID") as! YKSelectedController
            vc.title = "提交有关材料类型"
            vc.isSimple = false
            vc.titleArray = ["身份证","军官证","居民户口簿","护照","结婚证","离婚证","离婚协议","亲属关系证明","出生证明","死亡证明","无犯罪记录证明","健康证明","委托书","声明书","房屋所有权证","土地使用权证","存折","存单","股权证","照片","合同（协议）文本","（高中）毕业证书","（大中专）毕业证书","高中成绩单","（大中专）成绩单","其它证明材料"]
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //让分割线和文字对齐
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let left: CGFloat = indexPath.row == cellArray.count - 1 ? 0 : 15
        cell.separatorInset = UIEdgeInsets.init(top: 0, left: left, bottom: 0, right: 0)
        cell.layoutMargins = UIEdgeInsets.init(top: 0, left: left, bottom: 0, right: 0)
        cell.preservesSuperviewLayoutMargins = false
    }
    
    /// YKSelectedDelegate
    func chooseSuccess(_ selected: [YKSelectedModel], index: Int) {
        cellArray.removeAll()
        cellArray.append("提交有关材料类型")
        for selec in selected {
            cellArray.append(selec.title)
        }
        if cellArray.count > 1 {
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = UIColor(hex6: 0x58ADE8)
        }
        tableView.reloadData()
    }
    
    /// UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print(NSStringFromClass((touch.view?.classForCoder)!))
        if NSStringFromClass((touch.view?.classForCoder)!) == "UITableViewCellContentView" {
            return false
        }
        return true
    }
}
