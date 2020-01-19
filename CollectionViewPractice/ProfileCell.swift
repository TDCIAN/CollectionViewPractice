//
//  ProfileCell.swift
//  CollectionViewPractice
//
//  Created by APPLE on 2020/01/19.
//  Copyright © 2020 JeongminKim. All rights reserved.
//

import UIKit

// 콜렉션뷰에 들어갈 셀들의 모양을 결정하는 프로파일셀 클래스
class ProfileCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    // ------ 셀마다 다른 사진들 들어가게 하려면 얘가 있어야 한다
    var image: UIImage? {
        // -> 이미지가 있는지 확인하고 세팅해주는 역할을 하는 didSet. 안전한 언래핑을 위해 쓰인다
        didSet {
            guard let image = image else { return }
            cellImageView.image = image
        }
    }
    // --------------------------------------------
    
    let cellImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "venom")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cellImageView)
        // ** 셀 하나하나의 사이즈를 정할 때 콜렉션뷰 컨트롤러에서 이미 설정해준 것들을 고려하면서 짜라
        cellImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
