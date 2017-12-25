//
//  TableStyleUICollectionViewLayout.swift
//  CollectionViewLayoutSamples
//
//  Created by 鳥居 隆弘 on 2017/12/25.
//  Copyright © 2017年 mediba. All rights reserved.
//

import UIKit

class TableStyleUICollectionViewLayout: UICollectionViewLayout {

    var cellPadding = CGFloat(8.0)
    
    var cache = [UICollectionViewLayoutAttributes]()
    
    var contentHeight = CGFloat(0.0)
    var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    
    //MARK:- Layout LifeCycle
    /**
     1. レイアウトの事前計算を行う
     */
    override func prepare() {
        super.prepare()
        
        guard cache.isEmpty else{
            return
        }
        
        let columnWidth = contentWidth
        var yOffset: CGFloat = 0
        
        
        //準備する個数
        for item in 0 ..< 80 /*collectionView!.numberOfItems(inSection: 0)*/ {
            
            
            let indexPath = IndexPath(item: item, section: 0)
            
            let height:CGFloat = 100.0
            
            let frame = CGRect(x: CGFloat(0),
                               y: yOffset,
                               width: columnWidth,
                               height: height)
            
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes =  UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset = yOffset + height
            
        }
    }
    
    /**
     2. コンテンツのサイズを返す
     */
    override var collectionViewContentSize : CGSize {
        
        let height = CGFloat(collectionView!.numberOfItems(inSection: 0) * 100)
        
        return CGSize(width: contentWidth, height: height)
    }
    
    /**
     3. 表示する要素のリストを返す
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for (count, attributes) in cache.enumerated() {
            if count >=  collectionView!.numberOfItems(inSection: 0){ break }
            
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        return cache[ indexPath.row ]
    }
    
}




