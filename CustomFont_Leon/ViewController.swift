//
//  ViewController.swift
//  CustomFont_Leon
//
//  Created by lai leon on 2017/8/20.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit

/*
 导入字体步骤：
 1.下载ttf文件，加入项目中
 2.在info.plist中，添加一个字段：Fonts provided by application
 3.再添加item，值写入字体的名字
 4.然后就可以通过名字使用了
 */

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView(frame: CGRect(x: 0.0, y: 0.0, width: YHScreenWidth, height: YHScreenHeight * 2 / 3), style: .plain)
    let button = UIButton(frame: CGRect(x: 0.0, y: YHScreenHeight * 2 / 3, width: YHScreenWidth, height: YHScreenHeight / 3))
    let data = ["点击一下改变字体，", "字体就会改变，", "你相信不，", "不相信么，", "点一下试试吧😊！"]
    let fontNames = ["MFTongXin_Noncommercial-Regular", "MFJinHei_Noncommercial-Regular", "MFZhiHei_Noncommercial-Regular", "Heiti SC"]
    var fontNumber = 0
    let reuseIdentifier = "FontCell"


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .cyan

        button.setTitle("改变字体", for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(changeFont), for: .touchUpInside)

        view.addSubview(tableView)
        view.addSubview(button)
    }

    func changeFont() {
        fontNumber = (fontNumber + 1) % fontNames.count
        print(fontNumber)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - delegate and dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*代码创建，并且没有注册cell的情况下，用dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell?
         如果已经注册了，或者用的xib，就使用dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell
         */
        //??空合运算符，a ?? b，对可选类型a进行判断，为nil默认值为b，不为空就解封

        //style 设置了默认的样式
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ??
                UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        let text = data[indexPath.row]

        cell.textLabel?.text = text
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: fontNames[fontNumber], size: 24)
        cell.backgroundColor = .black
        print(fontNames[fontNumber])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return YHScreenHeight * 2 / 3 / CGFloat(data.count)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //取消点击效果
        tableView.deselectRow(at: indexPath, animated: false)
        let cell = tableView.cellForRow(at: indexPath)
        //链式调用，最后得到一个可选的string,！强制解包出来
        let str = (cell?.textLabel?.font.fontName)!

        let alertController = UIAlertController(title: "字体提示",
                message: "现在您使用的字体是：" + str, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
