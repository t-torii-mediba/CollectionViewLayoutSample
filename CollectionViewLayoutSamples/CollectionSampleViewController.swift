//
//  CollectionSampleViewController.swift
//  CollectionViewLayoutSamples
//
//  Created by 鳥居 隆弘 on 2017/12/25.
//  Copyright © 2017年 mediba. All rights reserved.
//


import UIKit

class CollectionSampleViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func insertAction(_ sender: Any) {
        insert()
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        delete()
    }
    
    @IBAction func moveAction(_ sender: Any) {
        move()
    }
    
    @IBAction func changeLayoutAction(_ sender: Any) {
        changeLayout()
    }
    
    var data: [ String ] = ["0","1","2","3","4","5","6","7"]
    var layoutFlag: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        //レイアウト
        collectionView.collectionViewLayout = TableStyleUICollectionViewLayout()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CollectionSampleViewController {
    
    func insert(){
        
        data.append("8")
        collectionView.insertItems(at: [IndexPath(item: 2, section: 0)] )
    }
    
    func delete(){
        
        if data.count > 2{
            data.remove(at: 2)
            collectionView.deleteItems(at: [IndexPath(item: 2, section: 0)] )
        }
    }
    
    func move(){
        
        if data.count > 3{
            let tmp = data.remove(at: 2)
            data.insert(tmp, at: 3)
            
            collectionView.moveItem(at: IndexPath(item: 2, section: 0), to: IndexPath(item: 3, section: 0))
        }
    }
    
    func changeLayout(){
        
        if layoutFlag{
            
            /*
             *アニメーションをカスタムする場合は UIView.animate内で
             * collectionViewLayoutをセットする
             */
            UIView.animate(withDuration: 1.0, animations: {
                self.collectionView.collectionViewLayout =
                    UICollectionViewFlowLayout()
                self.collectionView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }, completion: nil)
        }else{

            //デフォルトのアニメーション
            collectionView.setCollectionViewLayout(TableStyleUICollectionViewLayout(), animated: true)
            self.collectionView.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
        layoutFlag = !layoutFlag
    }
}


extension CollectionSampleViewController: UICollectionViewDelegate {
    
    //選択
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}


extension CollectionSampleViewController: UICollectionViewDataSource{
    
    //Cellの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // "Cell" はストーリーボードで設定したセルのID
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath )
        cell.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        return cell
    }
    
    
    //Cellの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}


extension CollectionSampleViewController: UICollectionViewDelegateFlowLayout{
    
    //Cellのサイズ
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 横に２つのCellを入れることを想定して、多少のマージンを入れる
        let cellSize:CGFloat = self.collectionView.frame.size.width / 3 - 15
        
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize )
    }
    
    //ビューのレイアウトを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10.0 , 10.0 , 0.0 , 10.0 )  //マージン(top , left , bottom , right)
    }
    
    //セルの間隔　上下 最低
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}

